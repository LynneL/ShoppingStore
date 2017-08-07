//
//  MyReservationCell.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/25/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

protocol MyReservationCellDelegate: class {
    
    func rescheduleTime(_ index:Int)
    
    func deleteTime(_ index:Int)
}

class MyReservationCell: UICollectionViewCell {
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var chosedWeek: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var chosedTime: UILabel!
    @IBOutlet weak var chosedDate: UILabel!
    var index:Int = -1
    weak var delegate:MyReservationCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func deleteTime(_ sender: UIButton) {
        self.delegate?.deleteTime(index)
        
    }
    
    @IBAction func rescheduleTime(_ sender: UIButton) {
        self.deleteButton.isHidden = false
        if self.changeButton.titleLabel?.text == "CHANGE"{
            changeButton.setTitle("RESCHEDULE", for: .normal)
        }else if self.changeButton.titleLabel?.text == "RESCHEDULE"{
            self.delegate?.rescheduleTime(index)
            self.delegate?.deleteTime(index)
            changeButton.setTitle("CHANGE", for: .normal)
            self.deleteButton.isHidden = true
        }
    }
}

