//
//  Main_TW_datasource.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit

extension Main_ViewController: UITableViewDataSource, AddMinusProtol{
   func change(value: Int, indexPath: IndexPath) {
      let key : String = (self.currentTable?.itemList[indexPath.row])!
      let order = self.currentTable?.items[key]
      order?.quanity += value
      
      //update to server
      TablesModel.updateTable(table: currentTable!, key: key) { (data, response, error) in
      }
      
      if order?.quanity == 0{
         self.currentTable?.itemList.remove(at: indexPath.row)
         self.currentTable?.items.removeValue(forKey: key)
      }
   
      
      
      if ((self.currentTable?.itemList.isEmpty)!){
         self.currentTable?.status = 0
      }else{
         
      }
      
      
      tableView.reloadData()
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if ((self.currentTable) != nil){
         getTotal()
         
         return (self.currentTable?.items.count)!
      }
      return 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "main_tw_cell", for: indexPath) as! Main_TableViewCell
      
      let key : String = (self.currentTable?.itemList[indexPath.row])!
      let order = self.currentTable?.items[key]
      let count : Int = (order?.quanity)!
      
      cell.nameLabel.text = (order?.size)! + ": " + (order?.name)!
      cell.countLabel.text = String(count)
      cell.indexPath = indexPath
      cell.delegate = self
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     return true
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
      let key : String = (self.currentTable?.itemList[indexPath.row])!
      self.currentTable?.itemList.remove(at: indexPath.row)
      self.currentTable?.items.removeValue(forKey: key)
      if ((self.currentTable?.itemList.isEmpty)!){
         self.currentTable?.status = 0
      }
      
      tableView.reloadData()
   }
   
}
