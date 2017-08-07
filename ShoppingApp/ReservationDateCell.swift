//
//  ReservationDateCell.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/24/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

protocol ReservationDateDelegate:class {
    
    func didSelectDate(_ index:Int)
}

class ReservationDateCell: UICollectionViewCell {

    @IBOutlet weak var dateList: UICollectionView!
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    var days:[Day] = []
    var index = -1
    weak var delegate:ReservationDateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateList.register(UINib(nibName: "DateViewCell", bundle: nil), forCellWithReuseIdentifier: "DateViewCell")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.monthLabel.text = days.first?.month
    }
}

extension ReservationDateCell:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateViewCell", for: indexPath) as! DateViewCell
        cell.day = days[indexPath.item]
        if self.index == indexPath.item{
            cell.coverView.isHidden = false
        }else{
            cell.coverView.isHidden = true
        }
        return cell
    }
}

extension ReservationDateCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.size.width - 60) / 4.5
        let height:CGFloat = 79
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.index = indexPath.item
        collectionView.reloadData()
        self.delegate?.didSelectDate(index)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cell = dateList.visibleCells.first as! DateViewCell
        self.monthLabel.text = cell.day.month
        
    }
}


    

