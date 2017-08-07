//
//  ReservationViewController.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/23/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {
    
    @IBOutlet weak var reservationList: UICollectionView!
    @IBOutlet weak var reservationImage: UIImageView!
    var days:[Day] = []
    var weekStr:String = ""
    var monthStr:String = ""
    var index = 0
    var reservationArr:[Reservation] = []
    
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        reservationList.register(UINib(nibName: "ReservationDateCell", bundle: nil), forCellWithReuseIdentifier: "ReservationDateCell")
        reservationList.register(UINib(nibName: "ReservationTimeCell", bundle: nil), forCellWithReuseIdentifier: "ReservationTimeCell")
        reservationList.register(UINib(nibName: "MyReservationCell", bundle: nil), forCellWithReuseIdentifier: "MyReservationCell")
        
        self.reservationImage.image = UIImage(named: "Sixth")
        automaticallyAdjustsScrollViewInsets = false
        segmentControll.layer.masksToBounds = true
        
        let today = Date()
        let calendar = Calendar.current
        
        var i = 0
        while i <= 90{
            
            let nextDay = calendar.date(byAdding: .day, value: i, to: today)
            
            let day = calendar.component(.day, from: nextDay!)
            let week = calendar.component(.weekday, from: nextDay!)
            let month = calendar.component(.month, from: nextDay!)
            
            
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
            
            var t = 10
            var time:String = ""
            var timeSlot:[String] = []
            if calendar.component(.hour, from: today) > 10 && nextDay! == today {
                t = calendar.component(.hour, from: today) + 1
            }
            
            while t <= 22{
                if t <= 12{
                    time = "\(t):00 AM"
                }else{
                    time = "\(t - 12):00 PM"
                }
                timeSlot.append(time)
                t += 1
            }
            
            
            let dayValue = Day(month: monthStr, date: "\(day)", week: weekStr, timeSlots: timeSlot, selectedIndex: -1)
            days.append(dayValue)
            i += 1
        }
        
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        reservationList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ReservationViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.segmentControll.selectedSegmentIndex == 0{
            return reservationArr.count
        }else{
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell!
        if self.segmentControll.selectedSegmentIndex == 1{
            if indexPath.item == 0 {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReservationDateCell", for: indexPath) as! ReservationDateCell
                (cell as! ReservationDateCell).days = self.days
                (cell as! ReservationDateCell).delegate = self
            }else{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReservationTimeCell", for: indexPath) as! ReservationTimeCell
                (cell as! ReservationTimeCell).day = self.days[index]
                if self.days[index].selectedIndex != -1 {
                    (cell as! ReservationTimeCell).reserveButton.isEnabled = true
                }else{
                    self.automaticallyAdjustsScrollViewInsets = false
                    (cell as! ReservationTimeCell).reserveButton.isEnabled = false
                    (cell as! ReservationTimeCell).delegate = self
                    //self.days[index].selectedIndex = indexPath.item
                }
                (cell as! ReservationTimeCell).updateDayHandler = { [unowned self] day in
                    for i in 0..<self.days.count {
                        if self.days[i].month == day.month && self.days[i].week == day.week {
                            self.days[i] = day
                        }
                    }
                }
            }
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyReservationCell", for: indexPath) as! MyReservationCell
            (cell as! MyReservationCell).chosedWeek.text = reservationArr[indexPath.item].day.week + "," + reservationArr[indexPath.item].day.month
            (cell as! MyReservationCell).chosedDate.text = reservationArr[indexPath.item].day.date + ", 2017"
            (cell as! MyReservationCell).chosedTime.text = "Time:" + reservationArr[indexPath.item].day.timeSlots[indexPath.item]
            (cell as! MyReservationCell).delegate = self
            (cell as! MyReservationCell).index = indexPath.item
        }
        return cell
    }
}

extension ReservationViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.segmentControll.selectedSegmentIndex == 1{
            if indexPath.item == 0{
                let width = view.frame.width
                let height:CGFloat = 120
                return CGSize(width: width, height: height)
            }else{
                let width = view.frame.width
                let height:CGFloat = 224
                return CGSize(width: width, height: height)
            }
            
        }else{
            let width = (view.frame.width - 30) / 2
            let height:CGFloat = 194
            return CGSize(width: width, height: height)
        }
    }
}

extension ReservationViewController:ReservationDateDelegate{
    
    func didSelectDate(_ index: Int) {
        self.index = index
        reservationList.reloadData()
    }
}

extension ReservationViewController:ReservationTimeCellDelegate{
    
    func reserve(day: Day) {
        let reservation = Reservation(day: day)
        self.reservationArr.append(reservation)
        segmentControll.selectedSegmentIndex = 0
        reservationList.reloadData()
    }
}

extension ReservationViewController:MyReservationCellDelegate{
    
    func rescheduleTime(_ index: Int) {
        self.index = index
        segmentControll.selectedSegmentIndex = 1
        reservationList.reloadData()
    }
    
    func deleteTime(_ index: Int) {
        self.index = index
        reservationArr.remove(at: index)
        reservationList.reloadData()
    }
    
}
