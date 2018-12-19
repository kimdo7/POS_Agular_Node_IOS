//
//  Table.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//


// Table { order:
//     { quanity: 1,
//       name: 'Banana Tea',
//       size: 'M',
//       item_id: ' c9624a20-0001-11e9-97c2-a320b0e348c5',
//       price: 3 },
//    table_id: '7af2ed40-0254-11e9-97c2-a320b0e348c5' }

import Foundation
class Table {
   var id : String
   var order_id: String
   var name : String
   var status : Int
   var items : [String : OrderItem] = [:]
   var itemList : [String] = []
   
   init(id: String, name: String, status: Int, order_id: String) {
      self.id = id
      self.name = name
      self.status = status
      self.order_id = ""
      self.order_id = order_id
      
      if order_id != ""{
         OrderModel.get(order_id: order_id) { (data, response, error) in
            do {
               if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                  if let results = jsonResult["data"] as? NSArray {
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
                        self.items[key] = newOrder
                        
                        self.itemList = Array(self.items.keys).sorted(by: { (left, right) -> Bool in
                           left < right
                        })
                     }
                  }
               }
            }catch {
               print("Something went wrong")
            }
         }
      }
   }
   
   func add(item: Item, index: Int){
      var size = ""
      var price : Double = 0
      
      if index == 0 && item.getSizes() == 2{
         size = "M"
         price = Double(item.med)!
      }else if index == 0 && item.med != ""{
         size = "M"
         price = Double(item.med)!
      }else{
         size = "L"
         price = Double(item.lrg)!
      }
      
      let key = size + ":" + item.id
      if (items[key] != nil){
         let newOrder = items[key]
         newOrder?.quanity += 1
      }else{
         let newOrder = OrderItem(id: item.id, name: item.name, price: price, quanity: 1, size: size)
         items[key] = newOrder
      }
      
      itemList = Array(self.items.keys).sorted(by: { (left, right) -> Bool in
                  left < right
            })
      
      if (itemList.count > 0){
         status = 1
         
         if (order_id == ""){
            TablesModel.newTable(table: self) { (data, response, error) in
            }
         }else {
            TablesModel.updateTable(table: self, key: key) { (data, response, error) in
            }
         }
      }
    }

}
