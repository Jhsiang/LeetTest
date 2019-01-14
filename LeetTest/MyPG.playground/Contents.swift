import UIKit

var priStr = "Hello, playground"
print(priStr)

func gta(limit: Int, args:[Int]) -> Int {
    var sum = 0
    let taken = limit
    let arr = takeNewNum(ar: args, num: limit)

    guard taken <= arr.count else {
        print("over taken(limit)")
        return 0
    }

    if limit >= 7{
        if limit == 7{
            return (arr.reduce(0, +)) * 11743
        }else if limit == 8{
            return (arr.reduce(0, +)) * 95901
        }else if limit == 9{
            return (arr.reduce(0, +)) * 876809
        }
    }

    //1 1num
    //3 2num
    //11 3num
    //49 4 num
    //261 5num
    //37513 6num
    //11743 7num
    //95901 8num
    //876809 9num

    var resArr = Array<Array<Int>>()
    for ele in arr{
        resArr.append([ele])
        sum += ele
    }


    for x in 1..<taken{
        var index = 0
        var newArr = [[Int]]()
        for (i,v) in resArr.enumerated(){
            for ele in arr{
                if !resArr[i].contains(ele){
                    newArr.append(v + [ele])
                    sum += v.reduce(0, +)
                    sum += ele
                    index += 1
                }
            }
        }
        resArr = newArr
    }


    return sum
}

func takeNewNum(ar:[Int],num:Int) ->[Int]{
    var res = [Int]()

    let strArr = ar.map{String($0)}
    var strArr2D = Array<Array<String>>()
    for str in strArr{
        let ele = str.characters.flatMap{$0}.map{String($0)}
        strArr2D.append(ele)
    }
    var myindex = 0

    while res.count < num{
        let takeIndex = myindex % strArr2D.count
        if strArr2D[takeIndex].count > 0{
            let addNum = Int(strArr2D[takeIndex][0])!
            if !res.contains(addNum){
                res.append(addNum)
            }
            strArr2D[takeIndex].removeFirst()
        }
        myindex += 1
    }

    return res
}



let arr1 = [12348, 47, 3638]
let arr = [12348, 47, 3638]
print(takeNewNum(ar: arr, num: 4))
//1 2 3 4 6 7 9


print(gta(limit: 4, args: arr))

/*
 We have three numbers: 123489, 5, and 67. With these numbers we form the list from their digits in this order [1, 5, 6, 2, 7, 3, 4, 8, 9]. (How can we produce that?) (In this case all the digits are different)

 Furthermore, we want to put a limit to the number of terms of the above list.

 Instead of having nine terms, we want to have only seven. (we take the two last ones)

 So, our list will be reduced to [1, 5, 6, 2, 7, 3, 4] (base list)

 We form all the possible arrays, from the list above, and we calculate, for each array, the addition of their respective digits.

 See the table below: we will put only some of them

 array for the list      sum (terms of arrays)
 [1]                      1 # arrays with only one term (7 different arrays)
 [5]                      5
 [6]                      6
 [2]                      2
 [7]                      7
 [3]                      3
 [4]                      4

 [1, 5]                   6 # arrays with two terms (42 different arrays)
 [1, 6]                   7
 [1, 2]                   3
 [1, 7]                   8
 [1, 3]                   4
 [1, 4]                   5

 .....                   ...
 [1, 5, 6]               12 # arrays with three terms(210 different arrays)
 [1, 5, 2]                8
 [1, 5, 7]               13
 [1, 5, 3]                9
 ........                ...
 [1, 5, 6, 2]            14 # arrays with four terms(840 different arrays)
 [1, 5, 6, 7]            19
 [1, 5, 6, 3]            15
 [1, 5, 6, 4]            16
 ............            ..
 [1, 5, 6, 2, 7]         21 # arrays with five terms(2520 different arrays)
 [1, 5, 6, 2, 3]         17
 [1, 5, 6, 2, 4]         18
 [1, 5, 6, 7, 2]         21
 ...............         ..
 [1, 5, 6, 2, 7, 3]      24 # arrays with six terms(5040 different arrays)
 [1, 5, 6, 2, 7, 4]      25
 [1, 5, 6, 2, 3, 7]      24
 [1, 5, 6, 2, 3, 4]      21
 ..................      ..
 [1, 5, 6, 2, 7, 3, 4]   28 # arrays with seven terms(5040 different arrays)
 [1, 5, 6, 2, 7, 4, 3]   28   # arrays of max length = limit
 [1, 5, 6, 2, 3, 7, 4]   28
 [1, 5, 6, 2, 3, 4, 7]   28
 :::::::::::::::::::::::::::(limit: 7, args: [123489, 5, 67]), 328804)
  XCTAssertEqual(gta(limit: 8, args: [8, 12348, 47, 3639]), 3836040)
 GreatT0talAdditions 328804 (GTA).(The total addition of the sum values corresponding to each permutation). A total 0f 13706 arrays, all of them different.
 So we say that for the three numbers, 123489, 5, and 67 with a limit = 7, the GTA value is 328804.

 Let's see now a case where we have digits occurring more than once. If we have a digit duplicated or more, just continue for the corresponding digit in turn of the next number. The result will be a list with no duplicated digits.

 For the numbers: 12348, 47, 3639 with limit = 8 we will have the list [1, 4, 3, 2, 7, 6, 9, 8] (base list)

 We should not have duplications in the permutations because there are no duplicated digits in our base list.

 For this case we have:

 number of different array      number of terms the array has
 8                                  1
 56                                  2
 336                                  3
 1680                                  4
 6720                                  5
 20160                                  6
 40320                                  7
 40320                                  8
 GTA = 3836040 with a limit of eight terms
 The challenge: create the function gta(), that receives a number that limits the amount of terms for the base list, limit, and an uncertain number of integers that can have and will have different amount of digits that may have digits occuring more than once.

 Just to understand the structure of the function will be like: gta(limit, n1, n2, ...nk)

 Let's see our functions with the examples shown above.

 # case1
 gta(7, 123489, 5, 67) == 328804 # base_list = [1, 5, 6, 2, 7, 3, 4]

 # case2
 gta(8, 12348, 47, 3639) == 3836040 # base_list = [1, 4, 3, 2, 7, 6, 9, 8]
 You may assume that limit will be always lower or equal than the total available digits of all the numbers. The total available digits are all the digits of all the numbers. (E.g.the numbers 12348, 47, 3639have 8 available digits.) You will always be receiving positive integers in an amount between 2 and 6.

 For the tests limit <= 9 (obviously).

 Enjoy it!!

 (Hint: the module itertools for python may be very useful, but there are many ways to solve it.)

 (The arrays [1, 5, 6] and [1, 6, 5] have the same elements but are different arrays. The order matters)
 */
