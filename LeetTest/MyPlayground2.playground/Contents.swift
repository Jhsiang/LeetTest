import UIKit

var str = "Hello, playground"
print("str = ",str)

class Node {
    var data: Int
    var next: Node?
    init(_ data: Int) {
        self.data = data
    }
}

func mergeSort(_ list:Node?) -> Node? {
    guard var list = list else {return nil}
    var arr = [Int]()
    while list.next != nil {
        arr.append(list.data)
        list = list.next!
    }

    arr.sort(by: <)
    var res = Node(arr[0])
    for (i,v) in arr.enumerated(){

        if i != 0 {
            let newNode = Node(v)
            newNode.next = res
            res = newNode
        }
    }
    return res
}

var aa = Node(1)
aa.next = Node(3)

print(aa.next?.data)

func merge(left:[Int],right:[Int]) -> [Int] {
    var mergedList = [Int]()
    var left = left
    var right = right

    while left.count > 0 && right.count > 0 {
        if left.first! < right.first! {
            mergedList.append(left.removeFirst())
        } else {
            mergedList.append(right.removeFirst())
        }
    }

    return mergedList + left + right
}

func mergeSort2(_ list:[Int]) -> [Int] {
    guard list.count > 1 else {
        return list
    }

    let leftList = Array(list[0..<list.count/2])
    let rightList = Array(list[list.count/2..<list.count])

    return merge(left: mergeSort2(leftList), right: mergeSort2(rightList))
}

mergeSort2([6,4,8,2,9,0,26,2])
