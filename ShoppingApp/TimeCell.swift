//
//  TimeCell.swift
//  ShoppingApp
//
//  Created by Lynn on 7/20/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class TimeCell: UICollectionViewCell {
    @IBOutlet weak var timeList: UICollectionView!
    var hours:[Time] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timeList.register(UINib(nibName: "DetailTimeCell", bundle: nil), forCellWithReuseIdentifier: "DetailTimeCell")
    }
}

extension TimeCell:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTimeCell", for: indexPath) as! DetailTimeCell
        cell.chosedTime.text = hours[indexPath.item].hour
        return cell
    }
}

extension TimeCell:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.size.width - 60) / 3
        let height:CGFloat = 25
        return CGSize(width: width, height: height)
    }
}
