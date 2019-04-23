import UIKit

var demoStr = "Hello,  playground "
print("str = ",demoStr)

func urlEncoded(_ s:String) -> String {
    let encodeUrlString = s.addingPercentEncoding(withAllowedCharacters:
        .urlQueryAllowed)
    return encodeUrlString ?? ""
}





