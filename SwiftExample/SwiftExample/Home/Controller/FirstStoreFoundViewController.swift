//
//  FirstStoreFoundViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/17.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstStoreFoundViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sectionArr : NSMutableArray = []
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.grouped);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView()
        self.getData()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "发现"
        myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        myTableView.delegate = self;
        myTableView.dataSource = self
        view.addSubview(myTableView);
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionArr.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = self.sectionArr[section] as! NSArray
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = "qweqweqwe";
        var cell = tableView.dequeueReusableCell(withIdentifier: cellName);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: cellName)
        }
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        let arr = self.sectionArr[indexPath.section] as! NSArray
        let dic = arr[indexPath.row] as! NSDictionary
        cell?.imageView?.image = UIImage.init(named: dic["img"] as! String)
        if dic["img"] as! String == "scan.png" {
            cell?.imageView?.image = UIImage.init(named: dic["img"] as! String)?.change(with: UIColor.darkGray)
        }
        cell?.textLabel?.font = WORDFONT
        cell?.textLabel?.text = dic["title"] as? String
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        cell?.detailTextLabel?.text = dic["detail"] as? String
        return cell!;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let storeCarVC = FirstStoreCarViewController.init();
                storeCarVC.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(storeCarVC, animated: true);
            }
            break
        case 1:
            if indexPath.row == 0 {
                let storeDifferentVC = FirstStoreDifferentClassViewController.init();
                storeDifferentVC.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(storeDifferentVC, animated: true);
            }
            break
        case 2:
            if indexPath.row == 0 {
                self.scanAction()
            }
            if indexPath.row == 1 {
                let shakeVC = FirstShakeAndShakeViewController.init();
                shakeVC.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(shakeVC, animated: true);
            }
            if indexPath.row == 2 {
                self.scanAction()
            }
            break
            
        default:
            break
        }
    }
    
    func scanAction() {
        if (validateCamera() && canUseCamera()) {
            let qrVC = QRViewController.init();
            qrVC.qrUrlBlock = { (resultUrl)  in
                MMAlertView.init(confirmTitle: "扫描结果:", detail: resultUrl).show(nil);
            }
            qrVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(qrVC, animated: true)
        }
    }
    
    func getData() {
        self.sectionArr.add([["img":"list.png", "title":"故事", "detail":"618的京东人"]])
        self.sectionArr.add([["img":"stroll.png", "title":"逛逛", "detail":"逛出精彩"]])
        self.sectionArr.add([["img":"scan.png", "title":"扫一扫", "detail":""], ["img":"shake.png", "title":"摇一摇", "detail":""], ["img":"camera.png", "title":"拍照购", "detail":""]])
        self.sectionArr.add([["img":"women.png", "title":"小冰", "detail":"人工智能萌妹子"], ["img":"chest.png", "title":"百宝箱", "detail":""]])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
