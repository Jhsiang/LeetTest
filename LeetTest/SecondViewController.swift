//
//  SecondViewController.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/6/12.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource
    //,UICollectionViewDragDelegate,UICollectionViewDropDelegate
{
    var str1 = ""
    var str2 = ""
    var scrollTo15 = false
    var collectionScrollTo15 = false
    var eventArr = Array<event>()

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var myCollectionView: UICollectionView!
    @IBOutlet var myBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        myBtn.setImage(Graphics.getAddImageNormal(), for: .normal)

        NSLog("cow = \(calCow(years: 10))")
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        if 8 ~= 9{
            DLog(message: "8 ~= 9 is true")
        }else{
            DLog(message: "8 ~= 9 is false")
        }
        let myAmountArray = Array(repeating: 10, count: 10)
        for i in 0...15{
            if let x = safeArr(arr: myAmountArray, index: i){
                NSLog("myArr[\(i)] = \(x)")
            }else{
                NSLog("myArr[\(i)] is over range")
            }
        }

        scrollTo15 = true
        collectionScrollTo15 = true
    }

    //MARK: - Define Function
    func safeArr<T>(arr:Array<T>,index:Int) -> T? {
        return arr.indices ~= index ? arr[index] : nil
    }



// MARK: - Btn Click
    @IBAction func btnClick(_ sender: Any) {
        let myEvent = event()
        myEvent.date = translate(d: datePicker.date)
        myEvent.name = "haha"
        eventArr.append(myEvent)
        eventArr = eventArr.filter{$0.date != "01/01"}
        for i in 0...eventArr.count - 1{
            DLog(message: eventArr[i].name)
            DLog(message: eventArr[i].date)
        }

        let index1 = IndexPath(item: 4, section: 0)
        let index2 = IndexPath(item: 25, section: 0)
        myCollectionView.moveItem(at: index1, to: index2)

        /*
//        if #available(iOS 9.0, *) {
//            myCollectionView.beginInteractiveMovementForItem(at: index1)
//        } else
//            // Fallback on earlier versions
//        }
 */
    }

/*
    //MARK: - UICollectionViewDropDelegate
//    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        let dragItem = UIDragItem
//    }
     //

//    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
//        NSLog("perform Drop trigger")
//    }

*/
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        NSLog("move item at trigger")
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        NSLog("can move trigger")
        return true
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MyCollectionViewCell
        if let myLabel = myCell.myLabel{
            myLabel.text = "\(indexPath.item)"
        }
        if collectionScrollTo15 == true{
            collectionScrollTo15 = false
            let myIndex = IndexPath(row: 15, section: 0)
            collectionView.scrollToItem(at: myIndex, at: .top, animated: true)
        }
        return myCell
    } 

    //MARK: - UITablevVewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        if let myLabel = myCell.textLabel{
            myLabel.text = "\(indexPath.row)"
        }
        if let myImageView = myCell.imageView{
            myImageView.image = UIImage(named: "1.png")
        }
        if scrollTo15 == true{
            scrollTo15 = false
            let myIndex = IndexPath(row: 15, section: 0)
            tableView.scrollToRow(at: myIndex, at: .top, animated: true)
        }
        return myCell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
