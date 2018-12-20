//
//  CollectGestureTestViewController.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/12/19.
//  Copyright © 2018 jj. All rights reserved.
//

import UIKit

class CollectGestureTestViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var arrData = Array<Int>()
    @IBOutlet var myCollectionView: UICollectionView!

    let arrColor:Array<UIColor> = [.blue,.red,.green,.purple,.yellow,.brown]
    var startIndexPath = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...29{
            arrData.append(Int.random(in: 0...5))
        }

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.addGestureRecognizer(setLongPress())



    }

    //MARK: - Gesture Recognizer
    func setLongPress() -> UILongPressGestureRecognizer{
        let myLognPress = UILongPressGestureRecognizer(target: self, action: #selector(whenLongPress))
        myLognPress.minimumPressDuration = 0.04
        return myLognPress
    }

    @objc func whenLongPress(sender:UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            if let selectIndexpath = myCollectionView.indexPathForItem(at: sender.location(in: sender.view!)){
                startIndexPath = selectIndexpath
                myCollectionView.beginInteractiveMovementForItem(at: selectIndexpath)
            }

            break
        case .changed:

            if let moveIndexpath = myCollectionView.indexPathForItem(at: sender.location(in: sender.view!)){
                if startIndexPath == moveIndexpath{
                    myCollectionView.updateInteractiveMovementTargetPosition(sender.location(in: sender.view!))
                }else{

                    // array swap
                    let swapValue = arrData[startIndexPath.row]
                    arrData[startIndexPath.row] = arrData[moveIndexpath.row]
                    arrData[moveIndexpath.row] = swapValue

                    // update startIndex
                    startIndexPath = moveIndexpath

                    self.myCollectionView.reloadData()

                    DispatchQueue.main.asyncAfter(deadline: .now()+0.001) {
                        self.myCollectionView.endInteractiveMovement()
                        self.myCollectionView.beginInteractiveMovementForItem(at: self.startIndexPath)
                        self.myCollectionView.updateInteractiveMovementTargetPosition(sender.location(in: sender.view!))
                    }
                }
            }
            break
        case .ended:
            myCollectionView.endInteractiveMovement()
        default:
            myCollectionView.cancelInteractiveMovement()
            break
        }

    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("sourece = ",sourceIndexPath.row)
        print("destination = ",destinationIndexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "move_cell", for: indexPath) as! GestureCollectionViewCell

        cell.label.text = "\(arrData[indexPath.row])"
        let bgColor = arrColor[arrData[indexPath.row]%6]
        cell.backgroundColor = bgColor
        cell.label.adjustsFontSizeToFitWidth = true

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }


    //MARK: - UICollectionViewDelegateFlowLayout
    // cell 尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGSize = CGSize(width: myCollectionView.frame.width/6, height: collectionView.frame.height/5)
        return cellSize
    }

    // 左右間距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }

    // 上下間距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

