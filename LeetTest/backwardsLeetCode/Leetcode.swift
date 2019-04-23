//
//  Leetcode.swift
//  LeetTest
//
//  Created by Jim Chuang on 2019/2/19.
//  Copyright © 2019 jj. All rights reserved.
//

import Foundation

class leet1{

    func twoSum(_ arr:[Int],_ num:Int) -> [Int]{
        for (index1,value1) in arr.enumerated(){
            for (index2,value2) in arr.enumerated(){
                if index1 != index2 && value1 + value2 == num{
                    return [index1,index2]
                }
            }
        }
        return [-1,-1]
    }
}

class leet8{

    //String to Integer (atoi)   字符串转换整数
    func convert(_ s:String) -> Int32?{
        var arr = Array(s).map{String($0)}
        var res:Int32? = nil
        for ele in arr{
            if let num = Int32(ele){
                if let resValue = res{
                    if (resValue) > Int32.max/10 {
                        return nil
                    }else if (resValue) == Int32.max/10 && num > 7{
                        return nil
                    }else{
                        res = resValue * 10 + num
                    }
                }else{
                    res = num
                }
            }else{
                return res
            }
        }
        return res
    }
}


