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
        return String(format: "%02x%02x%02x", norm(r), norm(g), norm(b))
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

class leet17 {
    //Sum by Factors
    func sumOfDivided(_ l: [Int]) -> [(Int, Int)] {
        var res = Array<(Int,Int)>()
        let count = l.count
        let absArr = l.map{abs($0)}
        var facArr:Array<Array<Int>> = Array(repeating: [], count: count)
        for x in 0..<count{
            if isPrime(num: absArr[x]){
                facArr[x].append(absArr[x])
            }else{
                var d = 2
                while d*d <= absArr[x] {
                    if absArr[x] % d == 0{
                        let quo = absArr[x] / d
                        if isPrime(num: d) {
                            facArr[x].append(d)
                        }
                        if d != quo && isPrime(num: quo){
                            facArr[x].append(quo)
                        }
                    }
                    d += 1
                }
            }
        }
        let orderArr = Array(Set(facArr.flatMap{$0})).sorted()

        for key in orderArr{
            var sum = 0
            for i in 0..<facArr.count{
                if facArr[i].contains(key){
                    sum += l[i]
                }
            }
            res.append((key,sum))
        }
        print(res)
        return res
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
}

class leet18 {

    // find prime gap
    func gap(_ g: Int, _ m: Int, _ n: Int) -> (Int, Int)? {

        guard n > m else {
            return nil
        }

        var firstPrime:Int? = nil
        for nextPrime in m...n{
            if isPrime(num: nextPrime){
                if firstPrime == nil{
                    firstPrime = nextPrime
                }else{
                    if nextPrime - firstPrime! == g{
                        return (firstPrime!,nextPrime)
                    }else{
                        firstPrime = nextPrime
                    }
                }
            }
        }

        return nil
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
}

class leet19{
    //Pn取m Pn取k (考慮順序，不重覆，排列)
    func permutations(arr:Array<Int>,taken:Int) -> Array<Array<Int>>{
        guard taken <= arr.count else {
            return [[]]
        }

        var resArr = Array<Array<Int>>()

        for ele in arr{
            resArr.append([ele])
        }

        //包括低階陣列
        var totalArr = Array<Array<Int>>()
        totalArr += resArr

        for _ in 1..<taken{
            //避免低階陣列重復使用
            var newArr = Array<Array<Int>>()
            for (i,v) in resArr.enumerated(){
                for ele in arr{
                    if !resArr[i].contains(ele){
                        newArr.append(v + [ele])
                    }
                }
            }
            totalArr += newArr
            resArr = newArr
        }

        return resArr
    }

    //Pn取m Pn取k (考慮順序，不重覆，排列)
    //contains 需使用Equatable 一類
    func p<T:Equatable>(arr:Array<T>,taken:Int) -> Array<Array<T>>{
        guard taken <= arr.count else {
            return [[]]
        }

        var resArr = Array<Array<T>>()

        for ele in arr{
            resArr.append([ele])
        }

        //包括低階陣列
        var totalArr = Array<Array<T>>()
        totalArr += resArr

        for _ in 1..<taken{
            //避免低階陣列重復使用
            var newArr = Array<Array<T>>()
            for (i,v) in resArr.enumerated(){
                for ele in arr{
                    if !resArr[i].contains(ele){
                        newArr.append(v + [ele])
                    }
                }
            }
            totalArr += newArr
            resArr = newArr
        }

        return resArr
    }
}

class leet20{

    // 各種組合加總
    func gta(limit: Int, args:[Int]) -> Int {
        var sum = 0

        let taken = limit
        let arr = takeNewNum(ar: args, num: limit)

        guard taken <= arr.count else {
            return 0
        }

        var resArr = Array<Array<Int>>()

        for ele in arr{
            resArr.append([ele])
            sum += ele
        }


        for _ in 1..<taken{
            var newArr = Array<Array<Int>>()
            for (i,v) in resArr.enumerated(){
                for ele in arr{
                    if !resArr[i].contains(ele){
                        newArr.append(v + [ele])
                        sum += v.reduce(0, +)
                        sum += ele
                    }
                }
            }
            resArr = newArr
        }


        return sum
    }

    // 依順序，拿陣列內的數(一個一個取)
    func takeNewNum(ar:[Int],num:Int) ->[Int]{
        var res = [Int]()

        let strArr = ar.map{String($0)}
        var strArr2D = Array<Array<String>>()
        for str in strArr{
            let ele = str.characters.flatMap{$0}.map{String($0)}
            strArr2D.append(ele)
        }
        var myindex = 0

        while res.count < num{
            let takeIndex = myindex % strArr2D.count
            if strArr2D[takeIndex].count > 0{
                let addNum = Int(strArr2D[takeIndex][0])!
                if !res.contains(addNum){
                    res.append(addNum)
                }
                strArr2D[takeIndex].removeFirst()
            }
            myindex += 1
        }

        return res
    }
}

class leet21{
    //ΣnX^n = m, know m find x, x in 0..<1
    func solve(_ m: Double) -> Double {
        var res:Double = 0
        var min:Double = 0
        var max:Double = 1
        var sum:Double = 0

        while sum != m {
            res = (max + min) / 2

            if res == max || res == min{
                break
            }

            sum = res / ((1-res)*(1-res))
            if sum == m{
                break
            }else if sum > m{
                max = res
            }else if sum < m{
                min = res
            }
        }
        return res
    }

    //從方程式解
    func solve2(_ m:Double) -> Double{
        let a = (1/m) + 2
        return (a - sqrt(a*a - 4)) / 2
    }
}

class leet22{
    //未完成 tip:歐拉函數
    //Last digit of a huge number
    func lastDigit<S>(_ numbers: S) -> Int where S: Sequence, S.Iterator.Element == Int {

        var arr = [Int]()
        for ele in numbers{
            arr.append(ele)
        }

        var ele = numbers.makeIterator()


        if let firstInt = ele.next(){
            let firstDigits = firstInt % 10
            switch firstDigits {
            case 0,1,5,6:
                return firstInt == 0 ? 1 : firstDigits
            case 4,9:
                if var secondInt = ele.next(){
                    secondInt = secondInt == 0 ? 0 : (secondInt % 2) + 2
                    if var thirdInt = ele.next(){
                        thirdInt = thirdInt == 0 ? 0 : thirdInt % 2 + 2
                        secondInt = secondInt.getPower(n: thirdInt)
                        secondInt = secondInt == 0 ? 0 : (secondInt % 2) + 2
                        if var fouthInt = ele.next(){
                            fouthInt = fouthInt == 0 ? 0 : fouthInt % 2 + 2
                            thirdInt = thirdInt.getPower(n: fouthInt)
                            thirdInt = thirdInt == 0 ? 0 : thirdInt % 2 + 2
                            secondInt = secondInt.getPower(n: thirdInt)
                            secondInt = secondInt == 0 ? 0 : (secondInt % 2) + 2
                            return firstDigits.getPower(n: secondInt) % 10
                        }else{
                            return firstDigits.getPower(n: secondInt) % 10
                        }
                    }else{
                        return firstDigits.getPower(n: secondInt) % 10
                    }
                }else{
                    return firstDigits
                }
            case 2,3,7,8:
                if var secondInt = ele.next(){
                    if var thirdInt = ele.next(){
                        if var fouthInt = ele.next(){

                            if fouthInt != 0{
                                fouthInt = (fouthInt % 4) == 0 ? 4 : fouthInt % 4
                                thirdInt = thirdInt >= 2 ? 2 : thirdInt % 2
                                thirdInt = thirdInt.getPower(n: fouthInt)
                            }else{
                                thirdInt = 1
                            }

                            if thirdInt != 0{
                                thirdInt = thirdInt >= 2 ? 2 : thirdInt % 2
                                secondInt = secondInt % 4 == 0 ? 4 : secondInt % 4
                                secondInt = secondInt.getPower(n: thirdInt)
                            }else{
                                secondInt = secondInt.getPower(n: thirdInt)
                            }

                            if secondInt != 0{
                                secondInt = secondInt % 4 == 0 ? 4 : secondInt % 4
                                return firstDigits.getPower(n: secondInt) % 10
                            }else{
                                return firstDigits.getPower(n: secondInt) % 10
                            }

                        }else{

                            if thirdInt != 0{
                                thirdInt = thirdInt >= 3 ? 3 : thirdInt % 3
                                secondInt = secondInt % 4 == 0 ? 4 : secondInt % 4
                                secondInt = secondInt.getPower(n: thirdInt)
                            }else{
                                secondInt = secondInt.getPower(n: thirdInt)
                            }

                            if secondInt != 0{
                                secondInt = secondInt % 4 == 0 ? 4 : secondInt % 4
                                return firstDigits.getPower(n: secondInt) % 10
                            }else{
                                return firstDigits.getPower(n: secondInt) % 10
                            }
                        }
                    }else{
                        if secondInt != 0{
                            secondInt = secondInt % 4 == 0 ? 4 : secondInt % 4
                            return firstDigits.getPower(n: secondInt) % 10
                        }else{
                            return firstDigits.getPower(n: secondInt) % 10
                        }
                    }
                }else{
                    return firstDigits
                }
            default:
                break
            }
        }


        return 1
    }
}

class leet23{

    // 矩陣相乘
    func matrixMultiplication(_ a:[[Int]], _ b:[[Int]]) -> [[Int]] {
        guard a.count == b[0].count else {
            return [[0]]
        }

        var res = [[Int]]()
        var cArr = Array(repeating: Array(repeating: 0, count: b[0].count), count: a.count)
        for row in 0..<cArr.count{
            for col in 0..<cArr[0].count{
                for i in 0..<b.count{
                    cArr[row][col] += a[row][i] * b[i][col]
                }
            }
        }
        res = cArr

        return res
    }
}

class leet24{
    // 分數分解
    func decompose(_ nrStr: String, _ drStr: String) -> String {
        guard var son = Int(nrStr) else {return ""}
        guard var mom = Int(drStr) else {return ""}
        guard son != 0  else {return ""}
        guard mom != 0  else {return ""}

        var resArr = Array<String>()
        var resStr = ""

        if son >= mom{
            let q = son / mom
            resArr.append("\(q)")
            son = son % mom
            if son == 0 {
                return resArr.joined(separator: ",")
            }
        }

        (son,mom) = minmumNum(son: son, mom: mom)

        while son != 1 {
            let q = mom / son
            let nextMom = q + 1
            resArr.append("1/\(nextMom)")
            (son,mom) = spareHandle(son1: son, mom1: mom, son2: 1, mom2: nextMom)
        }
        resArr.append("1/\(mom)")

        resStr = resArr.joined(separator: ",")

        return resStr
    }

    private func spareHandle(son1:Int,mom1:Int,son2:Int,mom2:Int) -> (Int,Int){
        let son = son1 * mom2 - son2 * mom1
        let mom = mom1 * mom2
        return minmumNum(son: son, mom: mom)
    }

    private func minmumNum(son:Int,mom:Int) ->(Int,Int){
        let calSon = son
        let calMom = mom
        guard son != 1 else{
            return (calSon,calMom)
        }
        guard mom != 1 else{
            return (calSon,calMom)
        }
        for x in 2...calSon{
            if calSon % x == 0,calMom % x == 0{
                return minmumNum(son:calSon/x, mom:calMom/x)
            }
        }
        return (calSon,calMom)
    }

    func decompose2(_ nrStr: String, _ drStr: String) -> String {
        var son = Int(nrStr)!, mom = Int(drStr)!
        var arr = [String]()
        if son >= mom {
            arr.append(String(son / mom))
            son %= mom
        }
        var i = 2
        while true {
            if mom <= i * son {
                arr.append("1/\(i)")
                son = son * i - mom
                mom *= i
            }
            if (son == 0) {
                break
            }
            i += 1
        }
        return arr.joined(separator: ",")
    }
}

class leet25{
    //Is my friend cheating?
    //1...n的和 減掉a,b = a*b, where a,b in 1...n
    func removNb(_ n: Int) -> [(Int,Int)] {
        var resArr = [(Int,Int)]()

        //先乘 就不用轉為Double
        let sum = (1+n)*n / 2
        /*
         (1+n)/2 * n = (1/2)n + (1/2)n^2 = sum
         sum - a - b = a * b
         sum = a*b +a +b
         sum + 1 = (a+1)(b+1)
         b = (sum+1)/(a+1) - 1
         b = sum - a / a + 1
         */
        for a in 1...n{
            let b = (sum - a) / (a + 1)
            if a * b == sum - (a+b) && b <= n{
                resArr.append((a,b))
            }
        }
        return resArr
    }
}

class leet26{
    //色碼電阻 解碼
    //Resistor Color Codes, Part 2
    func encodeResistorColors(_ ohmsString: String) -> String {
        var colorArr = ["black","brown","red","orange","yellow","green","blue","violet","grey","white"]
        var numStr = ohmsString.prefix(upTo: ohmsString.firstIndex(of: " ")!)

        var resArr = Array<String>()
        var res = ""

        // k,M,G 單位判斷
        if let num = Double(numStr){
            let myPow = Int(log10(num) - 1)
            let newNum = num / (pow(10, Double(myPow)))
            let firstNum = Int(newNum / 10)
            let secondNum = Int(newNum) % 10

            resArr.append(colorArr[firstNum])
            resArr.append(colorArr[secondNum])
            resArr.append(colorArr[myPow])
            resArr.append("gold")

        }else {
            let unit = numStr.last!
            numStr.removeLast()
            var num = Double(numStr)!

            switch unit {
            case "k":
                num *= 1_000
            case "M":
                num *= 1_000_000
            case "G":
                num *= 1_000_000_000
            default:
                break
            }

            let myPow = Int(log10(num) - 1)
            let newNum = num / (pow(10, Double(myPow)))
            let firstNum = Int(newNum / 10)
            let secondNum = Int(newNum) % 10

            resArr.append(colorArr[firstNum])
            resArr.append(colorArr[secondNum])
            resArr.append(colorArr[myPow])
            resArr.append("gold")
        }


        res = resArr.joined(separator: " ")
        return res
    }
}

// Leet27
// base64 encode/decode
extension String {
    public var toBase64: String {
        let base64Data = self.data(using: String.Encoding.utf8)
        if let base64Str = base64Data?.base64EncodedString(){
            return base64Str
        }else{
            return self
        }

    }

    public var fromBase64: String {
        if let data = Data(base64Encoded: self){
            if let dStr = String(data: data, encoding: String.Encoding.utf8){
                return dStr
            }
        }
        return self
    }
}

class leet28{
    //反方向判斷
    func dirReduc(_ arr: [String]) -> [String] {
        let arrInt = arr.map { (str) -> Int in
            switch str {
            case "NORTH":
                return 6
            case "SOUTH":
                return -6
            case "WEST":
                return -1
            case "EAST":
                return 1
            default:
                return 0
            }
        }

        var checkArr = [Int]()
        for x in arrInt{
            if -x == checkArr.last{
                checkArr.removeLast()
            }else{
                checkArr.append(x)
            }
        }

        let res = checkArr.map { (num) -> String in
            switch num {
            case 6:
                return "NORTH"
            case -6:
                return "SOUTH"
            case -1:
                return "WEST"
            case 1:
                return "EAST"
            default:
                return ""
            }
        }

        return res
    }
}

class leet29{

    //計算因數的數量
    func countKprimes(_ k: Int, _ start: Int, _ nd: Int) -> [Int] {
        var res = [Int]()

        for i in start...nd{
            if getFactor(num: i).count == k{
                res.append(i)
            }
        }
        return res
    }

    //任意數n拆解成 1...n裡 含有 1個因數，3個因數，7個因數 加總等於n 的數量
    func puzzle(_ s: Int) -> Int {
        var onePrimeArr = [Int]()
        var threePrimeArr = [Int]()
        var sevenPrimeArr = [Int]()
        var res = [[Int]]()

        for i in 1...s{
            switch getFactor(num: i).count {
            case 1:
                onePrimeArr.append(i)
            case 3:
                threePrimeArr.append(i)
            case 7:
                sevenPrimeArr.append(i)
            default:
                break
            }
        }

        for i in onePrimeArr{
            for j in threePrimeArr{
                for k in sevenPrimeArr{
                    if i + j + k == s{
                        res.append([i,j,k])
                    }
                }
            }
        }

        return res.count
    }

    func getFactor(num:Int) -> [Int]{
        var res = [Int]()
        var num = num
        if num < 2 {return []}

        var n = 2
        while n <= num{
            if num % n == 0{
                res.append(n)
                num /= n
            }else{
                n += 1
            }
        }

        return res.count > 0 ? res : []
    }
}

class leet30{

    //RGB 16進制轉10進制
    func hexStringToRGB(_ str:String) -> RGB {
        guard str.characters.count == 7 else{ return RGB(0, 0, 0)}
        var arrStr = Array(str.characters).map{String($0)}.map{$0.uppercased()}
        arrStr.removeFirst()

        let valueArr = Array(0...15)
        let af = (0x41...0x46).map({Character(UnicodeScalar($0))}).map{String($0)}
        let num = (0x30...0x39).map({Character(UnicodeScalar($0))}).map{String($0)}
        let keyArr = num + af
        var myDic = Dictionary<String,Int>()
        for x in 0..<keyArr.count{
            myDic[keyArr[x]] = valueArr[x]
        }

        let r = myDic[arrStr[0]]! * 16 + myDic[arrStr[1]]!
        let g = myDic[arrStr[2]]! * 16 + myDic[arrStr[3]]!
        let b = myDic[arrStr[4]]! * 16 + myDic[arrStr[5]]!

        return RGB(r, g, b)
    }

    func hexStringToRGB2(_ str:String) -> RGB {
        guard str.characters.count == 7 else{ return RGB(0, 0, 0)}
        var arrStr = Array(str.characters).map{String($0)}.map{$0.uppercased()}
        arrStr.removeFirst()

        let r = Int(arrStr[0] + arrStr[1], radix: 16)!
        let g = Int(arrStr[2] + arrStr[3], radix: 16)!
        let b = Int(arrStr[4] + arrStr[5], radix: 16)!

        return RGB(r, g, b)
    }

    struct RGB: CustomStringConvertible, Equatable {
        var r:Int
        var g:Int
        var b:Int
        init(_ r:Int, _ g:Int, _ b:Int) {
            self.r = r
            self.g = g
            self.b = b
        }
        static func ==(left:RGB, right:RGB) -> Bool {
            return left.r == right.r && left.g == right.g && left.b == right.b
        }
        var description: String {
            return "{R:\(r), G:\(g), B:\(b)}"
        }
    }
}

class leet31{

    //化為同分母
    func convertFracts(_ l: [(Int, Int)]) -> [(Int, Int)] {
        var l = l
        l = l.map({ (num) -> (Int,Int) in
            let (first,second) = minmumNum(son: num.0, mom: num.1)
            return (first,second)
        })
        var lcmArr = [Int]()
        for i in l{
            lcmArr.append(i.1)
        }

        if let lcm = minLCM(arr: lcmArr){
            l = l.map({ (num) -> (Int,Int) in
                let first = lcm * num.0 / num.1
                let second = lcm
                return (first,second)
            })
        }

        return l
    }

    func gcd(of x: Int, _ y: Int) -> Int {
        let rem = x % y
        return rem == 0 ? y : gcd(of: y, rem)
    }

    func minLCM(arr:[Int]) -> Int?{
        var res:Int? = nil
        for i in arr{
            if res == nil{
                res = i
            }else{
                res = (res! * i) / gcd(of: res!, i)
            }
        }
        return res
    }

    func minmumNum(son:Int,mom:Int) ->(Int,Int){
        let calSon = son
        let calMom = mom
        guard son != 1 else{
            return (calSon,calMom)
        }
        guard mom != 1 else{
            return (calSon,calMom)
        }
        for x in 2...calSon{
            if calSon % x == 0,calMom % x == 0{
                return minmumNum(son:calSon/x, mom:calMom/x)
            }
        }
        return (calSon,calMom)
    }
}

class leet32{

    // 計算距離(各點為直角)
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
}
