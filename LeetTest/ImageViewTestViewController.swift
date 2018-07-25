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

        /*
          3
         5126
          4
        */
        //1
        let subView1 = UIImageView.init(frame: myIV1.bounds)
        subView1.image = image
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.width/2)
        subView1.layer.transform = subTransform

        //2
        let subView2 = UIImageView.init(frame: myIV1.bounds)
        subView2.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, 1, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.width/2)
        subView2.layer.transform = subTransform

        //3
        let subView3 = UIImageView.init(frame: myIV1.bounds)

        subView3.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 1, 0, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.height/2+50)
        subView3.frame.size.width = subView3.frame.width > subView3.frame.height ? subView3.frame.width : subView3.frame.height
        subView3.frame.size.height = subView3.frame.width > subView3.frame.height ? subView3.frame.width : subView3.frame.height
        subView3.layer.transform = subTransform

        //4
        let subView4 = UIImageView.init(frame: myIV1.bounds)

        subView4.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), -1, 0, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.height/2-60)
        subView4.frame.size.width = subView3.frame.width > subView3.frame.height ? subView3.frame.width : subView3.frame.height
        subView4.frame.size.height = subView3.frame.width > subView3.frame.height ? subView3.frame.width : subView3.frame.height
        subView4.layer.transform = subTransform

        //5
        let subView5 = UIImageView.init(frame: myIV1.bounds)
        subView5.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, -1, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, myIV1.frame.size.width/2)
        subView5.layer.transform = subTransform

        //6
        let subView6 = UIImageView.init(frame: myIV1.bounds)
        subView6.image = image
        subTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, 0, 0)
        subTransform = CATransform3DTranslate(subTransform, 0, 0, -myIV1.frame.size.width/2)
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
