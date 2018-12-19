//
//  ViewController.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import UIKit
import SocketIO


class Main_ViewController: UIViewController {
   
   let manager = SocketManager(socketURL: URL(string: "http://192.168.0.51:8080")!, config: [.log(true), .compress])
   var socket : SocketIOClient!
   var items : [String:[Item]] = [:]
   var itemList : [String: Item] = [:]
   var tables : [Table] = []
   var currentTable : Table?
   var currentCategory : String?
   var categories : [String] = []
   var stage : Int = HOME
   var currentItemId : String?
   var totalArr = ["Paid:0.00", "Total:0", "Change:0"]
   
   
   
   @IBOutlet weak var totalTW: UITableView!
   
//   @IBOutlet weak var totalLabel: UILabel!
   
   @IBOutlet weak var checkOutBtn: UIButton!
   @IBOutlet weak var navbar: UINavigationBar!
   @IBOutlet weak var tableView: UITableView!
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      socket = manager.defaultSocket
//
//      socket.on(clientEvent: .connect) {data, ack in
//         print("socket connected")
//      }
//
//
      socket.on("status") { (data, ack) in
         let dict = data[0] as! [String: AnyObject]
         let message : String = dict["msg"]! as! String
         print(message)
         
         if message == "reload"{
            self.getAllTables()
         }
//         let myJSON = [
//            "msg": "bob"
//         ]
//         self.socket.emit("thankyou",   ["msg":"hello"])
      }

      socket.connect()
      
      getAllItems()
      
      
      setUp()
      loadHomePage()
      self.getAllTables()
      
   }
   
   
   func setUp(){
      self.collectionView.dataSource = self
      self.collectionView.delegate   = self
      self.tableView.dataSource = self
      self.tableView.delegate = self
      self.totalTW.dataSource = self
   }
   @IBAction func goBackNavBtnClicked(_ sender: Any) {
      if (self.stage == ITEMS || self.stage == SIZE || self.stage == CATEGORY){
         self.stage -= 1
         self.collectionView.reloadData()
         
         if (stage == HOME){
            reloadHomePage()
         }
      }else if (self.stage == CHECKOUT){
         self.stage = CATEGORY
         reloadOrdering()
         totalTW.reloadData()
         collectionView.reloadData()
      }
      
   }
   
   func getAllItems(){
      ItemsModel.getAllItems(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
         data, response, error in
         do {
            // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
            

            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
               if let results = jsonResult["data"] as? NSArray {
                  for item in results {
                     let itemDict = item as! NSDictionary
                     if let category = itemDict["catergory"] as? String{
                        let id = itemDict["id"] as? String
                        let name = itemDict["name"] as? String
                        let lrg =  itemDict["lrg"] as? String
                        let med =  itemDict["med"] as? String
                        let newItem = Item(id: id!, name: name! , category: category, lrg: lrg!, med: med!)
                        
                        if self.items[category] != nil {
                           self.items[category]?.append(newItem)
                        }else{
                           self.items[category] = [newItem]
                           self.categories.append(category)
                        }
                        
                        self.itemList[id!] = newItem
                     }
                  }
                  
                  
                  self.categories.sort(by: { (left, right) -> Bool in
                     left < right
                  })
               }
            }
   
         } catch {
            print("Something went wrong")
         }
      })
   }
   
   func getAllTables(){
      TablesModel.getAll(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
         data, response, error in
         do {
            // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
            self.tables.removeAll()
            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
               if let results = jsonResult["data"] as? NSArray {
                  for item in results {
                     let itemDict = item as! NSDictionary
                     var order_id = itemDict["current_order_id"] as? String
                     if order_id == nil{
                        order_id = ""
                     }
                     
                     let newTable = Table(id: itemDict["id"] as! String, name: itemDict["name"] as! String, status: itemDict["status"] as! Int, order_id: order_id!)
                     self.tables.append(newTable)
                     if ((self.currentTable) != nil){
                        if (self.currentTable!.id == newTable.id){
                           self.currentTable = newTable
                        }
                     }
                     
                  }
               }
            }
            
            self.tables.sort(by: { (left, right) -> Bool in
               left.name < right.name
            })
            
            DispatchQueue.main.async {
               self.collectionView.reloadData()
            }
            
         } catch {
            print("Something went wrong")
         }
      })
   }

   @IBAction func checkOutBtnClicked(_ sender: Any) {
      stage = CHECKOUT
      collectionView.reloadData()
      totalTW.reloadData()
      reloadCheckOut()
   }
   
}

