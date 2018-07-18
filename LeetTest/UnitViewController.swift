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

class UnitViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var totalEQArr = Array(repeating: Array(repeating: eq(), count: 9), count: 9)
    var showArr = Array<Array<Int>>()

    @IBOutlet var myCollectionView: UICollectionView!
    @IBOutlet var inputTFView: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
/*
         [0,8,6,3,0,7,4,9,1]
         [7,0,1,9,4,0,3,6,8]
         [9,4,3,6,8,1,7,2,5]
         [1,0,4,7,0,6,8,3,0]
         [8,7,0,1,3,4,0,5,6]
         [3,6,0,0,0,8,1,7,4]
         [0,3,0,8,1,9,6,4,7]
         [4,1,7,0,6,3,0,8,0]
         [6,9,8,4,7,0,0,1,3]
 */
        var myArr = getArr()
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
        var count = 0
        var notZeroCount = 0
        var recordNotZeroCount = 0
        var breakCount = 0
        // 1st
        while isCompete(oriEQArrArr: totalEQArr) == false {

            // Break Function
            count += 1
            DLog(message: count)
            let myTestArr = showEQArrToNum(oriEQArrArr: totalEQArr)
            for x in 0...8{
                for y in 0...8{
                    notZeroCount += myTestArr[x][y] == 0 ? 0 : 1
                }
            }
            DLog(message: notZeroCount)
            if notZeroCount == recordNotZeroCount{
                for i in 0...8{
                    let mySR = i / 3 + 3
                    let mySC = i % 3 + 6
                    DLog(message: "\(mySR)\(mySC) row = \(totalEQArr[mySR][mySC].row) colum = \(totalEQArr[mySR][mySC].colum) eq = \(totalEQArr[mySR][mySC].eq)")
                }
                breakCount += 1
                if breakCount >= 2{
                    break
                }
            }
            recordNotZeroCount = notZeroCount
            notZeroCount = 0

            //check
            for i in 0...8{
                let mySR = i / 3 + 0
                let mySC = i % 3 + 6
                DLog(message: "\(mySR)\(mySC) row = \(totalEQArr[mySR][mySC].row) colum = \(totalEQArr[mySR][mySC].colum) eq = \(totalEQArr[mySR][mySC].eq)")
            }

            // Main handle
            for row in 0...8{
                for colum in 0...8{

                    totalEQArr = minumumEQArr(eqArrArr: totalEQArr)

                    if isMinimumEQ(oriEq: totalEQArr[row][colum]) {
                        continue
                    }

                    //row
                    do{
                        let subRow = totalEQArr[row]
                        for i in 0...subRow.count-1{
                            let notSelf = i != colum
                            if isMinimumEQ(oriEq: subRow[i]) && notSelf{
                                totalEQArr[row][colum].row = totalEQArr[row][colum].row.filter{$0 != subRow[i].row[0]}
                            }
                        }
                    }
                    if isMinimumEQ(oriEq: totalEQArr[row][colum]){
                        continue
                    }

                    //colum
                    do{
                        var subColum = Array<eq>()
                        for i in 0...8{
                            subColum.append(totalEQArr[i][colum])
                        }
                        for i in 0...subColum.count-1{
                            let notSelf = i != row
                            if isMinimumEQ(oriEq: subColum[i]) && notSelf{
                                totalEQArr[row][colum].colum = totalEQArr[row][colum].colum.filter{$0 != subColum[i].colum[0]}
                            }
                        }
                    }
                    if isMinimumEQ(oriEq: totalEQArr[row][colum]){
                        continue
                    }

                    //eq
                    do{
                        var subEq = Array<eq>()
                        subEq = getSubEqArr(oriArr: totalEQArr, row: row, colum: colum)

                        for i in 0...subEq.count-1{
                            /*row colum
                             00 01 02
                             10 11 12
                             20 21 22
                             */
                            let removeRow = row % 3
                            let removeColum = colum % 3
                            let removeNum = removeRow * 3 + removeColum
                            let notSelf = i != removeNum
                            if isMinimumEQ(oriEq: subEq[i]) && notSelf{
                                totalEQArr[row][colum].eq = totalEQArr[row][colum].eq.filter{$0 != subEq[i].eq[0]}
                            }
                        }
                    }
                    if isMinimumEQ(oriEq: totalEQArr[row][colum]){
                        continue
                    }

                    // Remain unit number of self big EQ
                    do{
                        var subEq = Array<eq>()
                        var targetEqOfEq = totalEQArr[row][colum].eq
                        subEq = getSubEqArr(oriArr: totalEQArr, row: row, colum: colum)

                        for i in 0...subEq.count-1{
                            let removeRow = row % 3
                            let removeColum = colum % 3
                            let removeNum = removeRow * 3 + removeColum
                            let notSelf = i != removeNum
                            if isMinimumEQ(oriEq: subEq[i]) == false && notSelf{
                                for j in 0...subEq[i].eq.count - 1{
                                    targetEqOfEq = targetEqOfEq.filter{$0 != subEq[i].eq[j]}
                                }
                            }
                        }
                        if targetEqOfEq.count == 1{
                            totalEQArr[row][colum].eq = targetEqOfEq
                        }
                    }
                    if isMinimumEQ(oriEq: totalEQArr[row][colum]){
                        continue
                    }

                    // Remain unit number of self big Row
                    do{
                        let subRow = totalEQArr[row]
                        var targetEqOfRow = totalEQArr[row][colum].row
                        for i in 0...subRow.count-1{
                            let notSelf = i != colum
                            if isMinimumEQ(oriEq: subRow[i]) == false && notSelf{
                                for j in 0...subRow[i].row.count-1{
                                    targetEqOfRow = targetEqOfRow.filter{$0 != subRow[i].row[j]}
                                }
                            }
                        }
                        if targetEqOfRow.count == 1{
                            totalEQArr[row][colum].row = targetEqOfRow
                        }
                    }
                    if isMinimumEQ(oriEq: totalEQArr[row][colum]){
                        continue
                    }

                    // Remain unit number of self big Colum
                    do{
                        var subColum = Array<eq>()
                        var targetEqOfColum = totalEQArr[row][colum].colum
                        for i in 0...8{
                            subColum.append(totalEQArr[i][colum])
                        }
                        for i in 0...subColum.count-1{
                            let notSelf = i != row
                            if isMinimumEQ(oriEq: subColum[i]) == false && notSelf{
                                for j in 0...subColum[i].colum.count - 1{
                                    targetEqOfColum = targetEqOfColum.filter{$0 != subColum[i].colum[j]}
                                }
                            }
                        }
                        if targetEqOfColum.count == 1{
                            totalEQArr[row][colum].colum = targetEqOfColum
                        }
                    }
                    if isMinimumEQ(oriEq: totalEQArr[row][colum]){
                        continue
                    }

                    do{
                        var subEq = Array<eq>()
                        var targetEqOfEq = totalEQArr[row][colum].eq
                        subEq = getSubEqArr(oriArr: totalEQArr, row: row, colum: colum)

                        for i in 0...subEq.count-1{
                            let removeRow = row % 3
                            let removeColum = colum % 3
                            let removeNum = removeRow * 3 + removeColum
                            let notSelf = i != removeNum
                            if isMinimumEQ(oriEq: subEq[i]) == false && notSelf{
                                for j in 0...subEq[i].eq.count - 1{
                                    targetEqOfEq = targetEqOfEq.filter{$0 != subEq[i].eq[j]}
                                }
                            }
                        }
                        if targetEqOfEq.count == 1{
                            totalEQArr[row][colum].eq = targetEqOfEq
                        }
                    }
                    /*


                    //test
                    do{
                        var space = 0
                        let subRow = totalEQArr[row]
                        for colum in 0...2{
                            if isMinimumEQ(oriEq: subRow[colum]) == false{
                                space += 1
                            }
                        }
                        if subRow[colum].row.count == space{
                            //clean 3...5 6...8 subRow[colum].row.filter {$0 != subRow[0..2].row[0...2]}
                        }
                        for colum in 0...subRow.count - 1{
                            //check if anypoint is unit then totalEQArr[row][col].row.remove{$0 != unit}
                        }
                    }
 */
                }
            }
            totalEQArr = minumumEQArr(eqArrArr: totalEQArr)
            sameOfSpaceAndEqCount()
            removeRowAndColumByEq()

        }
        showArr = showEQArrToNum(oriEQArrArr: totalEQArr)
        DLog(message: isCompete(oriEQArrArr: totalEQArr))
    }

    //MARK: - Button Click
    @IBAction func enterClick(_ sender: UIButton) {
        myCollectionView.reloadData()
    }

    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unitcell", for: indexPath) as! UnitCollectionViewCell
        let showRow = indexPath.item / 9
        let showColum = indexPath.item % 9
        if showArr.count == 9{
            let str = String(showArr[showRow][showColum])
            cell.cellLabel.text = str
        }
        cell.layer.borderWidth = 1

        return cell
    }

    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: myCollectionView.frame.size.width/9, height: myCollectionView.frame.size.height/9)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    //MARK: - Define Function
    func removeRowAndColumByEq(){
        /*
         33 row = [3, 5, 6] colum = [3, 5, 6] eq = [3, 5, 6]
         43 row = [3, 4] colum = [3, 4] eq = [3, 4]
         53 row = [3, 4, 5, 6] colum = [3, 4, 5, 6] eq = [3, 4, 5, 6]
         54 row = [3, 4, 5, 6, 7] colum = [3, 4, 5, 6, 7] eq = [3, 4, 5, 6, 7]
         55 row = [3, 4, 5, 6, 7] colum = [3, 4, 5, 6, 7] eq = [3, 4, 5, 6, 7]
         */
        for nextBigEq in 0...8{
            let nextRow = nextBigEq / 3 //0~2
            let nextColum = nextBigEq % 3 //0~2
            var subEq = Array<Array<Int>>()
            var totalNumArr = Array<Int>()

            for everyBigEq in 0...8{
                let row = everyBigEq / 3 + nextRow * 3
                let colum = everyBigEq % 3 + nextColum * 3
                if isMinimumEQ(oriEq: totalEQArr[row][colum]) == false{
                    subEq.append(totalEQArr[row][colum].eq)
                }
            }

            if subEq.count >= 1{
                for i in 0...subEq.count - 1{
                    for j in 0...subEq[i].count - 1{
                        if (totalNumArr.filter{$0 == subEq[i][j]} == []){
                            totalNumArr.append(subEq[i][j])
                        }
                    }
                }
            }

            if totalNumArr.count >= 1{
                for i in 0...totalNumArr.count - 1{
                    var rowArr = Array<Int>()
                    var columArr = Array<Int>()
                    for everyBigEq in 0...8{
                        let row = everyBigEq / 3 + nextRow * 3
                        let colum = everyBigEq % 3 + nextColum * 3
                        if isMinimumEQ(oriEq: totalEQArr[row][colum]) == false{
                            if (totalEQArr[row][colum].row.filter{$0 == totalNumArr[i]} != []){
                                rowArr.append(row)
                                columArr.append(colum)
                            }
                        }
                    }
                    if rowArr.count > 0, columArr.count > 0{
                        if (rowArr.filter{$0 != rowArr[0]} == []){
                            subRemoveRowByEq(deletRow: rowArr[0], deletNum: totalNumArr[i], nowColum: columArr[0])
                        }
                        if (columArr.filter{$0 != columArr[0]} == []){
                            subRemoveColumByEq(deletColum: columArr[0], deletNum: totalNumArr[i], nowRow: rowArr[0])
                        }
                    }
                }
            }
        }

        for row in 0...8{
            for colum in 0...8{
                do{
                    var subEq = Array<eq>()
                    var targetEqOfEq = totalEQArr[row][colum].eq
                    subEq = getSubEqArr(oriArr: totalEQArr, row: row, colum: colum)

                    for i in 0...subEq.count-1{
                        let removeRow = row % 3
                        let removeColum = colum % 3
                        let removeNum = removeRow * 3 + removeColum
                        let notSelf = i != removeNum
                        if isMinimumEQ(oriEq: subEq[i]) == false && notSelf{
                            for j in 0...subEq[i].eq.count - 1{
                                targetEqOfEq = targetEqOfEq.filter{$0 != subEq[i].eq[j]}
                            }
                        }
                    }
                    if targetEqOfEq.count == 1{
                        totalEQArr[row][colum].eq = targetEqOfEq
                    }
                }
            }
        }

        totalEQArr = minumumEQArr(eqArrArr: totalEQArr)
    }

    func subRemoveRowByEq(deletRow:Int,deletNum:Int,nowColum:Int){
        switch nowColum {
        case 0...2:
            for deletColum in 3...8{
                if isMinimumEQ(oriEq: totalEQArr[deletRow][deletColum]) == false{
                    totalEQArr[deletRow][deletColum].eq = totalEQArr[deletRow][deletColum].eq.filter{$0 != deletNum}
                }
            }
        case 3...5:
            for deletColum in 0...2{
                if isMinimumEQ(oriEq: totalEQArr[deletRow][deletColum]) == false{
                    totalEQArr[deletRow][deletColum].eq = totalEQArr[deletRow][deletColum].eq.filter{$0 != deletNum}
                }
            }
            for deletColum in 6...8{
                if isMinimumEQ(oriEq: totalEQArr[deletRow][deletColum]) == false{
                    totalEQArr[deletRow][deletColum].eq = totalEQArr[deletRow][deletColum].eq.filter{$0 != deletNum}
                }
            }
        case 6...8:
            for deletColum in 0...5{
                if isMinimumEQ(oriEq: totalEQArr[deletRow][deletColum]) == false{
                    totalEQArr[deletRow][deletColum].eq = totalEQArr[deletRow][deletColum].eq.filter{$0 != deletNum}
                }
            }
        default:
            break
        }
    }

    func subRemoveColumByEq(deletColum:Int,deletNum:Int,nowRow:Int){
        switch nowRow {
        case 0...2:
            for deletRow in 3...8{
                if isMinimumEQ(oriEq: totalEQArr[deletRow][deletColum]) == false{
                    totalEQArr[deletRow][deletColum].eq = totalEQArr[deletRow][deletColum].eq.filter{$0 != deletNum}
                }
            }
        case 3...5:
            for deletRow in 0...2{
                if isMinimumEQ(oriEq: totalEQArr[deletRow][deletColum]) == false{
                    totalEQArr[deletRow][deletColum].eq = totalEQArr[deletRow][deletColum].eq.filter{$0 != deletNum}
                }
            }
            for deletRow in 6...8{
                if isMinimumEQ(oriEq: totalEQArr[deletRow][deletColum]) == false{
                    totalEQArr[deletRow][deletColum].eq = totalEQArr[deletRow][deletColum].eq.filter{$0 != deletNum}
                }
            }
        case 6...8:
            for deletRow in 0...5{
                if isMinimumEQ(oriEq: totalEQArr[deletRow][deletColum]) == false{
                    totalEQArr[deletRow][deletColum].eq = totalEQArr[deletRow][deletColum].eq.filter{$0 != deletNum}
                }
            }
        default:
            break
        }
    }

    func sameOfSpaceAndEqCount(){

        for nextBigEq in 0...8{
            let nextRow = nextBigEq / 3 //0~2
            let nextColum = nextBigEq % 3 //0~2
            var subEq = Array<Array<Int>>()
            var noRepeatSubEq = Array<Array<Int>>()
            var noRepeatSubEqCount = Array<Int>()
            var finalRemoveArray = Array<Array<Int>>()
            var count = 0

            for everyBigEq in 0...8{
                let row = everyBigEq / 3 + nextRow * 3
                let colum = everyBigEq % 3 + nextColum * 3
                if isMinimumEQ(oriEq: totalEQArr[row][colum]) == false{
                    subEq.append(totalEQArr[row][colum].eq)
                }
            }

            if subEq.count > 1{
                for i in 0...subEq.count - 1{
                    var elemt = subEq.map{$0 == subEq[i]}
                    for j in 0...elemt.count - 1{
                        if elemt[j] == true{
                            count += 1
                        }
                    }
                    if count > 1 && (noRepeatSubEq.filter{$0 == subEq[i]} == []){
                        noRepeatSubEq.append(subEq[i])
                        noRepeatSubEqCount.append(count)
                    }
                    count = 0
                }
            }

            if noRepeatSubEq.count > 0{
                for i in 0...noRepeatSubEq.count - 1{
                    if noRepeatSubEq[i].count == noRepeatSubEqCount[i]{
                        finalRemoveArray.append(noRepeatSubEq[i])
                    }
                }
            }

            if finalRemoveArray.count >= 1{
                for i in 0...finalRemoveArray.count - 1{
                    for everyBigEq in 0...8{
                        let row = everyBigEq / 3 + nextRow * 3
                        let colum = everyBigEq % 3 + nextColum * 3
                        if isMinimumEQ(oriEq: totalEQArr[row][colum]) == false{
                            if totalEQArr[row][colum].eq.count != finalRemoveArray[i].count{
                                for j in 0...finalRemoveArray[i].count - 1{
                                    totalEQArr[row][colum].eq = totalEQArr[row][colum].eq.filter{$0 != finalRemoveArray[i][j]}
                                }
                            }
                        }
                    }
                }
            }
            totalEQArr = minumumEQArr(eqArrArr: totalEQArr)

        }
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

    func showEQArrToNum(oriEQArrArr:Array<Array<eq>>) -> Array<Array<Int>> {
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
        return myShowArr
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
        let arrLevel1 = [[5,3,0,0,7,0,0,0,0],
                         [6,0,0,1,9,5,0,0,0],
                         [0,9,8,0,0,0,0,6,0],
                         [8,0,0,0,6,0,0,0,3],
                         [4,0,0,8,0,3,0,0,1],
                         [7,0,0,0,2,0,0,0,6],
                         [0,6,0,0,0,0,2,8,0],
                         [0,0,0,4,1,9,0,0,5],
                         [0,0,0,0,8,0,0,7,9]]

        let arrLevel1000 = [[8,0,0,0,0,0,0,0,0],
                            [0,0,3,6,0,0,0,0,0],
                            [0,7,0,0,9,0,2,0,0],
                            [0,5,0,0,0,7,0,0,0],
                            [0,0,0,0,4,5,7,0,0],
                            [0,0,0,1,0,0,0,3,0],
                            [0,0,1,0,0,0,0,6,8],
                            [0,0,8,5,0,0,0,1,0],
                            [0,9,0,0,0,0,4,0,0]]

        let arrLevel100 = [[5,0,0,3,0,0,0,0,1],
                           [0,2,0,0,4,0,3,6,0],
                           [0,0,3,0,8,0,7,0,0],
                           [0,5,0,0,0,0,8,0,0],
                           [8,0,0,1,3,4,0,0,6],
                           [0,0,9,0,0,0,0,7,0],
                           [0,0,5,0,1,0,6,0,0],
                           [0,1,7,0,6,0,0,8,0],
                           [6,0,0,0,0,2,0,0,3]]

        let arrLevel10 = [[1,0,0,0,0,8,0,0,2],
                          [0,0,0,2,0,0,0,5,3],
                          [4,3,0,0,5,0,0,0,9],
                          [0,0,0,9,0,0,0,7,0],
                          [2,7,0,0,0,0,0,9,6],
                          [0,6,0,0,0,4,0,0,0],
                          [3,0,0,0,8,0,0,1,7],
                          [6,2,0,0,0,1,0,0,0],
                          [5,0,0,6,0,0,0,0,8]]

        let arrLevel20 = [[0,8,0,0,0,7,0,0,1],
                          [0,0,0,9,0,0,3,0,8],
                          [9,0,0,6,8,0,0,2,0],
                          [0,0,4,7,0,0,0,3,0],
                          [0,0,0,1,0,4,0,0,0],
                          [0,6,0,0,0,8,1,0,0],
                          [0,3,0,0,1,9,0,0,7],
                          [4,0,7,0,0,3,0,0,0],
                          [6,0,0,4,0,0,0,1,0]]

        let arrLevel15 = [[0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,7,0,0,0,0,0],
                          [0,0,0,0,2,1,0,0,4],
                          [0,0,0,0,8,9,0,6,5],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,7,0,0],
                          [0,0,0,0,0,0,0,0,0]]

        let arrLevel16 = [[0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,3,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,3,0,7,5,0,0,0,0],
                          [0,0,0,0,0,0,0,0,2],
                          [7,0,0,0,0,0,0,0,6],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,5,0,0],
                          [0,0,0,0,0,0,0,0,0]]

        let arrLevel17 = [[0,0,0,0,0,0,3,0,5],
                          [0,0,0,0,0,0,4,0,0],
                          [0,1,0,0,2,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,6],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,7],
                          [0,0,0,0,0,0,0,0,8],
                          [0,0,0,0,0,0,0,0,0]]

        let arrLevelXX = [[0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0]]

        return arrLevel20
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

