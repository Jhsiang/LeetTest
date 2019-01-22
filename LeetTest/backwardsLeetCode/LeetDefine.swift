//
//  LeetDefine.swift
//  LeetTest
//
//  Created by Jim Chuang on 2019/1/17.
//  Copyright © 2019 jj. All rights reserved.
//

import Foundation

extension Int{
    func getPower(n:Int) -> Int{
        return Int(pow(Double(self), Double(n)))
    }
}
