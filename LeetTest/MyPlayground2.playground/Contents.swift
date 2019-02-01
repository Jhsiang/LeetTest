import UIKit

var str = "Hello, playground"
print("str = ",str)
/*
let array:[UInt8] = [230, 184, 172, 232, 169, 166]
let data = Data(bytes: array)

data.subdata(in: 0..<4).forEach{ print("a \($0)") } //报错
data.subdata(in: 3..<3).forEach{ print("b \($0)") } //0 bytes
data.subdata(in: 3..<4).forEach{ print("c \($0)") } //0x04

data[3...4].forEach{ print("A \($0)") } //0x04, 0x05
data[3..<3].forEach{ print("B \($0)") } //0 bytes
data[3..<4].forEach{ print("C \($0)") } //0x04

let aa = data.subdata(in: 3..<3)
let bb = data.subdata(in: 3..<4)
let cc = data.subdata(in: 0..<5)

print(aa)
print(bb)
print(cc)
let dd = String(bytes: cc, encoding: String.Encoding.utf8)
print(dd)

*/



print(sortTwisted37( [1,2,3,4,5,6,7,8,9]))
print(sortTwisted37([12,13,14]))
print(sortTwisted37([9,2,4,7,3]))

/*
 #Sorting on planet Twisted-3-7

 There is a planet... in a galaxy far far away. It is exactly like our planet, but it has one difference:

 #The values of the digits 3 and 7 are twisted. Our 3 means 7 on the planet Twisted-3-7. And 7 means 3.

 Your task is to create a method, that can sort an array the way it would be sorted on Twisted-3-7.

 7 Examples from a friend from Twisted-3-7:

 [1,2,3,4,5,6,7,8,9] -> [1,2,7,4,5,6,3,8,9]
 [12,13,14] -> [12,14,13]
 [9,2,4,7,3] -> [2,7,4,3,9]
 There is no need for a precheck. The array will always be not null and will always contain at least one number.

 You should not modify the input array!

 Have fun coding it and please don't forget to vote and rank this kata! :-)

 I have also created other katas. Take a look if you enjoyed this kata!
 */
