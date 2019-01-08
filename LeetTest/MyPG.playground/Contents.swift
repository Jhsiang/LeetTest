import UIKit

var priStr = "Hello, playground"
print(priStr)

func add(_ n: Int) -> ((Int) -> Int) {
    func addOne(num:Int) -> Int{
        return num + n
    }
    return addOne
}

