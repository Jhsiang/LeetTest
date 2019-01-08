//
//  BKLeetCode1.swift
//  LeetTest
//
//  Created by Jim Chuang on 2019/1/8.
//  Copyright © 2019 jj. All rights reserved.
//

import Foundation

class leet1 {

    // 質數，倒數亦是且不可與倒數相同
    func backwardsPrime(_ start: Int, _ stop: Int) -> [Int] {
        var result:Array<Int> = Array<Int>()
        for i in start...stop{
            if i < 10{continue}

            if isPrime(num: i){
                if let reverse = getReversed(num: i){
                    if isPrime(num: reverse){
                        result.append(i)
                    }
                }
            }
        }
        return result
    }

    private func isPrime(num:Int) -> Bool{
        if num == 2 {return true}
        if num == 3 {return true}
        var n = 2
        while n*n <= num {
            if num % n == 0{
                return false
            }
            n += 1
        }
        return true
    }

    private func getReversed(num:Int) -> Int?{
        guard num >= 10 else {
            return num
        }
        var inputNum = num
        var resultNum = 0
        while inputNum > 0 {
            resultNum = (inputNum % 10 ) + resultNum * 10
            inputNum /= 10
        }
        return resultNum == num ? nil : resultNum
    }
}

class leet2{

    //加權計算
    func evaluate(good: String, vsEvil evil: String) -> String {
        var resultStr = ""

        let goods = [1,2,3,3,4,10]
        let evils = [1,2,2,2,3,5,10]

        let goodCharArr = Array(good)
        let evilCharArr = Array(evil)

        var goodArr = Array<String>()
        var evilArr = Array<String>()
        var goodStr = ""
        var evilStr = ""

        for x in goodCharArr{
            if x != " "{
                goodStr += goodStr + String(x)

            }else if x == " "{
                goodArr.append(goodStr)
                goodStr = ""
            }
        }
        goodArr.append(goodStr)

        for x in evilCharArr{
            if x != " "{
                evilStr += String(x)
            }else{
                evilArr.append(evilStr)
                evilStr = ""
            }
        }
        evilArr.append(evilStr)

        guard goodArr.count == goods.count && evilArr.count == evils.count else {
            return "fail"
        }

        var goodSum = 0
        var evilSum = 0

        for (index,value) in goodArr.enumerated(){
            if let intValue = Int(value){
                goodSum += goods[index] * intValue
            }
        }

        for (index,value) in evilArr.enumerated(){
            if let intValue = Int(value){
                evilSum += evils[index] * intValue
            }
        }


        if goodSum > evilSum{
            resultStr = "Battle Result: Good triumphs over Evil"
        }else if goodSum < evilSum{
            resultStr = "Battle Result: Evil eradicates all trace of Good"
        }else{
            resultStr = "Battle Result: No victor on this battle field"
        }

        return resultStr
    }
}

class leet3 {
    /*
     addOne = add(1)
     addOne(3) // 4
     addOne(7) // 8
     */
    func add(_ n: Int) -> ((Int) -> Int) {
        func addOne(num:Int) -> Int{
            return num + n
        }
        return addOne
    }
}
