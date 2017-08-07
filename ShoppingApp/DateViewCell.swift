//
//  DateViewCell.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/24/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class DateViewCell: UICollectionViewCell {

    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    var day:Day!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.black.cgColor
        
        self.coverView.image =
            IonIcons.image(withIcon: ion_ios_checkmark_outline,
                           iconColor: .white,
                           iconSize: 35,
                           imageSize: CGSize(width: 35, height: 35))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.dayLabel.text = day.date
        self.weekLabel.text = day.week
    }

}
