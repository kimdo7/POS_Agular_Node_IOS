//
//  OrderItem.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation

class OrderItem{
   var name: String
   var id : String
   var price: Double
   var quanity : Int
   var size : String
   
   init(id: String, name: String, price: Double, quanity: Int, size: String) {
      self.id = id
      self.name = name
      self.price = price
      self.quanity = quanity
      self.size = size
   }
}
