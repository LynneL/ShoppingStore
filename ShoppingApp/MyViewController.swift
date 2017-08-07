//
//  MyViewController.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/23/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var reserveView: UIView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var topLeft: UIView!
    @IBOutlet weak var topLeftView: UIImageView!
    @IBOutlet weak var pageChange: UIPageControl!
    @IBOutlet weak var topImageList: UICollectionView!
    var images:[String] = ["First", "Second", "Third", "Fourth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topImageList.register(UINib(nibName: "TopCell", bundle: nil), forCellWithReuseIdentifier: "TopCell")
        UISetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UISetup() {

        let image = IonIcons.image(withIcon: ion_navicon_round,
                                   iconColor: .white,
                                   iconSize: 30,
                                   imageSize: CGSize(width: 30, height: 30))
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(image: image,
                            style: .plain,
                            target: self,
                            action: #selector (goMenu))
        
        let rightImage = IonIcons.image(withIcon: ion_gear_a,
                                        iconColor: .white,
                                        iconSize: 30,
                                        imageSize: CGSize(width: 30, height: 30))
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: rightImage,
                            style: .plain,
                            target: self,
                            action: #selector (settingDetails))
        
        
        topLeftView.image = IonIcons.image(withIcon: ion_bag,
                                           iconColor: .black,
                                           iconSize: 35,
                                           imageSize: CGSize(width: 35, height: 35))
        let tap = UILongPressGestureRecognizer(target: self,
                                               action: #selector (goShoping))
        tap.minimumPressDuration = 0
        topLeft.addGestureRecognizer(tap)
        navigationController?.navigationBar.tintColor = .white
        self.picture.image = UIImage(named: "Fifth")
        
        let tap2 = UILongPressGestureRecognizer(target: self, action: #selector (goReservation))
        tap2.minimumPressDuration = 0
        reserveView.addGestureRecognizer(tap2)
    }
    
    func goMenu(){
        
    }
    
    func settingDetails(){
        let storyboard = UIStoryboard(name: "GoShopping", bundle: nil)
        let goSetting = storyboard.instantiateViewController(withIdentifier: "SDVC")
        navigationController?.pushViewController(goSetting, animated: true)
    }
    
    func goShoping(sender:UILongPressGestureRecognizer){
        switch sender.state {
        case .began:
            topLeft.backgroundColor = .lightGray
        case .changed:
            topLeft.backgroundColor = .lightGray
            let frame = view.convert(topLeft.frame, to: view)
            if !frame.contains(sender.location(in: view)) {
                sender.isEnabled = false
                sender.isEnabled = true
                topLeft.backgroundColor = .white
            }
        case .ended:
            let storyboard = UIStoryboard(name: "GoShopping", bundle: nil)
            let go = storyboard.instantiateViewController(withIdentifier: "GSVC")
            navigationController?.pushViewController(go, animated: true)
            
            topLeft.backgroundColor = .white
        default:
            break
        }
    }
    
    func goReservation(sender:UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            reserveView.backgroundColor = .lightGray
        case .changed:
            let frame = view.convert(reserveView.frame, to: view)
            if !frame.contains(sender.location(in: view)){
                reserveView.backgroundColor = .white
                sender.isEnabled = false
                sender.isEnabled = true
            }
        case .ended:
            let storyboard = UIStoryboard(name: "Reservation", bundle: nil)
            let goReservation = storyboard.instantiateViewController(withIdentifier: "RVC")
            navigationController?.pushViewController(goReservation, animated: true)
            reserveView.backgroundColor = .white
        default:
            break
        }
    }
}

extension MyViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as! TopCell
        cell.topImage.image = UIImage(named: images[indexPath.item])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = view.bounds.size.width
        pageChange.currentPage = Int(x/w)
    }
}

extension MyViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height:CGFloat = 274
        return CGSize(width: width, height: height)
    }
}
