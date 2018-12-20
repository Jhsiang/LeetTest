//
//  Defintion.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/6/12.
//  Copyright © 2018年 jj. All rights reserved.
//

import Foundation

func DLog<T> (message: T, fileName: String = #file, funcName: String = #function, lineNum: Int = #line) {

    #if DEBUG

    let file = (fileName as NSString).lastPathComponent

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
    let sendDate = Date()
    let timeStr = dateFormatter.string(from: sendDate)

    print("\(timeStr) \(file) \(funcName)-[\(lineNum)]: \(message)")

    #endif

}


//WTF
func ~=<T>(pattern: (T) -> Bool, value: T) -> Bool {
    return pattern(value)
}
