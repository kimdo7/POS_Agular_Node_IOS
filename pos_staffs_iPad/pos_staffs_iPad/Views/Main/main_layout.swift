//
//  main_layout.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit
extension Main_ViewController{
   func loadHomePage(){
      self.tableView.frame = CGRect(x: 0, y: 70, width: 0, height: self.view.frame.height - 70 - 50)
      self.checkOutBtn.frame = CGRect(x: 0, y: 70 + self.tableView.frame.height, width: 0, height: 50)
      self.collectionView.frame = CGRect(x: 0, y: 70, width: self.view.frame.width, height: self.view.frame.height - 70)
      self.navbar.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50)
      self.navbar.topItem?.title = "Home"
      self.tableView.alpha = 0
      self.totalLabel.alpha = 0
      self.checkOutBtn.alpha = 0
   }
   
   func reloadHomePage(){
      
      UIView.animate(withDuration: 0.5) {
         self.totalLabel.frame = CGRect(x: 0, y: 70 + self.tableView.frame.height, width: 0, height: 50)
         self.tableView.frame = CGRect(x: 0, y: 70, width: 0, height: self.view.frame.height - 70 - 50)
         self.checkOutBtn.frame = CGRect(x: 0, y: 70 + self.tableView.frame.height, width: 0, height: 50)
         self.collectionView.frame = CGRect(x: 0, y: 70, width: self.view.frame.width, height: self.view.frame.height - 70)
         self.navbar.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50)
         self.navbar.topItem?.title = "Home"
         self.tableView.alpha = 0
         self.totalLabel.alpha = 0
         self.checkOutBtn.alpha = 0
      }
   }
   
   func reloadOrdering(){

      let sideWidth = self.view.frame.width / 16 * 6
      UIView.animate(withDuration: 0.5) {
         self.navbar.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50)
         self.tableView.frame = CGRect(x: 0, y: 70, width: sideWidth, height: self.view.frame.height - 70 - 100)
         self.checkOutBtn.frame = CGRect(x: 0, y: 70 + self.tableView.frame.height + 50, width: sideWidth, height: 50)
         self.tableView.alpha = 1.0
         self.totalLabel.alpha = 1.0
         self.checkOutBtn.alpha = 1.0
         self.totalLabel.frame = CGRect(x: 0, y: 70 + self.tableView.frame.height, width: sideWidth, height: 50)
         self.collectionView.frame = CGRect(x: sideWidth, y: 70, width: self.view.frame.width - sideWidth, height: self.view.frame.height - 70)
      }
   }
}
