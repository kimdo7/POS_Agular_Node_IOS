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
}
