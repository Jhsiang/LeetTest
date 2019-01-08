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
