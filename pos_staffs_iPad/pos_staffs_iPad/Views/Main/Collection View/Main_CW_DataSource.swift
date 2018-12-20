//
//  Main_CollectionView.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit
extension Main_ViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return getCWCells()
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      var cell = UICollectionViewCell()
      if stage == HOME{
         self.navbar.topItem?.title = "Home"
         cell = loadTables(indexPath: indexPath)
      }else if stage == CATEGORY{
         self.homeNavBtn.title = "Home"
         self.navbar.topItem?.title = "Category"
         cell = loadCatergory(indexPath: indexPath)
      }else if stage == ITEMS{
         self.navbar.topItem?.title = currentCategory
         self.items[currentCategory!]?.sort(by: { (left, right) -> Bool in
            left.name < right.name
         })
         cell = loadCategoryDetail(indexPath: indexPath)
      }else if stage == SIZE{
         self.navbar.topItem?.title = currentCategory! + " / " + (itemList[currentItemId!]?.name)!
         cell = loadItemSizes(indexPath: indexPath)
      }else if stage == CHECKOUT{
         self.navbar.topItem?.title = "Check Out"
         self.homeNavBtn.title = "Back"
         cell = loadCheckOut(indexPath: indexPath)
      }

      
      return cell
   }
   
   
   
}
//ex
