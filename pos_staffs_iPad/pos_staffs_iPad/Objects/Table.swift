//
//  Table.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
class Table {
   var id : String
   var name : String
   var status : Int
   var items : [String : OrderItem] = [:]
   var itemList : [String] = []
   
   init(id: String, name: String, status: Int) {
      self.id = id
      self.name = name
      self.status = status
   }
   
   func add(item: Item, index: Int){
      var size = ""
      var price : Double = 0
      
      if index == 0 && item.getSizes() == 2{
         size = "M"
         price = Double(item.med)!
      }else{
         size = "L"
         price = Double(item.lrg)!
      }
      
      let key = size + ": " + item.id
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
      }
    }

}
