//
//  AlloverMacro.swift
//  SwiftTableView
//
//  Created by 李云鹏 on 16/9/13.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit
import AVFoundation

// 简单宏(实际是全局常量)
let WIDTH = UIScreen.main.bounds.width
let HEIGHT = UIScreen.main.bounds.height
let FIT_WIDTH = UIScreen.main.bounds.width/375
let FIT_HEIGHT = UIScreen.main.bounds.height/667
let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height
let mainColor = UIColor.init(red: 240/255.0, green: 166/255.0, blue: 116/255.0, alpha: 1)
let GRAY121COLOR = UIColor.init(red: 121/255.0, green: 121/255.0, blue: 121/255.0, alpha: 1)
let PLACEHOLODERCOLOR = UIColor.init(red: 199/255.0, green: 199/255.0, blue: 205/255.0, alpha: 1)
let DARKRED = UIColor.init(red: 231/255.0, green: 97/255.0, blue: 83/255.0, alpha: 1)
let WORDFONT = UIFont.systemFont(ofSize: 15.5)
let UmengAppkey = "5705cd51e0f55a586d000567"// 友盟


// 函数宏(实际是全局函数,不是宏)
func X (_ aView:UIView)->CGFloat{
    return aView.frame.origin.x;
}

func Y (_ aView:UIView)->CGFloat{
    return aView.frame.origin.y;
}

func PART_W (_ aView:UIView)->CGFloat{
    return aView.frame.size.width;
}

func PART_H (_ aView:UIView)->CGFloat{
    return aView.frame.size.height;
}

func RGBA(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a);
}

func navigationBar_H(_ aNavigationController:UINavigationController) -> CGFloat {
    return aNavigationController.navigationBar.frame.origin.y+aNavigationController.navigationBar.frame.size.height;
}

func tabBar_H(_ aTabBarController:UITabBarController) -> CGFloat {
    return aTabBarController.tabBar.frame.size.height;
}

func validateCamera() -> Bool {
    return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) && UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear)
}

func canUseCamera() -> Bool {
    let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo);
    if (authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied) {
        
        let block = { (index:Int)  in
            switch index {
            case 0:
                UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
                break;
            case 1:
                NSLog("取消")
                break;
            default:
                break;
            }
        }
        
        MMAlertView.init(title: "", detail: "\n请在设备的设置-隐私-相机中允许访问相机", items: [MMItemMake("设置", MMItemType.normal, block), MMItemMake("取消", MMItemType.highlight, block)]).show(nil)
        return false;
    }
    return true;
}















