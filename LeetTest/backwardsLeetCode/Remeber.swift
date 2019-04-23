//
//  Remeber.swift
//  LeetTest
//
//  Created by Jim Chuang on 2019/2/26.
//  Copyright © 2019 jj. All rights reserved.
//

import Foundation

class Square {
    var width: Double = 0
    var area: Double {
        get {
            return width * width
        }
        set(newArea) {
            width = sqrt(newArea)
        }
    }
}

class flatten {
    func flatten(_ x: Any) -> [Any]? {
        return (x as? [Any])?.flatMap { flatten($0) ?? [$0] }
    }
}

class UseTheThrow{

    enum GoAfterGirlError:Error {
        case poorProblem
        case tooYoungProblem
        case notAquariusProblem
        case falseHeartProblem
    }

    func goAfterAngelababy(money:Int, age:Int) throws -> String {
        guard money > 10000 else {
            throw GoAfterGirlError.poorProblem
        }
        guard age > 18 else {
            throw GoAfterGirlError.tooYoungProblem
        }
        return "我追到 Angelababy 了!"
    }
}

class ShowTime{

    //獲得時間
    func getTimeToStr(){
        var myDate = DateComponents()
        myDate.calendar = Calendar.current
        myDate.year = 2019
        myDate.month = 4
        myDate.day = 16

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        for x in 37...40{
            let timeInter = TimeInterval(exactly: 60*60*24*7*x*0)
            let data = myDate.date?.addingTimeInterval(timeInter!)
            let str = dateFormatter.string(from: data!)
            print(str)
        }
    }

    private func convertTimeZoneOfGmtToTst(gmtTimeStr:String) -> String{

        // Source timezone is GMT
        let gmtDateFormatter = DateFormatter()
        gmtDateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        gmtDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let myDate = gmtDateFormatter.date(from: gmtTimeStr){

            // Change to Taiwan timezone
            let tstDateFormatter = DateFormatter()
            tstDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            tstDateFormatter.timeZone = TimeZone(abbreviation: "TST")
            let tstTimeStr = tstDateFormatter.string(from: myDate)

            return tstTimeStr

        }else{

            return gmtTimeStr
        }
    }
}

class getBase64 {
    // 轉成base64
    func getBase64OfString(_ str:String) -> String{
        let base64data = str.data(using: String.Encoding.utf8)
        if let base64Str = base64data?.base64EncodedString(){
            return base64Str
        }
        return str
    }
}

/*
 ceil 無條件進位
 lround(double) -> Int 四捨五入
 Int(11.24) // 11   無條件捨去
 lrint(double) -> Int
 lrintf(float) -> Int
 */

/*
 let az = (0x41...0x5A).map({Character(UnicodeScalar($0))})
 let num = (0x30...0x39).map({Character(UnicodeScalar($0))})
 var myArr = num + az
 print(myArr)
 */

/*
 逃離函數 @escaping
 private func requestWithFormData(urlString: String, parameters: [String: Any], /*dataPath: [String: Data],*/ completion: @escaping (Data) -> Void){
 let url = URL(string: urlString)!
 var request = URLRequest(url: url)
 request.httpMethod = "POST"
 let boundary = "Boundary+\(arc4random())\(arc4random())"
 var body = Data()

 request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

 for (key, value) in parameters {
 body.appendString(string: "--\(boundary)\r\n")
 body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
 body.appendString(string: "\(JSON(value))\r\n")
 }
 /*
 for (key, value) in dataPath {
 body.appendString(string: "--\(boundary)\r\n")
 body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(arc4random())\"\r\n") //此處放入file name，以隨機數代替，可自行放入
 body.appendString(string: "Content-Type: image/png\r\n\r\n") //image/png 可改為其他檔案類型 ex:jpeg
 body.append(value)
 body.appendString(string: "\r\n")
 }
 */

 body.appendString(string: "--\(boundary)--\r\n")
 request.httpBody = body
 fetchedDataByDataTask(from: request, completion: completion)

 }
 */
