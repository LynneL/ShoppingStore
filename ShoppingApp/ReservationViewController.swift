//
//  ReservationViewController.swift
//  ShoppingApp
//
//  Created by Lynn on 7/18/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {
    
    @IBOutlet weak var reservationList: UICollectionView!
    var days:[Day] = []
    var index:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        reservationList.register(UINib(nibName: "DateViewCell", bundle: nil), forCellWithReuseIdentifier: "DateViewCell")
        reservationList.register(UINib(nibName: "TimeCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
        var weekStr:String = ""
        var monthStr:String = ""
        let today = Date()
        let calendar = NSCalendar.current
        
        var i = 0
        while i < 90{
            let tomorrow = Calendar.current.date(byAdding: .day, value: i, to: today)
            let week = calendar.component(.weekday, from: tomorrow!)
            let day = calendar.component(.day, from: tomorrow!)
            let month = calendar.component(.month, from: tomorrow!)
            

            for w in Utility.iterateEnum(Week.self){
                if w.rawValue == week{
                    weekStr = w.description
                }
            }
            
            for m in Utility.iterateEnum(Month.self){
                if m.rawValue == month{
                    monthStr = m.description
                }
            }
            
            var timeSlot:[String] = []
            let  nextHour = Calendar.current.date(byAdding: .hour, value: 1, to: today)
            var hour = calendar.component(.hour, from: nextHour!)
            if hour < 10 {
                hour = 10
            }
            while hour <= 22{
                if hour > 12 {
                    timeSlot.append("\(hour-12):00 PM")
                }else{
                    timeSlot.append("\(hour):00 AM")
                }
                hour += 1
            }
            
            let dayValue = Day(week: weekStr, day: "\(day)", month: monthStr, timeSlots: timeSlot)
            days.append(dayValue)
            i += 1
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}

extension ReservationViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell!
        if indexPath.item == 0{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateViewCell", for: indexPath) as! DateViewCell
            (cell as! DateViewCell).days = self.days
            (cell as! DateViewCell).delegate = self
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
            (cell as! TimeCell).day = days[index]
            (cell as! TimeCell).timeList.reloadData()
        }
        return cell
    }
}

extension ReservationViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0{
            let width = view.frame.size.width
            let height:CGFloat = 190
            return CGSize(width: width, height: height)
        }else{
            let width = view.frame.size.width
            let height:CGFloat = 210
            return CGSize(width: width, height: height)
        }
    }

}

extension ReservationViewController:DateViewCellDelegate{
    func didSelectDate(_ index: Int) {
        
        self.index = index
        reservationList.reloadItems(at: [IndexPath(item: 1, section: 0)])
    }
}
