//
//  Commedity.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/25/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation

struct Commedity {
    
    let commedityName:String
    let commedityImage:String
    let commedityPrice:String
    var chosedSize:Double = 7.5
    var chosedQty:Int = 1
    
    init(img:String,name:String,price:String,Qty:Int) {
        commedityImage = img
        commedityName = name
        commedityPrice = price
        chosedQty = Qty
    }
    
}
