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
      }
   }
}

