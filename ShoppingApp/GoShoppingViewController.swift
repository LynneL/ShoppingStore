//
//  GoShoppingViewController.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/23/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class GoShoppingViewController: UIViewController {

    @IBOutlet weak var sunGlass: UIImageView!
    @IBOutlet weak var shoppingList: UICollectionView!
    var item:Commedity!
    var commedityArr:[Commedity] =
        [Commedity(img: "FirstShoe", name: "CASUAL LEATHER SHOES", price: "$209.95 USD", Qty: 1),
         Commedity(img: "SecondShoe", name: "COOL BLUE PUMPS", price: "$159.95 USD", Qty: 1),
         Commedity(img: "ThirdShoe", name: "CLASSIC NODET UIVTT S", price: "$159.00 USD", Qty: 1),
         Commedity(img: "FourthShoe", name: "CIVINAL  SHOES", price: "$209.95 USD", Qty: 1),
         Commedity(img: "FifthShoe", name: "GOLF EXPLORER", price: "$109.95 USD", Qty: 1),
         Commedity(img: "SixthShoe", name: "CLASSIC BLACK FLATS", price: "$129.95 USD", Qty: 1),
         Commedity(img: "SeventhShoe", name: "COOL GRAY SHOES", price: "$159.00 USD", Qty: 1),
         Commedity(img: "EighthShoe", name: "OXFORD BLACK SHOES", price: "$209.95 USD", Qty: 1),
        
    ]
    
    @IBOutlet weak var numberOfItems: UILabel!
    var hub:RKNotificationHub!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingList.register(UINib(nibName: "ShoppingCell", bundle: nil), forCellWithReuseIdentifier: "ShoppingCell")

        // Do any additional setup after loading the view.
        let image = IonIcons.image(withIcon: ion_bag,
                                   iconColor: .white,
                                   iconSize: 25,
                                   imageSize: CGSize(width: 25, height: 25))
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: image,
                            style: .plain,
                            target: self,
                            action: #selector (goShoppingBag))
        
        self.sunGlass.image = UIImage(named: "Sunglass")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let numberOfItems = UILabel(frame: CGRect(x: 300, y: 20, width: 20, height: 20))
        numberOfItems.backgroundColor = UIColor.red
        numberOfItems.layer.cornerRadius = numberOfItems.frame.width
        navigationController?.navigationBar.addSubview(numberOfItems)
        numberOfItems.textColor = .white
        numberOfItems.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hub = RKNotificationHub(barButtonItem: navigationItem.rightBarButtonItem)
        self.hub.bump()
    }
    
    func goShoppingBag(){
        let storyboad = UIStoryboard(name: "GoShopping", bundle: nil)
        let goShoppingBag = storyboad.instantiateViewController(withIdentifier: "SBVC")
        navigationController?.pushViewController(goShoppingBag, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GoShoppingViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commedityArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCell
        cell.shoppingName.text = commedityArr[indexPath.item].commedityName
        cell.shoppingPrice.text = commedityArr[indexPath.item].commedityPrice
        cell.shoppingPicture.image = UIImage(named: commedityArr[indexPath.item].commedityImage)
        cell.delegate = self
        cell.item = commedityArr[indexPath.item]
        return cell
    }
}

extension GoShoppingViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 20) / 2
        let height:CGFloat = 208
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.item = Commedity(img: commedityArr[indexPath.item].commedityImage, name: commedityArr[indexPath.item].commedityName, price: commedityArr[indexPath.item].commedityPrice, Qty: 1)
        
    }
    
}

extension GoShoppingViewController:ShoppingCellDelegate{
    func addCommedity(_ item: Commedity) {
        self.hub.increment()
        self.hub.bump()
    }
}
