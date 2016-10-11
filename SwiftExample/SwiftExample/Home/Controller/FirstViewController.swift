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
    var nameArr = ["navigationBar使用背景图片", "输入框随键盘一起动", "gauss模糊", "Share", "Map", "二维码", "视频播放", "block", "天气", "清除缓存"];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Plain);
    var clearLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView();
    }
    
    func getView() -> Void {
        self.navigationItem.title = "Home"
        myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        myTableView.delegate = self;
        myTableView.dataSource = self
        self.view.addSubview(myTableView);
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellName = "qweqweqwe";
        var cell = tableView.dequeueReusableCellWithIdentifier(cellName);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellName)
        }
        cell?.textLabel?.text = nameArr[indexPath.row];
        if indexPath.row == 9 {
            if (self.clearLabel == nil) {
                self.clearLabel = UILabel.init(frame: CGRectMake(WIDTH-115, 0, 100, 50))
                self.clearLabel?.textAlignment = NSTextAlignment.Right
                self.clearLabel?.textColor = UIColor.redColor()
                self.clearLabel?.font = UIFont.systemFontOfSize(14)
                self.clearLabel?.text = String(format: "%.2fM", SDImageCache.sharedImageCache().checkTmpSize())
                cell?.addSubview(self.clearLabel!)
            }
        }
        
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
//            let scanVC = FirstScanViewController.init();
//            scanVC.hidesBottomBarWhenPushed = true;
//            self.navigationController?.pushViewController(scanVC, animated: true);
            self.scan()
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
            SDImageCache.sharedImageCache().clearDiskOnCompletion({
                self.clearLabel?.text = String(format: "%.2fM", SDImageCache.sharedImageCache().checkTmpSize())
            })
            break;
        default:
            break;
        }
        
    }
    
    func scan() -> Void {
        //
        if (self.validateCamera() && self.canUseCamera()) {
            var qrVC = QRViewController.init();
//            typealias sendValueClosure=(string:String)->Void
//            var block = (url:NSString)->Void{
//                in
//            }
//            qrVC.qrUrlBlock = block;
            qrVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(qrVC, animated: true)
        }
    }
    
//    - (void)scanAction:(UIBarButtonItem *)rightBar
//    {
//    if ([self validateCamera] && [self canUseCamera]) {
//    QRViewController *qrVC = [[QRViewController alloc] init];
//    void (^block)(NSString *url) = ^(NSString *url){
//    // url
//    
//    };
//    qrVC.qrUrlBlock = block;
//    qrVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:qrVC animated:YES];
//    }
//    }
    func validateCamera() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) && UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)
    }
    
    func canUseCamera() -> Bool {
        let mediaType = AVMediaTypeVideo
        var authStatus = AVCaptureDevice.authorizationStatusForMediaType(mediaType);
        if (authStatus == AVAuthorizationStatus.Restricted || authStatus == AVAuthorizationStatus.Denied) {
//            var block = MMPopupItemHandler(index: NSInteger) -> Void{
//                
//            }
//            MMAlertView.init(title: "", detail: "\n请在设备的设置-隐私-相机中允许访问相机", items: [MMItemMake("设置", MMItemType.Normal, block), MMItemMake("取消", MMItemType.Highlight, block)]).showWithBlock(nil);
            return false;
        }
        return true;
    }
    
//    -(BOOL)canUseCamera
//    {
//    NSString *mediaType = AVMediaTypeVideo;
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
//    MMPopupItemHandler block = ^(NSInteger index){
//    switch (index) {
//    case 0:
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    break;
//    case 1:
//    NSLog(@"取消");
//    default:
//    break;
//    }
//    };
//    [[[MMAlertView alloc] initWithTitle:@"" detail:@"\n请在设备的设置-隐私-相机中允许访问相机" items:@[MMItemMake(@"设置", MMItemTypeNormal, block), MMItemMake(@"取消", MMItemTypeHighlight, block)]] showWithBlock:nil];
//    return NO;
//    }
//    return YES;
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
