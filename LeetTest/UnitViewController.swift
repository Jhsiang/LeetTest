//
//  UnitViewController.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/7/12.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

class eq{
    var colum = Array<Int>()
    var row = Array<Int>()
    var eq = Array<Int>()
}

class UnitViewController: UIViewController {

    var totalEQArr = Array(repeating: Array(repeating: eq(), count: 9), count: 9)

    override func viewDidLoad() {
        super.viewDidLoad()

        var myArr = getArr()
        //var eqArr = Array(repeating: Array(repeating: eq(), count: 9), count: 9)
        for row in 0...8{
            for colum in 0...8{
                if myArr[row][colum] == 0{
                    var myEQ = eq()
                    myEQ = setAllToEqArr(allEQ: myEQ)
                    totalEQArr[row][colum] = myEQ
                }else{
                    var myEQ = eq()
                    myEQ = setNumToEqArr(oriEQ: myEQ, num: myArr[row][colum])
                    totalEQArr[row][colum] = myEQ
                }
            }
        }

        let showRow = 2
        let showColum = 5
        // 1st
        while  isCompete(oriEQArrArr: totalEQArr) == false {
            for row in 0...8{
                for colum in 0...8{
                    totalEQArr = minumumEQArr(eqArrArr: totalEQArr)
                    if isMinimumEQ(oriEq: totalEQArr[row][colum]) == false
                    {
                        if row == showRow && colum == showColum{
                            let tempTest = totalEQArr[row]
                            DLog(message: "row \(tempTest[showColum].row) colum \(tempTest[showColum].colum) eq \(tempTest[showColum].eq)")
                        }

                        //row
                        do{
                            let subRow = totalEQArr[row]
                            for i in 0...subRow.count-1
                            {
                                if isMinimumEQ(oriEq: subRow[i]) && i != colum
                                {
                                    totalEQArr[row][colum].row = totalEQArr[row][colum].row.filter{$0 != subRow[i].row[0]}
                                }
                            }
                        }

                        if row == showRow && colum == showColum{
                            let tempTest = totalEQArr[row]
                            DLog(message: "row \(tempTest[showColum].row) colum \(tempTest[showColum].colum) eq \(tempTest[showColum].eq)")
                        }
                        if isMinimumEQ(oriEq: totalEQArr[row][colum]){
                            continue
                        }

                        //colum
                        do{
                            var subColum = Array<eq>()
                            for i in 0...8
                            {
                                subColum.append(totalEQArr[i][colum])
                            }
                            for i in 0...subColum.count-1
                            {
                                if isMinimumEQ(oriEq: subColum[i]) && i != row
                                {
                                    totalEQArr[row][colum].colum = totalEQArr[row][colum].colum.filter{$0 != subColum[i].colum[0]}
                                }
                            }
                        }

                        if row == showRow && colum == showColum{
                            let tempTest = totalEQArr[row]
                            DLog(message: "row \(tempTest[showColum].row) colum \(tempTest[showColum].colum) eq \(tempTest[showColum].eq)")
                        }
                        if isMinimumEQ(oriEq: totalEQArr[row][colum]){
                            continue
                        }
/*row colum
                         00 01 02 345 678
                         10 11 12
                         20 21 22
 */
                        //eq
                        do{
                            var subEq = Array<eq>()
                            subEq = getSubEqArr(oriArr: totalEQArr, row: row, colum: colum)
                            for i in 0...subEq.count-1
                            {
                                let removeRow = row % 3
                                let removeColum = colum % 3
                                let removeNum = removeRow * 3 + removeColum
                                if isMinimumEQ(oriEq: subEq[i]) && i != removeNum
                                {
                                    totalEQArr[row][colum].eq = totalEQArr[row][colum].eq.filter{$0 != subEq[i].eq[0]}
                                }
                            }
                        }
                        if row == showRow && colum == showColum{
                            let tempTest = totalEQArr[row]
                            DLog(message: "row \(tempTest[showColum].row) colum \(tempTest[showColum].colum) eq \(tempTest[showColum].eq)")
                        }
                        if isMinimumEQ(oriEq: totalEQArr[row][colum]){
                            continue
                        }
                    }
                }
            }

            totalEQArr = minumumEQArr(eqArrArr: totalEQArr)
        }
        showEQArrToNum(oriEQArrArr: totalEQArr)
        DLog(message: isCompete(oriEQArrArr: totalEQArr))
    }

    func getSubEqArr(oriArr:Array<Array<eq>>,row:Int,colum:Int) -> Array<eq>{

        var resultArr = Array<eq>()

        let step = 3
        var rowFrom = 0
        var rowEnd = 2
        var columFrom = 0
        var columEnd = 2

        var rowRange = rowFrom...rowEnd
        var columRange = columFrom...columEnd

        // row range 0~2,3~5,6~8
        while (rowRange.filter{$0 == row}) == [] && (rowEnd < 9){
            rowFrom += step
            rowEnd += step
            rowRange = rowFrom...rowEnd
        }

        // colum range 0~2,3~5,6~8
        while (columRange.filter{$0 == colum}) == [] && (columEnd < 9){
            columFrom += step
            columEnd += step
            columRange = columFrom...columEnd
        }

        if rowEnd >= 9 || columEnd >= 9{
            DLog(message: "sub EQ overflow")
        }

        for i in rowRange{
            for j in columRange{
                resultArr.append(oriArr[i][j])
            }
        }

        return resultArr
    }

    func isCompete(oriEQArrArr:Array<Array<eq>>) -> Bool {
        for row in 0...8{
            for colum in 0...8{
                if oriEQArrArr[row][colum].colum.count != 1, oriEQArrArr[row][colum].row.count != 1, oriEQArrArr[row][colum].eq.count != 1{
                    return false
                }
            }
        }
        return true
    }

    func isMinimumEQ(oriEq:eq) -> Bool{
        if oriEq.colum.count != 1, oriEq.row.count != 1, oriEq.eq.count != 1{
            return false
        }
        return true
    }

    func minimumEQ(oriEq:eq) -> eq{
        let resultEq = oriEq
        let rowArr = resultEq.row
        let columArr = resultEq.colum
        let eqArr = resultEq.eq
        let minmumArr = intersectionOfThreeArray(arr1: rowArr, arr2: columArr, arr3: eqArr)
        resultEq.colum = minmumArr
        resultEq.row = minmumArr
        resultEq.eq = minmumArr
        return resultEq
    }

    func minumumEQArr(eqArrArr:Array<Array<eq>>) -> Array<Array<eq>>{
        var resultArr = eqArrArr
        for row in 0...8{
            for colum in 0...8{
                let rowArr = resultArr[row][colum].row
                let columArr = resultArr[row][colum].colum
                let eqArr = resultArr[row][colum].eq
                if rowArr.count == 0 || columArr.count == 0 || eqArr.count == 0{
                    DLog(message: "interrupt row = \(row) colum = \(colum)")
                    DLog(message: "rowArr = \(rowArr) columArr = \(columArr) eqArr = \(eqArr)")
                }
                let minmumArr = intersectionOfThreeArray(arr1: rowArr, arr2: columArr, arr3: eqArr)
                resultArr[row][colum].colum = minmumArr
                resultArr[row][colum].row = minmumArr
                resultArr[row][colum].eq = minmumArr
            }
        }
        return resultArr
    }

    func showEQArrToNum(oriEQArrArr:Array<Array<eq>>){
        var myShowArr = Array(repeating: Array(repeating: 10, count: 9), count: 9)
        for row in 0...8{
            for colum in 0...8{
                if oriEQArrArr[row][colum].colum.count == 1{
                    myShowArr[row][colum] = oriEQArrArr[row][colum].colum[0]
                }else if oriEQArrArr[row][colum].row.count == 1{
                    myShowArr[row][colum] = oriEQArrArr[row][colum].row[0]
                }else if oriEQArrArr[row][colum].eq.count == 1{
                    myShowArr[row][colum] = oriEQArrArr[row][colum].eq[0]
                }else{
                    myShowArr[row][colum] = 0
                }
            }
        }
        for i in 0...8{
            DLog(message: myShowArr[i])
        }
    }


    func setNumToEqArr(oriEQ:eq,num:Int) -> eq{
        oriEQ.colum = [num]
        oriEQ.row = [num]
        oriEQ.eq = [num]
        return oriEQ
    }

    func setAllToEqArr(allEQ:eq) -> eq{
        allEQ.colum = [1,2,3,4,5,6,7,8,9]
        allEQ.row = [1,2,3,4,5,6,7,8,9]
        allEQ.eq = [1,2,3,4,5,6,7,8,9]
        return allEQ
    }


    func intersectionOfThreeArray(arr1:Array<Int>,arr2:Array<Int>,arr3:Array<Int>) -> Array<Int>{
        var sumArr = Array<Int>()
        if arr1.count == 0 || arr2.count == 0 || arr3.count == 0{
            DLog(message: "interrupt")
            DLog(message: showEQArrToNum(oriEQArrArr: totalEQArr))
        }
        for x in 0...arr1.count-1{
            for y in 0...arr2.count-1{
                for z in 0...arr3.count-1{
                    if arr1[x] == arr2[y], arr1[x] == arr3[z], (sumArr.index{$0 == arr1[x]} == nil){
                        sumArr.append(arr1[x])
                    }
                }
            }
        }
        return sumArr
    }



















    func getArr() -> Array<Array<Int>> {
        let arr = [[5,3,0,0,7,0,0,0,0],
                   [6,0,0,1,9,5,0,0,0],
                   [0,9,8,0,0,0,0,6,0],
                   [8,0,0,0,6,0,0,0,3],
                   [4,0,0,8,0,3,0,0,1],
                   [7,0,0,0,2,0,0,0,6],
                   [0,6,0,0,0,0,2,8,0],
                   [0,0,0,4,1,9,0,0,5],
                   [0,0,0,0,8,0,0,7,9]]

       let arr2 = [[5,3,5,5,5,5,5,5,5],
                   [5,3,5,5,5,5,5,5,5],
                   [5,3,5,5,5,5,5,5,5],
                   [5,3,5,5,5,5,5,5,5],
                   [5,3,5,5,5,5,5,5,5],
                   [5,3,5,5,5,5,5,5,5],
                   [5,3,5,5,5,5,5,5,5],
                   [5,3,5,5,5,5,5,5,5],
                   [5,3,5,5,5,5,5,5,5]]
        return arr
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




/*
     -UnitViewController.swift showEQArrToNum(oriEQArrArr:)-[189]: [5, 3, 0, 0, 7, 0, 0, 0, 0]
     -UnitViewController.swift showEQArrToNum(oriEQArrArr:)-[189]: [6, 0, 0, 1, 9, 5, 0, 0, 0]
     -UnitViewController.swift showEQArrToNum(oriEQArrArr:)-[189]: [0, 9, 8, 0, 0, 0, 0, 6, 0]
     -UnitViewController.swift showEQArrToNum(oriEQArrArr:)-[189]: [8, 0, 0, 0, 6, 0, 0, 0, 3]
     -UnitViewController.swift showEQArrToNum(oriEQArrArr:)-[189]: [4, 0, 0, 8, 5, 3, 0, 0, 1]
     -UnitViewController.swift showEQArrToNum(oriEQArrArr:)-[189]: [7, 0, 0, 0, 2, 0, 0, 0, 6]
     -UnitViewController.swift showEQArrToNum(oriEQArrArr:)-[189]: [0, 6, 0, 0, 0, 7, 2, 8, 4]
     -UnitViewController.swift showEQArrToNum(oriEQArrArr:)-[189]: [3, 0, 0, 4, 1, 9, 6, 3, 5]
     -UnitViewController.swift showEQArrToNum(oriEQArrArr:)-[189]: [0, 0, 0, 0, 8, 0, 0, 7, 9]
     530070000
     600195000
     098000060
     800060003
     400803001
     700020006
     060000280
     000419005
     000080079

 */
}

