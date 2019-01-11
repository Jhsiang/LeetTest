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

class leet4 {

    //分解重新排列
    func stockList(_ listOfArt: [String], _ listOfCat: [String]) -> String {
        var res = ""
        var listDic = Dictionary<String,Int>()
        var resDic = Dictionary<String,Int>()
        for char in listOfCat{
            resDic[char] = 0
        }

        for i in listOfArt{
            if let mySpaceIndex = i.range(of: " "){
                let start = String(i.prefix(upTo: mySpaceIndex.lowerBound))
                let end = String(i.suffix(from: mySpaceIndex.upperBound))
                listDic[start] = Int(end)
            }else{

            }
        }

        for i in listOfCat{
            for key in listDic.keys{
                if let first = key.first{
                    if i.first == first{
                        resDic[i] = resDic[i]! + listDic[key]!
                    }
                }
            }
        }

        var resKeyArr = Array<String>()
        for key in resDic{
            resKeyArr.append(key.key)
        }
        resKeyArr.sort()

        for (index,key) in resKeyArr.enumerated(){
            res = res + "(\(key) : \(resDic[key]!))"
            if index != resKeyArr.count - 1{
                res = res + " - "
            }
        }
        return res
    }
}

class leet5 {
    //"abcd" -> "A-Bb-Ccc-Dddd"
    func accum(_ s: String) -> String {
        var res = ""

        let arr = Array(s).map{String($0)}
        var resArr = arr

        for (index,str) in arr.enumerated(){
            resArr[index] = str.uppercased()
            for _ in 0..<index{
                resArr[index] += str.lowercased()
            }
        }

        res = resArr.joined(separator: "-")
        
        return res
    }
}

class leet6{
    // 移除與5相關的數字
    func dontGiveMeFive(_ start: Int, _ end: Int) -> Int {
        var arr = Array<Int>()
        for x in start...end{
            let str = String(x)
            if !str.contains("5"){
                arr.append(x)
            }
        }
        return arr.count
    }
}

class leet7{

    //輸出 a2中 含有a1 的字串且不重覆
    func inArray(_ a1: [String], _ a2: [String]) -> [String] {
        var resArr = Array<String>()
        for strA1 in a1{
            for strA2 in a2{
                if strA2.contains(strA1) && !resArr.contains(strA1){
                    resArr.append(strA1)
                    break
                }
            }
        }
        resArr.sort()
        return resArr
    }
}

class leet8{

    //抓最小的兩個
    func sumOfTwoSmallestIntegersIn(_ array: [Int]) -> Int {
        var arr = array.sorted(by: {$0 < $1})
        var res = arr[0] + arr[1]
        return res
    }
}

class leet9 {

    //分解相乘
    func persistence(for num: Int) -> Int {
        var resCount = 0
        var resNum = num
        while resNum >= 10 {
            resCount += 1
            var sum = 1
            let pw = Int(log10(Double(resNum)))
            for x in 0...pw{
                sum = sum * (Int(Double(resNum) / pow(10.0, Double(x))) % 10)
            }
            resNum = sum
        }
        return resCount
    }

    func persistence2(for num: Int) -> Int {
        let digits: [Int] = String(num).characters.flatMap { Int(String($0)) }

        return digits.count == 1 ? 0 : 1 + persistence(for: digits.reduce(1, *))
    }

    func digitalRoot(of number: Int) -> Int {
        var res = 0

        let str = String(number)
        var arr = Array(str).map{Int(String($0))!}

        while arr.count > 1 {
            var sum = 0
            for x in arr{
                sum += x
            }
            let str2 = String(sum)
            arr = Array(str2).map{Int(String($0))!}
        }

        res = arr[0]
        return res
    }
}

class leet10 {

    //龜兔賽跑 算時間
    func race(v1: Int, v2: Int, g: Int) -> [Int]? {
        guard v1 <= v2 else {
            return nil
        }

        var resArr = [0,0,0]
        let diffPerSec = (Double(v2) - Double(v1)) / 3600
        var totalSec = Double(g) / diffPerSec
        while totalSec >= 60 * 60 {
            totalSec -= 3600
            resArr[0] += 1
        }

        while totalSec >= 60 {
            totalSec -= 60
            resArr[1] += 1
        }

        while Int(totalSec) > 0 {
            totalSec -= 1
            resArr[2] += 1
        }

        return resArr
    }

    func race2(_ v1: Int,_ v2: Int,_ g: Int) -> [Int]? {
        let h = g / (v2 - v1)
        let m = ((g % (v2-v1)) * 60) / (v2-v1)
        let s = (((g % (v2-v1)) * 60) % (v2-v1)) * 60 / (v2-v1)

        return v2 > v1 ? [h, m, s] : nil
    }
}

class leet11{

    //找到消失的數字
    func findDeletedNumber(_ array: [Int], _ mixArray: [Int]) -> Int {
        guard array.count - 1 == mixArray.count else {
            return 0
        }
        let strArr = array.map{String($0)}
        let mixStrArr = mixArray.map{String($0)}

        for str in strArr{
            if !mixStrArr.contains(str){
                return Int(str)!
            }
        }

        return 0
    }
}

class leet12{

    //rgb 轉16進制
    func rgb(_ r: Int, _ g: Int, _ b: Int) -> String {
        var res = ""

        let keyArr = Array(0...15)
        let af = (0x41...0x46).map({Character(UnicodeScalar($0))})
        let num = (0x30...0x39).map({Character(UnicodeScalar($0))})
        let valueArr = num + af
        var myDic = Dictionary<Int,String>()
        for x in 0..<keyArr.count{
            myDic[keyArr[x]] = String(valueArr[x])
        }

        func convertToHex(input:Int) -> String{
            guard input <= 255 else {return "FF"}
            guard input >= 0 else {return "00"}
            var hight = 0
            let low = input % 16
            var myNum = input
            while myNum >= 16 {
                hight += 1
                myNum -= 16
            }
            return myDic[hight]! + myDic[low]!
        }

        res = convertToHex(input: r) + convertToHex(input: g) + convertToHex(input: b)

        return res
    }

    func rgb2(_ r: Int, _ g: Int, _ b: Int) -> String {
        func norm(_ n: Int) -> Int {
            return min(255, max(0, n))
        }
        return String(format: "%02X%02X%02X", norm(r), norm(g), norm(b))
    }

}

class leet13{

    //字串轉數字，相加一次後比大小，如果相同則比字串
    func orderWeight(_ s: String) -> String {
        var res = ""
        guard s.characters.count > 0 else {
            return res
        }
        var strArr = s.components(separatedBy: " ")
        var intArr = strArr.map{Int($0)!}
        for i in 0..<intArr.count{
            for j in 0..<intArr.count - 1 - i{
                if digitalOneTimesRoot(of: intArr[j]) == digitalOneTimesRoot(of: intArr[j+1]){
                    if String(intArr[j]) > String(intArr[j+1]){
                        (intArr[j],intArr[j+1]) = (intArr[j+1],intArr[j])
                    }
                }else if digitalOneTimesRoot(of: intArr[j]) > digitalOneTimesRoot(of: intArr[j+1]){
                    (intArr[j],intArr[j+1]) = (intArr[j+1],intArr[j])
                }
            }
        }
        strArr = intArr.map{String($0)}

        res = strArr.joined(separator: " ")
        return res
    }

    private func digitalOneTimesRoot(of number: Int) -> Int {
        var res = 0

        let str = String(number)
        let arr = str.characters.map{Int(String($0))!}
        for x in arr{
            res += x
        }
        return res
    }


    func orderWeight2(_ s: String) -> String {
        let parts = s.components(separatedBy: " ")
        let sorted = parts.sorted { (lr, rr) -> Bool in
            let ls = sum(lr)
            let rs = sum(rr)
            if ls == rs { return lr <= rr }
            return ls <= rs
        }
        return sorted.joined(separator: " ")
    }

    func sum(_ s: String) -> Int {
        return s.characters.map{Int(String($0)) ?? 0}.reduce(0, +)
    }
}

class leet14{
    func thirt(_ n: Int) -> Int {
        var arr = [1, 10, 9, 12, 3, 4]
        let intArr = String(n).characters.flatMap{Int(String($0))}.reversed()
        var sum = 0
        for (i,v) in intArr.enumerated(){
            sum += v * arr[i % 6]
        }
        return sum == n ? sum : thirt(sum)
    }
}

class leet15{

    // 拿起一個數，插入任意位置，取最小
    func smallest(_ n: Int) -> (Int, Int, Int) {
        var v = 0
        var s = 0
        var e = 0
        var strArr = String(n).characters.flatMap{String($0)}.map{String($0)}
        v = n

        for i in 0..<strArr.count{
            for j in 0..<strArr.count{
                var newArr = strArr
                let insertNum = newArr[i]
                newArr.remove(at: i)
                newArr.insert(insertNum, at: j)

                let newNum = Int(newArr.joined())!
                if newNum < v {
                    v = newNum
                    s = i
                    e = j
                }
            }
        }
        return (v,s,e)
    }
}

class leet16{

    // 陣列選人物
    func streetFighterSelection(fighters: [[String]], position: (row: Int, column: Int), moves: [Direction]) -> [String] {
        var res = Array<String>()
        var r = position.row
        var c = position.column

        for step in moves{
            switch step {
            case .up:
                r = r == 0 ? r : r - 1
                res.append(fighters[r][c])
            case .down:
                r = r == 1 ? r : r + 1
                res.append(fighters[r][c])
            case .left:
                c = c == 0 ? 5 : (c - 1) % 6
                res.append(fighters[r][c])
            case .right:
                c = (c + 1) % 6
                res.append(fighters[r][c])
            }
        }
        return res
    }

    enum Direction:Int{
        case up
        case down
        case left
        case right
    }

    let fighters2 = [
        ["Ryu", "E.Honda",  "Blanka",   "Guile", "Balrog", "Vega"],
        ["Ken", "Chun Li", "Zangief", "Dhalsim",  "Sagat", "M.Bison"]
    ]
}
