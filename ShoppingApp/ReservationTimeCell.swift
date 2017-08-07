//
//  ReservationTimeCell.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/24/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

protocol ReservationTimeCellDelegate: class {
    
    func reserve(day:Day)
}

class ReservationTimeCell: UICollectionViewCell {
    
    @IBOutlet weak var timeList: UICollectionView!
    var day:Day!{
        didSet{
            timeList.reloadData()
        }
    }
    
    var updateDayHandler:((Day)->Void)!
    
    @IBOutlet weak var reserveButton: UIButton!
    weak var delegate:ReservationTimeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timeList.register(UINib(nibName: "TimeViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeViewCell")
        reserveButton.alpha = 0.4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reserveButton.alpha = 0.4
        
        reserveButton.backgroundColor = UIColor(colorLiteralRed: 76/255.0,
                                                green: 210/255.0,
                                                blue: 167/255.0,
                                                alpha: 1)
        reserveButton.isEnabled = false
    }
    
    
    @IBAction func timeReserve(_ sender: UIButton) {
        self.delegate?.reserve(day: day)
    }
}

extension ReservationTimeCell:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return day.timeSlots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeViewCell", for: indexPath) as! TimeViewCell
        cell.timeLabel.text = day.timeSlots[indexPath.item]
        if day.selectedIndex == indexPath.item{
            cell.coverView.isHidden = false
        }else{
            cell.coverView.isHidden = true
        }
        return cell
    }
}

extension ReservationTimeCell:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.size.width - 50) / 3.1
        let height:CGFloat = 30
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        day.selectedIndex = indexPath.item
        collectionView.reloadData()
        self.reserveButton.isEnabled = true
        
        self.reserveButton.alpha = 1
        
        self.reserveButton.backgroundColor = UIColor(colorLiteralRed: 76/255.0,green: 210/255.0,blue: 167/255.0,alpha: 1)
        
        self.updateDayHandler(day)
    }
    
}
