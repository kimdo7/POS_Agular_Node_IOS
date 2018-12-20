//
//  Main_TW_datasource.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//small change

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
      }
      
      tableView.reloadData()
   }
   
   
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return self.getHeader(tableView: tableView)
   }
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return getCells(tableView: tableView)
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if (tableView == self.tableView){
         if stage == HISTORY{
            return self.getHistoryCell(indexPath: indexPath, tableView: tableView)
         }else{
            return self.getMainTW_Cell(indexPath: indexPath, tableView: tableView)
         }
      }else if tableView == self.totalTW{
         return getTotalTW_Cell(indexPath: indexPath, tableView: tableView)
      }else if tableView == self.order_tw{
         return getOrderTW_Cell(indexPath: indexPath, tableView: tableView)
      }
      
      return UITableViewCell()
      
   }
   
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      if (tableView == self.tableView && stage != CHECKOUT){
         
         return true
      }
      
      return false
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
   
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 44
   }
}
