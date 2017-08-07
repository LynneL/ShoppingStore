//
//  CheckingCell.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/24/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

protocol CheckingCellDelegate: class  {
    
    func didDeleteItem()
}

class CheckingCell: UICollectionViewCell{

    @IBOutlet weak var chosedQty: UITextField!
    @IBOutlet weak var chosedSize: UITextField!
    @IBOutlet weak var chosedImage: UIImageView!
    @IBOutlet weak var chosedName: UILabel!
    @IBOutlet weak var chosedPrice: UILabel!
    var item:Commedity!
    weak var delegate:CheckingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.chosedImage.layer.borderWidth = 0.3
        self.chosedImage.layer.borderColor = UIColor.black.cgColor
    }
    
    override func layoutSubviews() {
        
        self.chosedName.text = self.item.commedityName
        self.chosedPrice.text = self.item.commedityPrice
        self.chosedSize.text = "\(self.item.chosedSize)"
        self.chosedQty.text = "\(self.item.chosedQty)"
    }

    
   
    @IBAction func sizeTextField(_ sender: UITextField) {
        
    }
  
    @IBAction func qtyTextField(_ sender: UITextField) {
        item.chosedQty = Int(sender.text!)!
        ShoppingCart.update(Item: item)
    }

    @IBAction func removeChosedItems(_ sender: UIButton) {
        ShoppingCart.remove(Item: item)
        self.delegate?.didDeleteItem()
    }
    
    
}
