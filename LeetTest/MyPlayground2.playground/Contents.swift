import UIKit

var str = "Hello, playground"
print("str = ",str)

import Foundation

func tour(_ friends: [String], _ friendsTowns: [String:String], _ dist: [String:Double]) -> Int {
    var res:Double = 0
    var nowLoc:Double = 0
    for i in friends{
        if let town = friendsTowns[i]{
            if let dis = dist[town]{
                res += calS(a: nowLoc, c: dis)
                nowLoc = dis
            }
        }
    }
    res += nowLoc
    
    return Int(res)
}


func calS(a:Double,c:Double) -> Double{
    return pow(pow(Double(c), 2) - pow(Double(a), 2), 0.5)
}

let aa = ["A1", "A2", "A3", "A4", "A5"]
let bb = ["A4": "X4", "A3": "X3", "A1": "X1", "A2": "X2"]
let cc = ["X3": 250.0, "X1": 100.0, "X2": 200.0, "X4": 300.0]
print(tour(aa, bb, cc))
