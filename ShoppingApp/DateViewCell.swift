//
//  DateViewCell.swift
//  ShoppingApp
//
//  Created by Lynn on 7/18/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class DateViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateList: UICollectionView!
    var days:[Day] = []
    var index = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateList.register(UINib(nibName: "DayCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.dateLabel.text = days.first?.month
        for index in 0..<days.count - 1 {
            if days[index].month == "Aug" && days[index].day == "1" {
                dateList.scrollToItem(at: IndexPath(item:index,section:0), at: .left, animated: true)
                break
            }
            
        }
    }

}

extension DateViewCell:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        cell.day = days[indexPath.row]
        /*if self.index == indexPath.item{
            cell.cover.isHidden = false
            }else{
                cell.cover.isHidden = true
        }*/
        cell.cover.isHidden = self.index != indexPath.item
        
        return cell
    }
}

extension DateViewCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.size.width - 60) / 4.5
        let height:CGFloat = 102
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.index = indexPath.item
        collectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cell = dateList.visibleCells.first! as! DayCell
        self.dateLabel.text = cell.day.month
    }
}
