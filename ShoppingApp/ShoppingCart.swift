//
//  ShoppingCart.swift
//  ShoppingApp
//
//  Created by 李玲 on 7/25/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation

struct ShoppingCart {
    
    private(set) static var items:[Commedity] = []
    
    
    static func add(Item item:Commedity) {
        //items.append(item)
        var i = 0
        if ShoppingCart.items.count == 0{
            items.append(item)
        }else{
            var flag = true
            while i < ShoppingCart.items.count{
                defer{
                    i += 1
                }
                if item.commedityName == self.items[i].commedityName{
                    items[i].chosedQty += 1
                    flag = false
                    break
                }
            }
            
            if flag {
                items.append(item)
            }
        }
        
    }
    
    static func remove(Item item:Commedity){
        var i = 0
        while i < ShoppingCart.items.count{
            defer{
                i += 1
            }
            if item.commedityName == self.items[i].commedityName{
                items.remove(at: i)
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShouldUpdatePrice"), object: nil, userInfo: ["NewValue":check(),"Reload":true])
    }
    
    
    static func update(Item item:Commedity) {
        var i = 0
        while i < ShoppingCart.items.count{
            if item.commedityName == self.items[i].commedityName{
                ShoppingCart.items[i].chosedQty = item.chosedQty
                i += 1
                break
            }
            
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShouldUpdatePrice"), object: nil, userInfo: ["NewValue":check(),"Reload":false])
    }
    
    
    
    static func clearCart(){
        
    }
    
    static func search(Item item:Commedity)->Bool{
        return true
    }
    
    static func check() -> (subStr:String, taxStr:String, totalStr:String){
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        var subtotal:Float = 0
        var tax:Float = 0
        var total:Float = 0
        var i = 0
        while i < ShoppingCart.items.count{
            defer {
                i += 1
            }
            let price = items[i].commedityPrice.replacingOccurrences(of: " USD", with: "")
            let num = formatter.number(from: price) as! Float
            subtotal += Float(num) * Float(items[i].chosedQty)
        }
        subtotal = round(subtotal * 100)/100
        tax = round((subtotal * 8.9 / 100)*100)/100
        total = round((subtotal + tax)*100)/100
        return ("\(subtotal)", "\(tax)", "\(total)")
    }
}

