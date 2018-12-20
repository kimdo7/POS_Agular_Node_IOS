//
//  Main_TW_Handels.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit

extension Main_ViewController{
   func getTotal(){
      
      var total : Double = 0.0
      

      for (_, value) in (self.currentTable?.items)!{
         total += value.price * Double(value.quanity)
      }
      
      self.totalArr[1] = "Total :" + String(format: "%.02f", total)
      self.totalArr[2] = "Change:" + String(format: "%.02f", -total)
      self.totalTW.reloadData()
   }
   
   func getTableName(tableId: String) -> String{
      for table in self.tables{
         if table.id == tableId{
            return "Table: " + table.name
            
         }
      }
      return ""
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
   
   func setUp(){
      self.collectionView.dataSource = self
      self.collectionView.delegate   = self
      self.tableView.dataSource = self
      self.tableView.delegate = self
      self.totalTW.dataSource = self
   }
   
   func createOrderTW(){
      order_tw = UITableView(frame: CGRect(x: 0, y: 70, width: self.view.frame.width / 2, height: self.view.frame.height - 70), style: UITableView.Style.grouped)
      order_tw.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
      order_tw.dataSource = self
      order_tw.delegate = self
      self.view.addSubview(order_tw)
      ordered_table = ""
   }
}
