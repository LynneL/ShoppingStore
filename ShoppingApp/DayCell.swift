//
//  DayCell.swift
//  ShoppingApp
//
//  Created by Lynn on 7/18/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var cover: UIImageView!
    
    var day:Day!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.black.cgColor
        
        cover.image = IonIcons.image(withIcon: ion_ios_checkmark_outline,
                                     iconColor: .white,
                                     iconSize: 30,
                                     imageSize: CGSize(width: 30, height: 30))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.weekLabel.text = day.week
        self.dayLabel.text = day.day
    }

}
