//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Lynn on 7/18/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var leftTopView: UIView!
    @IBOutlet weak var leftTopImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var advertisementList: UICollectionView!
    let pictureArr = ["first", "second", "third", "fourth"]
    let labelArr = ["Spring Collection","Pastel Collection","Personal Shopper","Runway Specials"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advertisementList.register(UINib(nibName: "AdvertisementCell", bundle: nil), forCellWithReuseIdentifier: "AdvertisementCell")
        // Do any additional setup after loading the view, typically from a nib.
        
        let leftIcon = IonIcons.image(withIcon: ion_navicon_round,
                                      iconColor: .white,
                                      iconSize: 25,
                                      imageSize: CGSize(width: 25, height: 25))
        let rightIcon = IonIcons.image(withIcon: ion_gear_a,
                                       iconColor: .white,
                                       iconSize: 25,
                                       imageSize: CGSize(width: 25, height: 25))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftIcon,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector (openMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightIcon,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector (goSetting))
       
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        let tap = UILongPressGestureRecognizer(target: self, action: #selector (collectionShopMenu))
        tap.minimumPressDuration = 0
        leftTopView.addGestureRecognizer(tap)
        self.leftTopImage.image = IonIcons.image(withIcon: ion_bag,
                                           iconColor: .black,
                                           iconSize: 25,
                                           imageSize: CGSize(width: 25, height: 25))
        
    }
    
    func openMenu () {
        
    }
    
    func goSetting () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "SVC")
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func collectionShopMenu(sender:UILongPressGestureRecognizer){
        switch sender.state {
        case .began:
            leftTopView.backgroundColor = UIColor.lightGray
        case .changed:
            if !checkInside(sender.location(in: view)) {
                leftTopView.backgroundColor = UIColor.white
                sender.isEnabled = false
                sender.isEnabled = true
            }
        case .ended:
            leftTopView.backgroundColor = UIColor.white
            let storyboard = UIStoryboard(name: "Resevation", bundle: nil)
            let destination = storyboard.instantiateViewController(withIdentifier: "CSMVC")
            navigationController?.pushViewController(destination, animated: true)
        default:
            break
        }
    }
    
    func checkInside(_ point:CGPoint)->Bool{
        let frame = view.convert(leftTopView.frame, to: view)
        return frame.contains(point)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.size.width
        let xPos:Float = Float(scrollView.contentOffset.x)
        pageControl.currentPage = Int(CGFloat(xPos) / width)
    }
    
}

extension ViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = advertisementList.dequeueReusableCell(withReuseIdentifier: "AdvertisementCell", for: indexPath) as! AdvertisementCell
        cell.displayPicture.image = UIImage(named: pictureArr[indexPath.row])
        cell.displayLabel.text = labelArr[indexPath.row]
        return cell
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = view.frame.size.width
            let height:CGFloat = 311
            return CGSize(width: width, height: height)
    }
}
