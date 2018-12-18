//
//  Item.swift
//  
//
//  Created by Kim Do on 12/17/18.
//

import Foundation

class Item {
   var id : String   = ""
   var name : String = ""
   var category: String = ""
   var lrg : String = ""
   var med : String = ""
   var size : String = ""

   
   init(id: String, name: String, category: String, lrg: String, med: String) {
      self.id = id
      self.name = name
      self.category = category
      self.lrg = lrg
      self.med = med
   }
   
   func getSizes() -> Int{
      var count = 0
      
      if lrg != ""{
         count += 1
//         sizes.append()
      }
      
      if med != ""{
         count += 1
      }
      
      return count
   }
   
   
   
}
