//
//  Main_TW_datasource.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit

extension Main_ViewController: UITableViewDataSource {
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
      
      return cell
   }
   
}
