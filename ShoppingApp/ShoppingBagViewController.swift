//
//  ShoppingBagViewController.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/24/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class ShoppingBagViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var checkList: UICollectionView!
    @IBOutlet weak var subTotalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkList.register(UINib(nibName: "CheckingCell", bundle: nil), forCellWithReuseIdentifier: "CheckingCell")
        self.subTotalLabel.text = ShoppingCart.check().subStr
        self.taxLabel.text = ShoppingCart.check().taxStr
        self.totalLabel.text = ShoppingCart.check().totalStr
        NotificationCenter.default.addObserver(self, selector: #selector(updatePrice), name: NSNotification.Name(rawValue: "ShouldUpdatePrice"), object: nil)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    @objc private func updatePrice(sender:Notification){
        let newValue = sender.userInfo!["NewValue"] as! (String,String,String)
        let flag = sender.userInfo!["Reload"] as! Bool
        DispatchQueue.main.async {
            self.subTotalLabel.text = newValue.0
            self.taxLabel.text = newValue.1
            self.totalLabel.text = newValue.2
            if flag {
                self.checkList.reloadData()
            }
        }
        
        automaticallyAdjustsScrollViewInsets = false
        
    }
    
}

extension ShoppingBagViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ShoppingCart.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckingCell", for: indexPath) as! CheckingCell
        cell.chosedImage.image = UIImage(named: ShoppingCart.items[indexPath.item].commedityImage)
        
        cell.chosedName.text = ShoppingCart.items[indexPath.item].commedityName
        cell.chosedPrice.text = ShoppingCart.items[indexPath.item].commedityPrice
        cell.chosedSize.text = "\(ShoppingCart.items[indexPath.item].chosedSize)"
        cell.chosedQty.text = "\(ShoppingCart.items[indexPath.item].chosedQty)"
        cell.item = ShoppingCart.items[indexPath.item]
        
        cell.item = ShoppingCart.items[indexPath.item]
        cell.delegate = self
        return cell
    }
}

extension ShoppingBagViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        let height:CGFloat = 177
        return CGSize(width: width, height: height)
    }
}

extension ShoppingBagViewController:CheckingCellDelegate{
    func didDeleteItem() {
        checkList.reloadData()
    }
}

