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
   
   @IBOutlet weak var totalLabel: UILabel!
   
   @IBOutlet weak var navbar: UINavigationBar!
   @IBOutlet weak var tableView: UITableView!
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
//      socket = manager.defaultSocket
//
//      socket.on(clientEvent: .connect) {data, ack in
//         print("socket connected")
//      }
//
//
//      socket.on("greeting") { (data, ack) in
//         print(data)
//      }
//
//      socket.connect()
      
      getAllItems()
      getAllTables()
      
      setUp()
      loadHomePage()
//      reloadOrdering()
      
   }
   
   
   func setUp(){
      self.collectionView.dataSource = self
      self.collectionView.delegate   = self
      self.tableView.dataSource = self
   }
   @IBAction func goBackNavBtnClicked(_ sender: Any) {
      if (self.stage == ITEMS || self.stage == SIZE || self.stage == CATEGORY){
         self.stage -= 1
         self.collectionView.reloadData()
         
         if (stage == HOME){
            reloadHomePage()
         }
      }
      
//      let HOME = 1
//      let CATEGORY = 2
//      let ITEMS = 3
//      let SIZE = 4
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
      TablesMode.getAll(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
         data, response, error in
         do {
            // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
            
            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
               if let results = jsonResult["data"] as? NSArray {
                  for item in results {
                     let itemDict = item as! NSDictionary
                     let newTable = Table(id: itemDict["id"] as! String, name: itemDict["name"] as! String, status: itemDict["status"] as! Int)
                     self.tables.append(newTable)
                     
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


}

