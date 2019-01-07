//
//  DemoParkingViewController.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/7/9.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

class DemoParkingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet var repeatView: UIView!
    @IBOutlet var menuBtnView: UIView!
    @IBOutlet var adCollectionView: UICollectionView!

    let adScriptArr = ["廣告設計","代書尋找","冠軍榮耀","多種口味","就是要個性","找人代工","一個人的滋味","拒絕煙害","搶救菜農","人手一機","快速方便","立即見效"]
    let adPriceArr = ["$7999","$589","$12000 ↑","$269","$899","50$ ↑","$39 ↑","$0","$29 ↑","$0 ↑","$17 ↑","$99 ↓"]
    let adSpareArr = ["無限量","無限量","無限量","無限量","無限量","5/33","無限量","無限量","56/78","23/50","無限量","9/10"]
    var adScrollView = UIScrollView()
    var adPageCtrl = UIPageControl()



    override func viewDidLoad() {
        super.viewDidLoad()

        adScrollView.delegate = self
        adCollectionView.delegate = self

    }

    override func viewDidAppear(_ animated: Bool) {

        adScrollView.frame = CGRect(x: 0, y: 0, width: repeatView.bounds.width, height: repeatView.bounds.height)
        adScrollView.contentSize = CGSize(width: repeatView.bounds.width * 6, height: repeatView.bounds.height)
        adScrollView.isPagingEnabled = true
        adScrollView.bounces = true
        adScrollView.showsHorizontalScrollIndicator = false

        for i in 0...5{
            let repeatImageView = UIImageView()
            repeatImageView.frame = CGRect(x: CGFloat(i) * repeatView.bounds.width, y: 0, width: repeatView.bounds.width, height: repeatView.bounds.height)
            repeatImageView.image = UIImage(named: "ads\(i+1).jpg")
            repeatImageView.contentMode = UIViewContentMode.scaleToFill

            adScrollView.addSubview(repeatImageView)
        }
        adPageCtrl.numberOfPages = 6
        adPageCtrl.currentPage = 0
        adPageCtrl.isEnabled = false
        adPageCtrl.currentPageIndicatorTintColor = .black
        adPageCtrl.pageIndicatorTintColor = .lightGray

        adPageCtrl.frame = CGRect(x: 0, y: repeatView.bounds.height - 40, width: repeatView.bounds.width, height: 40)


        repeatView.addSubview(adScrollView)
        repeatView.addSubview(adPageCtrl)

        //Timer.every(3, adScrollViewRotation)

        repeateTimer()


    }

    override func viewDidDisappear(_ animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func repeateTimer(){

        let myTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(adScrollViewRotation), userInfo: "time1", repeats: true)
        if let userinfo = myTimer.userInfo as? String{
            print(userinfo)
        }
    }

    @objc func adScrollViewRotation(){
        adScrollView.contentOffset.x += adScrollView.contentOffset.x < adScrollView.frame.width*5 ? adScrollView.frame.width : -adScrollView.contentOffset.x
    }

    //MARK: - Button Click
    @IBAction func firstBtnClick(_ sender: UIButton) {
        let alert = UIAlertController(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertControllerStyle#>)
    }
    @IBAction func secondBtnClick(_ sender: UIButton) {
    }
    @IBAction func thirdBtnClick(_ sender: UIButton) {
    }
    @IBAction func fouthBtnClick(_ sender: UIButton) {
    }


    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currPage = Int(scrollView.contentOffset.x / (scrollView.frame.width))
        adPageCtrl.currentPage = currPage
    }

    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_demo_parking", for: indexPath) as! DemoParkingTableViewCell
        cell.adIV.image = UIImage(named: "ad\(indexPath.item+1).jpeg")
        cell.scriptLabel.text = adScriptArr[indexPath.item]
        cell.priceLabel.text = adPriceArr[indexPath.item]
        cell.priceLabel.textColor = .red
        cell.spareLabel.text = adSpareArr[indexPath.item]
        cell.spareLabel.textColor = .white
        cell.spareLabel.backgroundColor = .red
        return cell
    }

    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGSize = CGSize(width: collectionView.frame.width/2-10, height: collectionView.frame.width/2)
        let myTestCellSize:CGSize = CGSizeFromString("test")

        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return insets
    }


}
