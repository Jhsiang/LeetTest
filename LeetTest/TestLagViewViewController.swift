//
//  TestLagViewViewController.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/11/19.
//  Copyright © 2018 jj. All rights reserved.
//

import UIKit

extension Array {
    func decompose() -> (Iterator.Element, [Iterator.Element])? {
        guard let x = first else { return nil }
        return (x, Array(self[1..<count]))
    }

    func decompose2(num:Int) -> ([Iterator.Element], [Iterator.Element])? {
        guard num <= count else { return nil }

        return (Array(self[0..<num]), Array(self[num..<count]))
    }
}

class TestLagViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let arr1 = [1,2,3]

        let arr2 = Array(arr1[0..<3])
        print(arr2)
        let arr3 = Array(arr1[3..<3])
        print(arr3)

        /*
        test: do{
            print(per(arr1, takenBy: 2))
        }
 */

    }
/*
    func per2(arr:Array<Int>, takenBy:Int) -> [Array<Int>] {
        var subArr = Array<Int>()

    }
*/
    func per<T>(_ arr:[T], takenBy:Int) -> [[T]]{
        var subArr = [T]()

        guard let (head, tail) = arr.decompose() else {
            return [[]]
        }

        guard let (head2, tail2) = arr.decompose2(num: takenBy) else {
            return[[]]
        }
        
        //let tempArr = Array(arr.prefix(upTo: takenBy))
        if tail.count == takenBy{
            subArr += tail
        }

        return per(tail+subArr, takenBy: takenBy)
    }

    func between<T>(_ x: T, _ ys: [T]) -> [[T]] {
        guard let (head, tail) = ys.decompose() else {
            return [[x]]
        }
        return [[x] + ys] + between(x, tail).map { [head] + $0 }
    }

    func permutations<T>(_ xs: [T]) -> [[T]] {
        guard let (head, tail) = xs.decompose() else{
            return [[]]
        }
        return permutations(tail).flatMap { between(head, $0) }
    }

    // Pnm
    func perStr(arr:Array<Int>,takenBy:Int) -> [Array<Int>]{

        let first = Array(arr.prefix(upTo: takenBy))
        var myFilter = arr
        for i in first{
            myFilter = myFilter.filter{$0 != i}
        }
        print(myFilter)
        return [first]


    }
    /*
    func permutation<T>(source:[T], takenBy: Int) -> [[T]]{

    }
 */
/*
    func per(arr:Array<String>,takenBy:Int) -> [Array<String>]{
        if arr.count == takenBy{
            return [arr]
        }
        let head = arr[0]
        let rest = Array(arr.suffix(from: 1))
        let sub_combos = per(arr: rest, takenBy: takenBy)


    }
*/
    // Cnm
    func combinations<T>(source: [T], takenBy : Int) -> [[T]] {
        if(source.count == takenBy) {
            return [source]
        }

        if(source.isEmpty) {
            return []
        }

        if(takenBy == 0) {
            return []
        }

        if(takenBy == 1) {
            return source.map { [$0] }
        }

        var result : [[T]] = []

        let rest = Array(source.suffix(from: 1))
        let sub_combos = combinations(source: rest, takenBy: takenBy - 1)

        result += sub_combos.map { [source[0]] + $0 }
        
        result += combinations(source: rest, takenBy: takenBy)

        return result
    }
}

