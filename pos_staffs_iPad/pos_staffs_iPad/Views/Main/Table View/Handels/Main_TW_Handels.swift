//
//  Main_TW_Handels.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/19/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit

extension Main_ViewController{
   func getCells(tableView: UITableView) -> Int{
      if (tableView == self.tableView){
         if  stage == HISTORY{
            return self.ordered_item_keys.count
         }else if ((self.currentTable) != nil){
            getTotal()
            
            return (self.currentTable?.items.count)!
         }
      }else if tableView == self.totalTW{
         if (stage == CHECKOUT){
            return 3
         }
         return 1
      }else if tableView == self.order_tw{
         return histories.count
      }
      return 0
   }
   
   func getHeader(tableView: UITableView) -> String{
      if tableView == self.tableView{
         if stage == HISTORY{
            return ordered_table
         }else if  let name = self.currentTable?.name{
            return "Table: " + name
         }
      }
      return ""
   }
   
   func getHistoryCell(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell{
      let cell = tableView.dequeueReusableCell(withIdentifier: "history_tw_cell", for: indexPath)
      let item = self.ordered_items[ordered_item_keys[indexPath.row]]
      cell.textLabel!.text = (item?.size)! + ": " + (item?.name)!
      cell.detailTextLabel?.text = String((item?.quanity)!)
      return cell
   }
   
   func getMainTW_Cell(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell{
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
   
   func getTotalTW_Cell(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell{
      let cell = tableView.dequeueReusableCell(withIdentifier: "total_tw_cell", for: indexPath)
      if stage == CHECKOUT{
         cell.textLabel?.text = String(self.totalArr[indexPath.row].split(separator: ":")[0])
         cell.detailTextLabel!.text = "$" + String(self.totalArr[indexPath.row].split(separator: ":")[1])
      }else{
         cell.textLabel?.text = String(self.totalArr[1].split(separator: ":")[0])
         cell.detailTextLabel!.text = "$" + String(self.totalArr[1].split(separator: ":")[1])
      }
      
      return cell
   }
   
   func getOrderTW_Cell(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell{
      let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
      cell.accessoryType = .disclosureIndicator
      cell.textLabel?.text = "Order #" + String(indexPath.row + 1)
      return cell
   }
}
