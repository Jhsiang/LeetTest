//
//  ViewController.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/5/2.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIPageViewControllerDelegate
//,UIPageViewControllerDataSource
{

    @IBOutlet var containerView: UIView!

    @IBOutlet var testV: UIView!
    @IBOutlet var testTF: UITextField!
    @IBOutlet var myPageCtrl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         if let range = str.range(of: "456"){
         let startIndex = range.upperBound
         let endIndex = range.lowerBound
         print(str.suffix(from: startIndex)) //789
         print(str.prefix(upTo: startIndex)) //123456
         print(str.suffix(from: endIndex)) //456789
         print(str.prefix(upTo: endIndex)) //123
         print(str.prefix(5)) //12345
         print(str.suffix(5)) //56789
         }
         */

        /*
         let az = (0x41...0x5A).map({Character(UnicodeScalar($0))})
         let num = (0x30...0x39).map({Character(UnicodeScalar($0))})
         var myArr = num + az
         print(myArr)
         */

        let str2 = ""
        var myLabel = UILabel.init(frame: self.view.frame)
        myLabel.text = str2
        myLabel.numberOfLines = 0
        self.view.addSubview(myLabel)
        print(str2)



        print("\(strReverse(str: "nosaj"))")
        print("\(strAnagram(str1: "jason", str2: "sonaj"))")
        print("add Digits =\(addDigits(inputNum: 345))")
        print("move Zeroes =\(moveZeroes(inputArray:[1,0,3,0,5]))")
        print("move Zeroes2 =\(moveZeroes2(inputArray:[1,0,3,0,5]))")
        print("intersection =\(intersectionOfTwoArray(arrayOne: [1,1,2,2,2,9,8], arrayTwo: [1,3,3,5,8]))")
        print("Contains Duplicate = \(containsDuplicate(inputArray: [1,1,2,2,2,9,8]))")
        print("power of two = \(powerOfTwo(num: 16384))")
        print("power of Three = \(powerOfThree(num: 243))")
        print("major num = \(majorityNum(inputArr: [1,2,2,2,2,2,3,4,5,6,7,8,2,2,2,2,2,2,2,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8]))")
        print("major str = \(majorityStr(inputArr: ["c","E","E","E","E","ff","xx","E","E","E","E","E","E","E","E","E","E","E","E","E","E"]))")

        // sorting test
        var myArr = Array<Int>()
        for x in 1...100{
            myArr.append(101-x)
        }
        let sortArr = quickSortingParkingArray(inputArr: myArr)

        // autolayout button
        let addButton = UIButton()
        addButton.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        addButton.setImage(Graphics.getAddImageNormal(), for: UIControlState.normal)
        addButton.setImage(Graphics.getAddImageSelect(), for: UIControlState.highlighted)
        self.view.addSubview(addButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)

        // find factor
        print("factor = \(factor(num1: 736, num2: 414))")
        print("factor2 = \(factor(num1: 684, num2: 48))")
        let x:Double = 91
        print(" is prime = \(isPrime(n: x))")

        // dic map filter
        let myDic:Dictionary<String, String> = ["aa":"bb","cc":"dd"]
        let myDic2 = myDic.filter{name,value in name != "aa"}
        let myDic3 = myDic.map{name,value in name + "ee"}
        DLog(message: myDic2)
        DLog(message: myDic3)

    }

    override func viewWillAppear(_ animated: Bool) {
        // 註冊鍵盤出現/消失事件
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // 取消註冊鍵盤出現/消失事件≥
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIKeyboardWillShow, object:nil)
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIKeyboardWillHide, object:nil)
    }

    @objc func keyboardWillShow(note: NSNotification) {
        let userInfo = note.userInfo!
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let kybHeight = keyBoardBounds.size.height
        let deltaY = self.testV.frame.origin.y + self.testV.frame.size.height + kybHeight - self.view.frame.size.height
        if deltaY > 0{
            self.view.transform = CGAffineTransform(translationX: 0, y: -deltaY)
        }
    }

    @objc func keyboardWillHidden(note: NSNotification) {
        self.view.transform = CGAffineTransform.identity
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        testTF.resignFirstResponder()
        return true
    }

    func isPrime(n:Double) -> Bool{
        if n <= 1 {return false}
        if n <= 3 {return true}
        var i:Double = 2
        while i * i <= n{
            if n.remainder(dividingBy: i) == 0
            {
                let a = (n / i).rounded(.toNearestOrEven)
                print("i = \(i) a= \(a)")
                return false
            }
            i += 1
        }
        return true
    }

    func factor(num1:Int, num2:Int) -> Int{
        guard num1 > 0 else {return num2}
        guard num2 > 0 else {return num1}
        return num1 > num2 ? factor(num1:num1 - num2 , num2:num2) : factor(num1:num1 ,num2:num2-num1)
    }

    func greet(str:String){
        print("say hello + \(str)")
    }

    func strAnagram(str1:String,str2:String) -> Bool{

        if str1.count != str2.count{
            return false
        }else{
            var str1Array = Array(str1)
            var str2Array = Array(str2)
            str1Array.sort()
            str2Array.sort()
            for x in 0...str1Array.count-1{
                if str1Array[x] != str2Array[x]{
                    return false
                }
            }
        }
        return true
    }

    func strReverse(str:String) -> String{
        var resultStr = ""
        var resultArray = Array<String>()
        let strArray = Array(str)
        for x in strArray{
            resultArray.insert(String(x), at: 0)
        }
        for x in resultArray{
            resultStr += x
        }
        return resultStr
    }

    func cowNum(originalYear:Int) -> Int{
        if originalYear < 0 {
            return 0
        }else if originalYear <= 1 {
            return 1
        }else if originalYear % 2 == 0 && originalYear != 0{
            return cowNum(originalYear:originalYear-1)*2
        }else if originalYear % 2 != 0{
            return cowNum(originalYear: originalYear-1) + cowNum(originalYear: originalYear-6) - cowNum(originalYear: originalYear-5)
        }else {
            return 0
        }
    }

    func addDigits(inputNum:Int) -> Int{
        guard inputNum >= 10 else{return inputNum}
        var result = 0
        let pw = Int(log10(Double(inputNum)))
        for x in 0...pw{
            let sum = Int(Double(inputNum) / pow(10.0, Double(x))) % 10
            result += Int(sum)
        }
        result = addDigits(inputNum: result)
        return result
    }

    func moveZeroes(inputArray:Array<Int>) -> Array<Int>{
        var index = 0
        var result = inputArray
        for x in 0...result.count-1{
            if result[x] != 0 {
                result[index] = result[x]
                index += 1
            }
        }
        while index < result.count {
            result[index] = 0
            index += 1
        }
        return result
    }

    func moveZeroes2(inputArray:Array<Int>) -> Array<Int>{

        var result = Array<Int>()
        for x in 0...inputArray.count-1{
            if inputArray[x] != 0{
                result.append(inputArray[x])
            }
        }
        while result.count < inputArray.count {
            result.append(0)
        }

        return result
    }

    func intersectionOfTwoArray(arrayOne:Array<Int>,arrayTwo:Array<Int>) -> Array<Int>{

        var sum = Array<Int>()
        sum.sort()
        for x in 0...arrayOne.count-1{
            for y in 0...arrayTwo.count-1{
                if arrayOne[x] == arrayTwo[y] && (sum.index{$0 == arrayOne[x]} == nil){
                    sum.append(arrayOne[x])
                }
            }
        }
        return sum
    }

    func majorityElement<T>(inputArr:[T]) -> T {
        let resultT = T.self
        //var resultDic = [:2]

        let length = inputArr.count
        if length < 2 {return inputArr[0]}
        for x in inputArr{
            let myDic = ["String":x]
            //var myDic2 = [x:"test"]
            let mytest = x
            var mmya = Array<T>()
            mmya.append(x)
        }

        return resultT as! T
    }

    func majorityNum(inputArr:Array<Int>) -> Int{
        var resultNum = 0
        let length = inputArr.count-1
        var resultDic = Dictionary<Int,Int>()
        if length < 2 {return inputArr[0]}
        for x in 0...length-1{
            if resultDic[inputArr[x]] == nil{
                resultDic[inputArr[x]] = 1
            }else if resultDic[inputArr[x]] != 0{
                resultDic[inputArr[x]] = resultDic[inputArr[x]]! + 1
            }
        }
        for x in resultDic{
            if x.value > length/2 {
                resultNum = x.key
            }
        }
        return resultNum
    }

    func majorityStr(inputArr:Array<String>) -> String{
        var resultStr = ""
        let length = inputArr.count-1
        var resultDic = Dictionary<String,Int>()
        if length < 2 {return inputArr[0]}
        for x in 0...length-1{
            if resultDic[inputArr[x]] == nil{
                resultDic[inputArr[x]] = 1
            }else if resultDic[inputArr[x]] != 0{
                resultDic[inputArr[x]] = resultDic[inputArr[x]]! + 1
            }
        }
        for x in resultDic{
            if x.value > length/2 {
                resultStr = x.key
            }
        }
        return resultStr
    }

    func containsDuplicate(inputArray:Array<Int>) -> Array<Int>{
        var resultSet = Set<Int>()
        for x in 0...inputArray.count-1{
            resultSet.insert(inputArray[x])
        }
        var resultArray = Array<Int>()
        for x in resultSet.sorted(){
            resultArray.append(x)
        }

        return resultArray
    }

    func powerOfTwo(num:Int) -> Bool{
        guard num > 1 else{return true}
        if num % 2 == 0{
            return powerOfTwo(num:num/2)
        }else{
            return false
        }
    }

    func powerOfThree(num:Int) -> Bool{
        guard num > 1 else{return true}
        if num % 3 == 0{
            return powerOfThree(num:num/3)
        }else{
            return false
        }
    }

    func quickSortingParkingArray(inputArr:Array<Int>) -> Array<Int>{
        guard inputArr.count > 1 else { return inputArr }
        let pivotSelect = inputArr.count/2
        let pivot = inputArr[pivotSelect]
        let pivotArray = [pivot]
        var less = Array<Int>()
        var greater = Array<Int>()
        for i in 0...inputArr.count - 1{
            if i != pivotSelect && inputArr[i] <= pivot{
                less.append(inputArr[i])
            }
            if i != pivotSelect && inputArr[i] > pivot{
                greater.append(inputArr[i])
            }
        }
        return quickSortingParkingArray(inputArr: less) + pivotArray + quickSortingParkingArray(inputArr: greater)
    }

//MARK: - UIPageControlDataSource
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        <#code#>
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        <#code#>
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

