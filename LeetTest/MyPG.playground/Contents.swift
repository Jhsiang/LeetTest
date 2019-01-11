import UIKit

var priStr = "Hello, playground"
print(priStr)
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
var ori =  [24, 18, 92, 88, 99]

print(sumOfDivided(ori))
print("var res =  [(2, 222), (3, 141), (11, 187), (23, 92)]")

isPrime(num: 11)
