//
//  FirstViewController.swift
//  SwiftTableView
//
//  Created by 李云鹏 on 16/9/12.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    // 这是写属性的地方
    var nameArr = ["navigationBar使用背景图片", "输入框随键盘一起动", "gauss模糊", "Share", "Map", "二维码", "视频播放", "block", "天气", "清除缓存", "日期选择", "我的银行卡", "本地相册选取", "轮播图", "热更新", "弹幕", "日历", "商城首页", "商城分类", "商城发现", "商城购物车", "商城我的"];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Plain);
    var clearLabel = UILabel.init(frame: CGRectMake(WIDTH-115, 450, 100, 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView();
    }
    
    func getView() -> Void {
        self.navigationItem.title = "Home"
        
        self.myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.view.addSubview(self.myTableView);
        self.clearLabel.textAlignment = NSTextAlignment.Right
        self.clearLabel.textColor = UIColor.redColor()
        self.clearLabel.font = UIFont.systemFontOfSize(14)
        self.clearLabel.text = String(format: "%.2fM", SDImageCache.sharedImageCache().checkTmpSize())
        self.myTableView.addSubview(self.clearLabel)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearLabel.text = String(format: "%.2fM", SDImageCache.sharedImageCache().checkTmpSize())
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellName = "qweeqwqghghggnklhlhwdaeqwe";
        var cell = tableView.dequeueReusableCellWithIdentifier(cellName);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellName)
        }
        cell!.textLabel?.text = self.nameArr[indexPath.row];
        return cell!;
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let firstInfoVC = FirstInfoViewController.init();
            firstInfoVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(firstInfoVC, animated: true);
            break;
        case 1:
            let keyboardVC = FirstKeyboardViewController.init();
            keyboardVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(keyboardVC, animated: true);
            break;
        case 2:
            let gaussVC = FirstGaussViewController.init();
            gaussVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(gaussVC, animated: true);
            break;
        case 3:
            let shareVC = FirstShareViewController.init();
            shareVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(shareVC, animated: true);
            break;
        case 4:
            let mapVC = FirstMapViewController.init();
            mapVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(mapVC, animated: true);
            break;
        case 5:
            self.scanAction()
            break;
        case 6:
            let playerVC = FirstPlayerViewController.init();
            playerVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(playerVC, animated: true);
            break;
        case 7:
            let testBlockVC = FirstOriginBlockViewcontroller.init();
            testBlockVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(testBlockVC, animated: true);
            break;
        case 8:
            let weatherVC = FirstWeatherViewController.init();
            weatherVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(weatherVC, animated: true);
            break;
        case 9:
            let hud = MBProgressHUD.init(view: self.view)
            UIApplication.sharedApplication().keyWindow!.addSubview(hud)
            hud.labelFont = UIFont.systemFontOfSize(15);
            hud.labelText = "清理中...";
            hud.show(true)
            SDImageCache.sharedImageCache().clearDiskOnCompletion({
                self.clearLabel.text = String(format: "%.2fM", SDImageCache.sharedImageCache().checkTmpSize())
                sleep(1)
                hud.removeFromSuperview()
            })
            break;
        case 10:
            let dateVC = FirstDateChoseViewController.init();
            dateVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(dateVC, animated: true);
            break;
        case 11:
            let bankVC = FirstBankCardViewController.init();
            bankVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(bankVC, animated: true);
            break;
        case 12:
            let photoVC = FirstPhotoChoseViewController.init();
            photoVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(photoVC, animated: true);
            break;
        case 13:
            let cycleVC = FirstCycleScrollViewController.init();
            cycleVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(cycleVC, animated: true);
            break;
        case 14:
            let hotVC = FirstHotRenewViewController.init();
            hotVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(hotVC, animated: true);
            break;
        case 15:
            let barrageVC = FirstBarrageViewController.init();
            barrageVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(barrageVC, animated: true);
            break;
        case 16:
            let calendarVC = FirstCalendarViewController.init();
            calendarVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(calendarVC, animated: true);
            break;
        case 17:
            let storeHomeVC = FirstStoreHomeViewController.init();
            storeHomeVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(storeHomeVC, animated: true);
            break;
        case 18:
            let storeDifferentVC = FirstStoreDifferentClassViewController.init();
            storeDifferentVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(storeDifferentVC, animated: true);
            break;
        case 19:
            let storeFoundVC = FirstStoreFoundViewController.init();
            storeFoundVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(storeFoundVC, animated: true);
            break;
        case 20:
            let storeCarVC = FirstStoreCarViewController.init();
            storeCarVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(storeCarVC, animated: true);
            break;
        case 21:
            let storeMeVC = FirstStoreMeViewController.init();
            storeMeVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(storeMeVC, animated: true);
            break;
        default:
            break;
        }
    }
    
    func scanAction() -> Void {
        if (self.validateCamera() && self.canUseCamera()) {
            let qrVC = QRViewController.init();
            let block = { (resultUrl)  in
                MMAlertView.init(confirmTitle: "扫描结果:", detail: resultUrl).showWithBlock(nil);
            }
            qrVC.qrUrlBlock = block
            qrVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(qrVC, animated: true)
        }
    }
    
    func validateCamera() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) && UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)
    }
    
    func canUseCamera() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo);
        if (authStatus == AVAuthorizationStatus.Restricted || authStatus == AVAuthorizationStatus.Denied) {
            
            let block = { (index:Int)  in
                switch index {
                case 0:
                    UIApplication.sharedApplication().openURL(NSURL.init(string: UIApplicationOpenSettingsURLString)!)
                    break;
                case 1:
                    NSLog("取消")
                    break;
                default:
                    break;
                }
            }
            
            MMAlertView.init(title: "", detail: "\n请在设备的设置-隐私-相机中允许访问相机", items: [MMItemMake("设置", MMItemType.Normal, block), MMItemMake("取消", MMItemType.Highlight, block)]).showWithBlock(nil)
            return false;
        }
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
