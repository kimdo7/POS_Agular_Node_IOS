//
//  Main_TW_delegate.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/18/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit

extension Main_ViewController:  UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if (tableView == self.order_tw){
         OrderModel.get(order_id: histories[indexPath.row].id) { (data, response, error) in
            do {
               if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                  if let results = jsonResult["data"] as? NSArray {
                     self.ordered_items.removeAll()
                     for item in results {
                        let itemDict = item as! NSDictionary
                        
                        let size = itemDict["size"] as? String
                        let itemId = itemDict["itemid"] as? String
                        let price = itemDict["price"] as? Float
                        let name = itemDict["name"] as? String
                        let quanity = itemDict["quanity"] as? Int
                        let id = itemDict["id"] as? String
                        
                        let key : String = size!  + ":" + itemId!
                        let newOrder = OrderItem(id: itemId!, name: name!, price: Double(price!), quanity: quanity!, size: size!)
                        newOrder.id = id!
                        self.ordered_items[key] = newOrder
                        
                        
                     }
                     
                     self.ordered_item_keys = Array(self.ordered_items.keys).sorted(by: { (left, right) -> Bool in
                        left < right
                     })
                     
                     var  total : Double = 0
                     for (_, value) in (self.ordered_items){
                        total += value.price * Double(value.quanity)
                     }
                     
                     
                     self.ordered_table = self.getTableName(tableId: self.histories[indexPath.row].table_id)
                     
                     self.totalArr[1] = "Total :" + String(format: "%.02f", total)
                     
                     DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.totalTW.reloadData()
                     }
                  }
               }
            }catch {
               print("Something went wrong")
            }
         }
      }
   }
}
