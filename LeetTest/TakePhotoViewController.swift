//
//  TakePhotoViewController.swift
//  LeetTest
//
//  Created by Jim Chuang on 2018/8/28.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

class TakePhotoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let picker: UIImagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let myStr = UserDefaults.standard.string(forKey: "car"){
            //DLog(message: myStr)
            DLog(message: myStr.count)
        }

        // 開啟相機
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.allowsEditing = false
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
            picker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.auto
            picker.showsCameraControls = true
            self.present(picker, animated: true, completion: nil)
        } else {
            print("沒有相機鏡頭...")
        }

    }

    //使用照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil) // 關掉
        let myPickerIg:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage // 從Dictionary取出原始圖檔
        let drawImage = resizeImage(originalImg: myPickerIg)
        let imageData:NSData = UIImageJPEGRepresentation(drawImage, 0.5)! as NSData
        let str64 = imageData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        UserDefaults.standard.set(str64, forKey: "car")

        self.navigationController?.popViewController(animated: true)

    }

    // ref: https://www.jianshu.com/p/55963644aeba
    private func resizeImage(originalImg:UIImage) -> UIImage{

        //prepare constants
        let width = originalImg.size.width
        let height = originalImg.size.height
        let scale = width/height

        var sizeChange = CGSize()

        if width <= 1280 && height <= 1280{ //a，图片宽或者高均小于或等于1280时图片尺寸保持不变，不改变图片大小
            return originalImg
        }else if width > 1280 || height > 1280 {//b,宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280

            if scale <= 2 && scale >= 1 {
                let changedWidth:CGFloat = 1280
                let changedheight:CGFloat = changedWidth / scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)

            }else if scale >= 0.5 && scale <= 1 {

                let changedheight:CGFloat = 1280
                let changedWidth:CGFloat = changedheight * scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)

            }else if width > 1280 && height > 1280 {//宽以及高均大于1280，但是图片宽高比大于2时，则宽或者高取小的等比压缩至1280

                if scale > 2 {//高的值比较小

                    let changedheight:CGFloat = 1280
                    let changedWidth:CGFloat = changedheight * scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)

                }else if scale < 0.5{//宽的值比较小

                    let changedWidth:CGFloat = 1280
                    let changedheight:CGFloat = changedWidth / scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)

                }
            }else {//d, 宽或者高，只有一个大于1280，并且宽高比超过2，不改变图片大小
                return originalImg
            }
        }

        UIGraphicsBeginImageContext(sizeChange)

        //draw resized image on Context
        originalImg.draw(in: CGRect(x: 0, y: 0, width: sizeChange.width, height: sizeChange.height))

        //create UIImage
        let resizedImg = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return resizedImg!
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
