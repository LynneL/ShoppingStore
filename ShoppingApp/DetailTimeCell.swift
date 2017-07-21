//
//  DetailTimeCell.swift
//  ShoppingApp
//
//  Created by Lynn on 7/20/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class DetailTimeCell: UICollectionViewCell {

    @IBOutlet weak var chosedTime: UILabel!
    var hour:Time!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.chosedTime.text = hour.hour
    }
}
