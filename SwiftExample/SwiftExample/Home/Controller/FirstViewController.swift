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
    var nameArr = ["navigationBar使用背景图片", "输入框随键盘一起动", "gauss模糊", "Share", "Map", "二维码", "视频播放", "block", "天气", "清除缓存", "日期选择", "我的银行卡", "本地相册选取", "轮播图", "热更新", "弹幕", "日历", "商城首页", "商城分类", "商城发现", "商城购物车", "商城我的", "请输入密码", "圆形菜单", "球形标签", "推荐影片", "渐隐文字", "打印文字", "拼图", "2048", "浏览卡片", "抽卡效果", "抖动菜单", "渐变色"];
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
        case 22:
            let secretVC = FirstSecretcodeViewController.init();
            secretVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(secretVC, animated: true);
            break;
        case 23:
            let menuVC = FirstCircleMenuViewController.init();
            menuVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(menuVC, animated: true);
            break;
        case 24:
            let ballVC = FirstBallTagViewController.init();
            ballVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(ballVC, animated: true);
            break;
        case 25:
            let recommendVC = FirstRecommendMovieViewController.init();
            recommendVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(recommendVC, animated: true);
            break;
        case 26:
            let hiddenVC = FirstHiddenWordViewController.init();
            hiddenVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(hiddenVC, animated: true);
            break;
        case 27:
            let printVC = FirstPrintWordViewController.init();
            printVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(printVC, animated: true);
            break;
        case 28:
            let jigsawVC = FirstJigsawViewController.init();
            jigsawVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(jigsawVC, animated: true);
            break;
        case 29:
            let game2048VC = YFLittleProjectVC03.init();
            game2048VC.navigationItem.title = "2048"
            game2048VC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(game2048VC, animated: true);
            break;
        case 30:
            let observeVC = FirstObserveCardViewController.init();
            observeVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(observeVC, animated: true);
            break;
        case 31:
            let hurlVC = FirstHurlCardViewController.init();
            hurlVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(hurlVC, animated: true);
            break;
        case 32:
            let shakeVC = FirstShakeMenuViewController.init();
            shakeVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(shakeVC, animated: true);
            break;
        case 33:
            let graduallyVC = FirstGraduallyColorViewController.init();
            graduallyVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(graduallyVC, animated: true);
            break;
//        case 34:
//            let observeVC = FirstObserveCardViewController.init();
//            observeVC.hidesBottomBarWhenPushed = true;
//            self.navigationController?.pushViewController(observeVC, animated: true);
//            break;
            
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
