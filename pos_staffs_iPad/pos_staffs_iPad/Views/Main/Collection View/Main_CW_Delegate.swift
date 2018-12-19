//
//  Main_CollectionView.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit
extension Main_ViewController: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      if (self.stage == HOME){
         self.stage += 1
         self.currentTable = self.tables[indexPath.row]
         self.tableView.reloadData()
         self.collectionView.reloadData()
         reloadOrdering()
      }else if (self.stage == CATEGORY){
         self.stage += 1
         self.currentCategory = self.categories[indexPath.row]
         self.collectionView.reloadData()
      }else if (self.stage == ITEMS){
         self.stage += 1
         let item = self.items[currentCategory!]![indexPath.row]
         self.currentItemId  = item.id

         self.collectionView.reloadData()

      }else if (self.stage == SIZE){
         self.stage = CATEGORY
         let item : Item = self.itemList[currentItemId!]!
         self.currentTable?.add(item: item, index: indexPath.row)
         self.tableView.reloadData()
         self.collectionView.reloadData()
         self.currentCategory = ""
      }else if (self.stage == CHECKOUT){
         var paid : String = String(totalArr[0].split(separator: ":")[1])
         if (NUMBERS[indexPath.row] == "X"){
            paid.removeLast()
            let paidDouble : Double = Double(paid)!
            paid  = String (format: "%.02f", paidDouble / 10 )
         }else if paid == " 0.00"{
            if (NUMBERS[indexPath.row] != "00" && NUMBERS[indexPath.row] != "0"){
               paid = "0.0" + NUMBERS[indexPath.row]
            }
         }else{
            
            paid += NUMBERS[indexPath.row]
            let paidDouble : Double = Double(paid)!
            if (NUMBERS[indexPath.row] == "00"){
               paid = String (format: "%.02f", paidDouble * 100)
            }else{
               paid = String (format: "%.02f", paidDouble * 10)
            }
         }
         
         let paidDouble : Double = Double(paid)!
         let total : Double = Double(totalArr[1].split(separator: ":")[1])!
         let changeDouble : Double = paidDouble - total
         
         
         totalArr[0] = "Paid:" + paid
         totalArr[2] = String (format: "Change:%.02f", changeDouble)
         totalTW.reloadData()
      }
   }
}

