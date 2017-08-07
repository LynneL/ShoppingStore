//
//  ShoppingCell.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/24/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit
protocol ShoppingCellDelegate: class {
    
    func addCommedity(_ item:Commedity)
}

class ShoppingCell: UICollectionViewCell {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var shoppingPrice: UILabel!
    @IBOutlet weak var shoppingName: UILabel!
    @IBOutlet weak var shoppingPicture: UIImageView!
    var item:Commedity!
    weak var delegate:ShoppingCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addButton.layer.cornerRadius = 5
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func addCommedity(_ sender: UIButton) {
        ShoppingCart.add(Item: item)
        self.delegate?.addCommedity(item)
    }
}
