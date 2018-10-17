//
//  cow.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/6/12.
//  Copyright © 2018年 jj. All rights reserved.
//

import Foundation
import UIKit

class testClassShare{
    static let share = testClassShare()

    var a = 1
    var b = 2
    var c = 3
    var d = 4

    func add(){
        a += 1
    }

    func clean(){
        a = 1
        b = 2
        c = 3
        d = 4
    }

    func isReady() -> Bool{
        if a == 5, b == 2, c == 3, d == 4{
            return true
        }else{
            return false
        }
    }
}

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

