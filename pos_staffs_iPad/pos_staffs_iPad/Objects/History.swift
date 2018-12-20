//
//  History.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/19/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
class History{
   var id : String
   var table_id: String
   var total : Double
   
   init(id: String, table_id: String, total: Double) {
      self.id = id
      self.table_id = table_id
      self.total = total
   }
}
