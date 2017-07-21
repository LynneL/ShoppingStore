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
    var hours:[Time] = []
    var weekStr:String = ""
    var monthStr:String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        reservationList.register(UINib(nibName: "DateViewCell", bundle: nil), forCellWithReuseIdentifier: "DateViewCell")
        reservationList.register(UINib(nibName: "TimeCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
        let today = Date()
        var calendar = NSCalendar.current
        
        
        var i = 0
        while i < 90{
            var tomorrow = Calendar.current.date(byAdding: .day, value: i, to: today)
            let week = calendar.component(.weekday, from: tomorrow as! Date)
            let day = calendar.component(.day, from: tomorrow as! Date)
            let month = calendar.component(.month, from: tomorrow as! Date)

            

            for w in Utility.iterateEnum(Week){
                if w.rawValue == week{
                    weekStr = w.description
                }
            }
            
            for m in Utility.iterateEnum(Month){
                if m.rawValue == month{
                    monthStr = m.description
                }
            }
            
            var dayValue = Day(week: weekStr, day:"\(day)" , month: monthStr)
            days.append(dayValue)
            i += 1
        }
        
        
        var h = 0
        while h < 15{
            var nextHour = Calendar.current.date(byAdding: .hour, value: h, to: today)
            let hour = calendar.component(.hour, from: nextHour as! Date)
            var hourValue = Time(hour: "hour")
            hours.append(hourValue)
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
        if indexPath.section == 0{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateViewCell", for: indexPath) as! DateViewCell
            (cell as! DateViewCell).days = self.days
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
            (cell as! TimeCell).hours = self.hours
        }
    }
}

extension ReservationViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
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
