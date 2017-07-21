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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.black.cgColor
    }
}
