//
//  Main_CW_Handels.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit

extension Main_ViewController {
   func loadTables(indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main_cw_cell", for: indexPath) as! Main_CollectionViewCell
      cell.label.text = self.tables[indexPath.row].name
      
      if (self.tables[indexPath.row].status == 0){
         cell.backgroundColor = UIColor.green
      }else if (self.tables[indexPath.row].status == -1){
         cell.backgroundColor = UIColor.yellow
      }else {
         cell.backgroundColor = UIColor.red
      }
      return cell
   }
   
   func loadCatergory(indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main_cw_cell", for: indexPath) as! Main_CollectionViewCell
      cell.label.text = self.categories[indexPath.row]
      cell.backgroundColor = UIColor.green
      return cell
   }
   
   func loadCategoryDetail(indexPath: IndexPath) -> UICollectionViewCell{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main_cw_cell", for: indexPath) as! Main_CollectionViewCell
      cell.backgroundColor = UIColor.green
      cell.label.text = self.items[currentCategory!]![indexPath.row].name
      return cell
   }
   
   func loadItemSizes(indexPath: IndexPath) -> UICollectionViewCell{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main_cw_cell", for: indexPath) as! Main_CollectionViewCell
      let item : Item = self.itemList[currentItemId!]!
      if (indexPath.row == 0){
         if (item.med != ""){
            cell.label.text = "Medium: " + item.med
         }else{
            cell.label.text = "Large: " + item.lrg
         }
      }else{
         cell.label.text =  "Large: " + item.lrg
      }
      cell.backgroundColor = UIColor.green
      return cell
   }
   
   
   
   func getCWCells() -> Int{
      if self.stage == HOME{
         return self.tables.count
      } else if self.stage == CATEGORY{
         return self.categories.count
      }else if self.stage == ITEMS{
         return self.items[currentCategory!]!.count
      }else if self.stage == SIZE{
//         return self.items[currentCategory!][ind]
         return self.itemList[currentItemId!]!.getSizes()
      }else if self.stage == CHECKOUT{
         return NUMBERS.count
      }
      
      return 0
   }
   
   func loadCheckOut(indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main_cw_cell", for: indexPath) as! Main_CollectionViewCell
      cell.backgroundColor = UIColor.gray
      cell.label.text = String(NUMBERS[indexPath.row])
      
      return cell
   }
   
}
