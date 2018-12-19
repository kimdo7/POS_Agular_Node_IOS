//
//  Main_TableViewCell.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import UIKit

class Main_TableViewCell: UITableViewCell {

   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var countLabel: UILabel!
   var indexPath : IndexPath!
   var delegate : AddMinusProtol!
   
   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   @IBAction func minusBtnClicked(_ sender: UIButton) {
      delegate.change(value: -1, indexPath: indexPath)
   }
   
   @IBAction func addBtnClicked(_ sender: UIButton) {
      delegate.change(value: 1, indexPath: indexPath)
   }
   
   
   
}
