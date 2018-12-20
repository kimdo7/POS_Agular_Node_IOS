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
   var histories: [History] = []
   var ordered_items : [String : OrderItem] = [:]
   var ordered_item_keys : [String ] = []
   var ordered_table : String!
   var order_tw : UITableView!
   
   
   @IBOutlet weak var totalTW: UITableView!
   
//   @IBOutlet weak var totalLabel: UILabel!
   @IBOutlet weak var homeNavBtn: UIBarButtonItem!
   
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
      createOrderTW()
      loadHomePage()
      self.getAllTables()
      
   }
   
   
   
   
   @IBAction func goBackNavBtnClicked(_ sender: UIBarButtonItem) {
      
       if (self.stage == CHECKOUT){
         self.stage = CATEGORY
         reloadOrdering()
         totalTW.reloadData()
         collectionView.reloadData()
       }else{

            self.stage = HOME
            self.collectionView.reloadData()
            
            reloadHomePage()
         
      }
      
   }
   
   
   @IBAction func historyBtnClicked(_ sender: Any) {
      loadHistory()
      HistoryModel.getAll(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
         data, response, error in
         do {
            // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
            
            
            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
               if let results = jsonResult["data"] as? NSArray {
                  self.histories.removeAll()
                  for item in results {
                     let itemDict = item as! NSDictionary
                     let id = itemDict["id"] as? String
                     let table_id =  itemDict["tableid"] as? String
                     let total =  itemDict["total"] as? Double
                     
                     let history = History(id: id!, table_id: table_id!, total: total!)
                     self.histories.append(history)
                  }
 
                  DispatchQueue.main.async {
                      self.ordered_items  = [:]
                      self.ordered_item_keys = []
                      self.ordered_table  = ""
                      self.totalArr = ["Paid:0.00", "Total:0", "Change:0"]
                      self.tableView.reloadData()
                      self.order_tw.reloadData()
                  }
               }
            }
            
         } catch {
            print("Something went wrong")
         }
      })
   }
   
   @IBAction func checkOutBtnClicked(_ sender: Any) {
      if stage != CHECKOUT{
         let total :Double = Double(totalArr[1].split(separator: ":")[1])!
         if (total > 0){
            stage = CHECKOUT
            collectionView.reloadData()
            totalTW.reloadData()
            self.reloadCheckOut()
         }
      }else{
         let change :Double = Double(totalArr[2].split(separator: ":")[1])!
         let total :Double = Double(totalArr[1].split(separator: ":")[1])!
         if (change > 0){
            
            TablesModel.cleanTable(table: currentTable!, total: total) { (data, response, error) in
               self.stage = HOME
               self.reloadHomePage()

               self.collectionView.reloadData()
            }
         }
      }
   }
   
}

