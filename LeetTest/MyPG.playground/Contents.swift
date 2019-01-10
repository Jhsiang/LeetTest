import UIKit

var priStr = "Hello, playground"
print(priStr)
func thirt(_ n: Int) -> Int {
    var arr = [1, 10, 9, 12, 3, 4]
    let intArr = String(n).characters.flatMap{Int(String($0))}.reversed()
    var sum = 0
    for (i,v) in intArr.enumerated(){
        sum += v * arr[i % 6]
    }
    return sum == n ? sum : thirt(sum)
}

thirt(321)
thirt(85299258)
