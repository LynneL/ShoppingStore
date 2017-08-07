//
//  TimeViewCell.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/24/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class TimeViewCell: UICollectionViewCell {

    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.black.cgColor
        
        self.coverView.image =
            IonIcons.image(withIcon: ion_ios_checkmark_outline,
                           iconColor: .white,
                           iconSize: 30,
                           imageSize: CGSize(width: 30, height: 30))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
