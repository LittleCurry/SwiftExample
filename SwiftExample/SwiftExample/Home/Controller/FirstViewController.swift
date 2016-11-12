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
    var nameArr = ["navigationBar渐变", "聊天界面", "gauss模糊", "Share", "Map", "二维码", "视频播放", "block", "天气", "清除缓存", "日期选择", "我的银行卡", "本地相册选取", "轮播图", "热更新", "弹幕", "日历", "商城首页", "商城分类", "商城发现", "商城购物车", "商城我的", "请输入密码", "圆形菜单", "球形标签", "推荐影片", "渐隐文字", "打印文字", "拼图", "2048", "浏览卡片", "抽卡效果", "抖动菜单", "渐变色", "折卡效果", "卡牌拖动", "摇一摇", "ape展开", "余额跳动", "水平滚动布局", "发散菜单", "漂浮的雪花", "水波"];
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.plain);
    var clearLabel = UILabel.init(frame: CGRect(x: WIDTH-115, y: 450, width: 100, height: 50))
    
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
        self.clearLabel.textAlignment = NSTextAlignment.right
        self.clearLabel.textColor = UIColor.red
        self.clearLabel.font = UIFont.systemFont(ofSize: 14)
        self.clearLabel.text = String(format: "%.2fM", SDImageCache.shared().checkTmpSize())
        self.myTableView.addSubview(self.clearLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearLabel.text = String(format: "%.2fM", SDImageCache.shared().checkTmpSize())
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = "qweeqwqghghggnklhlhwdaeqwe";
        var cell = tableView.dequeueReusableCell(withIdentifier: cellName);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellName)
        }
        cell!.textLabel?.text = self.nameArr[indexPath.row];
        return cell!;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            UIApplication.shared.keyWindow!.addSubview(hud!)
            hud?.labelFont = UIFont.systemFont(ofSize: 15);
            hud?.labelText = "清理中...";
            hud?.show(true)
            SDImageCache.shared().clearDisk(onCompletion: {
                self.clearLabel.text = String(format: "%.2fM", SDImageCache.shared().checkTmpSize())
                sleep(1)
                hud?.removeFromSuperview()
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
//            let menuVC = YFHalfCircleLayoutViewController.init();
//            menuVC.hidesBottomBarWhenPushed = true;
//            self.navigationController?.pushViewController(menuVC, animated: true);
            let halfCircleStoryBoard = UIStoryboard.init(name: "YFHalfCircleLayoutViewController", bundle: nil)
            var halfCircleVC  = halfCircleStoryBoard.instantiateInitialViewController()
            if halfCircleVC == nil {
                halfCircleVC = halfCircleStoryBoard.instantiateViewController(withIdentifier: "YFHalfCircleLayoutViewController")
            }
            halfCircleVC!.navigationItem.title = "圆形菜单"
            halfCircleVC!.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(halfCircleVC!, animated: true);
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
            
            let rgCardStoryBoard = UIStoryboard.init(name: "RGCardLayoutViewController", bundle: nil)
            var rgCardVC  = rgCardStoryBoard.instantiateInitialViewController()
            if rgCardVC == nil {
                rgCardVC = rgCardStoryBoard.instantiateViewController(withIdentifier: "RGCardLayoutViewController")
            }
            rgCardVC!.title = "浏览卡片"
            rgCardVC!.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(rgCardVC!, animated: true);
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
        case 34:
            let foldVC = FirstFoldCardViewController.init();
            foldVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(foldVC, animated: true);
            break;
        case 35:
            let dragVC = YFDraggableCardViewController.init();
            dragVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(dragVC, animated: true);
            break;
        case 36:
            let shakeVC = FirstShakeAndShakeViewController.init();
            shakeVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(shakeVC, animated: true);
            break;
        case 37:
            let apeVC = FirstApeOpenViewController.init();
            apeVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(apeVC, animated: true);
            break;
        case 38:
            let balanceVC = FirstBalanceJumpViewController.init();
            balanceVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(balanceVC, animated: true);
            break;
        case 39:
            let horizontalVC = YFHorizontalScrollViewController.init();
            horizontalVC.navigationItem.title = "水平滚动布局"
            horizontalVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(horizontalVC, animated: true);
            break;
        case 40:
            let radiateVC = FirstRadiateMenuViewController.init();
            radiateVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(radiateVC, animated: true);
            break;
        case 41:
            let snowVC = FirstSnowViewController.init();
            snowVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(snowVC, animated: true);
            break;
        case 42:
            let circleWaveVC = FirstCircleWaveViewController.init();
            circleWaveVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(circleWaveVC, animated: true);
            break;            
            
        default:
            break;
        }
    }
    
    func scanAction() -> Void {
        if (validateCamera() && canUseCamera()) {
            let qrVC = QRViewController.init();
            qrVC.qrUrlBlock = { (resultUrl)  in
                MMAlertView.init(confirmTitle: "扫描结果:", detail: resultUrl).show(nil);
            }
//            let block = { (resultUrl)  in
//                MMAlertView.init(confirmTitle: "扫描结果:", detail: resultUrl).show(nil);
//            }
//            qrVC.qrUrlBlock = block
            qrVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(qrVC, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
