//
//  cow.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/6/12.
//  Copyright © 2018年 jj. All rights reserved.
//

import Foundation
import UIKit

class cow {
    var years = 0
    var isDead = false
}

func calCow(years:Int) -> Int{
    let bull = cow()
    var bullArr = [bull]
    for _ in 1...years{
        for subBull in bullArr{
            subBull.years += 1
            if subBull.years % 2 == 0 && subBull.isDead == false{
                let newBull = cow()
                bullArr.append(newBull)
            }
            if subBull.years >= 5 && subBull.isDead == false{
                subBull.isDead = true
            }
        }
    }
    bullArr = bullArr.filter{$0.isDead == false}
    return bullArr.count
}

class event{
    var name = ""
    var date = ""
}

func translate(d:Date) -> String{
    let myDateformat = DateFormatter()
    myDateformat.dateFormat = "MM/dd"
    let str = myDateformat.string(from: d)
    return str
}

