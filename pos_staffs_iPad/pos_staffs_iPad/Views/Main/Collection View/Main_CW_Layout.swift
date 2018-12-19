//
//  Main_CollectionView_Layout.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation
import UIKit

extension Main_ViewController: UICollectionViewDelegateFlowLayout{
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      if (stage == CHECKOUT){
         let yourWidth = (collectionView.bounds.width - 3 * 10) / 3.0
         let yourHeight = (collectionView.bounds.height - 3 * 10) / 4.0
         
         return CGSize(width: yourWidth, height: yourHeight)
      }
      
      let yourWidth = (collectionView.bounds.width - 3 * 10) / 3.0
      let yourHeight = (collectionView.bounds.height - 2 * 10) / 3.0
      
      return CGSize(width: yourWidth, height: yourHeight)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets.zero
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 10
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10
   }
}
