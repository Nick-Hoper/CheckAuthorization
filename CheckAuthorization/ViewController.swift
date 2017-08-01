//
//  ViewController.swift
//  CheckAuthorization
//
//  Created by nick on 2017/8/1.
//  Copyright © 2017年 nick. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class ViewController: UIViewController {
    

    @IBAction func checkPhotoAction(_ sender: Any) {
        
        let test = self.checkPhoto()
        print("test=\(test)")
    }
    
    
    @IBAction func checkCaptureAction(_ sender: Any) {
        
        let test = self.checkCapture()
        print("test=\(test)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //检查相册权限
    func checkPhoto()->Bool{
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        
        switch status {
        case .authorized:
            return true
            
        case .notDetermined:
            // 请求授权
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    _ = self.checkPhoto()
                })
            })
            
            
            
        default: ()
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: "照片访问受限",
                                                    message: "点击“设置”，允许访问您的照片",
                                                    preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
            
            let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
                (action) -> Void in
                let url = URL(string: UIApplicationOpenSettingsURLString)
                if let url = url, UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:],
                                                  completionHandler: {
                                                    (success) in
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
        }
        return false
    }
    
    //检查相机权限
    func checkCapture()->Bool{
        
        
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        
        switch authStatus {
        case .authorized:
            return true
            
        case .notDetermined:
            
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo,completionHandler: { (granted:Bool) -> Void in
                if (granted == false) {
                    print(granted)
                    _ = self.checkCapture()
                }
                else {
                    print(granted)
                    
                    //  _ = self.checkCapture()
                }
            })
            
            
        default: ()
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: "相机访问受限",
                                                    message: "点击“设置”，允许访问您的相机",
                                                    preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
            
            let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
                (action) -> Void in
                let url = URL(string: UIApplicationOpenSettingsURLString)
                if let url = url, UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:],
                                                  completionHandler: {
                                                    (success) in
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
        }
        return false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

