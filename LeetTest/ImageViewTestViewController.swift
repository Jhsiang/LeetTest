//
//  ImageViewTestViewController.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/7/20.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

class ImageViewTestViewController: UIViewController {

    let deg = CGFloat(M_PI/180)

    @IBOutlet var myIV: UIImageView!
    @IBOutlet var myIV1: UIImageView!


    var angle:CGFloat = 60
    var xValue:CGFloat = 1
    var yValue:CGFloat = -1
    var zValue:CGFloat = 0.1


    var angle2 = CGPoint.init(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        var myArr = Array<String>()
        var son = 63
        var mom = 64
        while son != 1 {
            let q = mom / son
            let nextMom = q + 1
            myArr.append("1/\(nextMom)")
            (son,mom) = spareHandle(son1: son, mom1: mom, son2: 1, mom2: nextMom)
        }
        myArr.append("1/\(mom)")


        DLog(message: myArr)
        /*
         */
    }

    func spareHandle(son1:Int,mom1:Int,son2:Int,mom2:Int) -> (Int,Int){
        let son = son1 * mom2 - son2 * mom1
        let mom = mom1 * mom2
        return minmumNum(son: son, mom: mom)
    }

    func minmumNum(son:Int,mom:Int) ->(Int,Int){
        let calSon = son
        let calMom = mom
        guard son != 1 else{
            return (calSon,calMom)
        }
        guard mom != 1 else{
            return (calSon,calMom)
        }
        for x in 2...calSon{
            if calSon % x == 0,calMom % x == 0{
                return minmumNum(son:calSon/x, mom:calMom/x)
            }
        }
        return (calSon,calMom)
    }

    override func viewDidAppear(_ animated: Bool) {
        DLog(message: angle)

        //myIV1.image = image

        addSubView()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTransform))
        myIV1.isUserInteractionEnabled = true
        myIV1.addGestureRecognizer(panGesture)


        var trans = CATransform3DIdentity
        trans.m34 = 1.0 / -500.0



        //myIV1.layer.transform = CATransform3DRotate(trans, angle2, 0, 1, 0)
/*
        var trans2 = CATransform3DTranslate(trans, 0, 0, 50)

        trans2 = CATransform3DTranslate(trans, 50, 0, 0)
        trans2 = CATransform3DRotate(trans2, CGFloat.pi/4 , 0 , 1 , 0);
        myIV2.layer.transform = trans2

        trans2 = CATransform3DTranslate(trans, 0, -50, 0)
        trans2 = CATransform3DRotate(trans2, CGFloat.pi/4 , 1 , 0 , 0);
        myIV3.layer.transform = trans2

        trans2 = CATransform3DTranslate(trans, 0, 50, 0)
        trans2 = CATransform3DRotate(trans2, CGFloat.pi/4 , -1 , 0 , 0);
        myIV4.layer.transform = trans2

        trans2 = CATransform3DTranslate(trans, -50, 0, 0)
        trans2 = CATransform3DRotate(trans2, CGFloat.pi/4 , 0 , 1 , 0);
        myIV5.layer.transform = trans2

        trans2 = CATransform3DTranslate(trans, 0, 0, -50)
        trans2 = CATransform3DRotate(trans2, CGFloat.pi/4 , 0 , 1 , 0);
        myIV6.layer.transform = trans2
*/
        

        var rotationAndPerspectiveTransform = CATransform3DIdentity
        rotationAndPerspectiveTransform.m34 = 1.0 / -500.0
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, angle*deg, xValue, yValue, zValue)
        myIV.layer.transform = rotationAndPerspectiveTransform
    }


    func addSubView(){
        let image = UIImage(named: "ad1.jpeg")
        var subTransform = CATransform3DIdentity

        //1
        let subView1 = UIImageView.init(frame: myIV1.bounds)
        let label1 = UILabel.init(frame: myIV1.bounds)
        label1.text = "1"
        label1.adjustsFontSizeToFitWidth = true
        label1.textAlignment = .center
        label1.backgroundColor = UIColor.yellow
        subView1.addSubview(label1)
        //subView1.image = image
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.width/2)
        subView1.layer.transform = subTransform

        //2
        let subView2 = UIImageView.init(frame: myIV1.bounds)
        let label2 = UILabel.init(frame: myIV1.bounds)
        label2.text = "2"
        label2.adjustsFontSizeToFitWidth = true
        label2.textAlignment = .center
        subView2.addSubview(label2)
        label2.backgroundColor = UIColor.yellow
        //subView2.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, 1, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.width/2)
        subView2.layer.transform = subTransform

        //3
        let subView3 = UIImageView.init(frame: myIV1.bounds)
        let label3 = UILabel.init(frame: myIV1.bounds)
        label3.text = "3"
        label3.adjustsFontSizeToFitWidth = true
        label3.textAlignment = .center
        subView3.addSubview(label3)
        label3.backgroundColor = UIColor.yellow
        //subView3.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 1, 0, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.height/2)
        subView3.layer.transform = subTransform

        //4
        let subView4 = UIImageView.init(frame: myIV1.bounds)
        let label4 = UILabel.init(frame: myIV1.bounds)
        label4.text = "4"
        label4.adjustsFontSizeToFitWidth = true
        label4.textAlignment = .center
        subView4.addSubview(label4)
        label4.backgroundColor = UIColor.yellow
        //subView4.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), -1, 0, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.height/2)

        subView4.layer.transform = subTransform

        //5
        let subView5 = UIImageView.init(frame: myIV1.bounds)
        let label5 = UILabel.init(frame: myIV1.bounds)
        label5.text = "5"
        label5.adjustsFontSizeToFitWidth = true
        label5.textAlignment = .center
        subView5.addSubview(label5)
        label5.backgroundColor = UIColor.yellow
        //subView5.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, -1, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.width/2)
        subView5.layer.transform = subTransform

        //6
        let subView6 = UIImageView.init(frame: myIV1.bounds)
        let label6 = UILabel.init(frame: myIV1.bounds)
        label6.text = "6"
        label6.adjustsFontSizeToFitWidth = true
        label6.textAlignment = .center
        subView6.addSubview(label6)
        label6.backgroundColor = UIColor.yellow
        //subView6.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi), 0, 1, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.width/2)
        subView6.layer.transform = subTransform

        myIV1.addSubview(subView1)
        myIV1.addSubview(subView2)
        myIV1.addSubview(subView3)
        myIV1.addSubview(subView4)
        myIV1.addSubview(subView5)
        myIV1.addSubview(subView6)
    }

    @objc func viewTransform(sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: myIV1)
        let angleX = angle2.x + (point.x/30)
        let angleY = angle2.y - (point.y/30)

        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500

        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        myIV1.layer.sublayerTransform = transform


        if sender.state == .ended {
            angle2.x = angleX
            angle2.y = angleY
        }
    }

    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {

    }

    @IBAction func imageClick(_ sender: UITapGestureRecognizer) {
        DLog(message: "OK")
    }
    @IBAction func xBtnClick(_ sender: Any) {

        xValue += xValue < 1 ? 0.1 : 0
        xValue = xValue >= 1 ? -1 : xValue
        DLog(message: "x = \(xValue) y = \(yValue) z = \(zValue)")
        var rotationAndPerspectiveTransform = CATransform3DIdentity
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000.0
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, angle*deg, xValue, yValue, zValue)
        myIV.layer.transform = rotationAndPerspectiveTransform

    }

    @IBAction func yBtnClick(_ sender: Any) {

        yValue += yValue < 1 ? 0.1 : 0
        yValue = yValue >= 1 ? -1 : yValue
        DLog(message: "x = \(xValue) y = \(yValue) z = \(zValue)")
        var rotationAndPerspectiveTransform = CATransform3DIdentity
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000.0
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, angle*deg, xValue, yValue, zValue)
        myIV.layer.transform = rotationAndPerspectiveTransform
    }

    @IBAction func zBtnClick(_ sender: Any) {


        zValue += zValue < 1 ? 0.1 : 0
        zValue = zValue >= 1 ? -1 : zValue
        DLog(message: "x = \(xValue) y = \(yValue) z = \(zValue)")
        var rotationAndPerspectiveTransform = CATransform3DIdentity
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000.0
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, angle*deg, xValue, yValue, zValue)
        myIV.layer.transform = rotationAndPerspectiveTransform
    }







    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
