//
//  Good.swift
//  LeetTest
//
//  Created by Jim Chuang on 2019/1/16.
//  Copyright © 2019 jj. All rights reserved.
//

import Foundation

class good1{

    // 兩個大數相乘 ex: multiply("2","90") = "180"
    func multiply(left: String, right: String) -> String {
        var leftCharacterArray = left.characters.reversed().map { Int(String($0))! }
        var rightCharacterArray = right.characters.reversed().map { Int(String($0))! }
        var result = [Int](repeating: 0, count: leftCharacterArray.count+rightCharacterArray.count)

        for leftIndex in 0..<leftCharacterArray.count {
            for rightIndex in 0..<rightCharacterArray.count {

                let resultIndex = leftIndex + rightIndex

                result[resultIndex] = leftCharacterArray[leftIndex] * rightCharacterArray[rightIndex] + (resultIndex >= result.count ? 0 : result[resultIndex])
                if result[resultIndex] > 9 {
                    result[resultIndex + 1] = (result[resultIndex] / 10) + (resultIndex+1 >= result.count ? 0 : result[resultIndex + 1])
                    result[resultIndex] -= (result[resultIndex] / 10) * 10
                }

            }

        }

        result = Array(result.reversed())
        return result.map { String($0) }.joined(separator: "")
    }
}
