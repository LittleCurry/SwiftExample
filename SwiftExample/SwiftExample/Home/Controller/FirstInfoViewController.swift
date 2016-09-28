//
//  FirstInfoViewController.swift
//  SwiftTableView
//
//  Created by 李云鹏 on 16/9/12.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstInfoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    // 这是写属性的地方
    var nameArr = ["zhangsan", "abc", "nihao", "yidadui", "aasd", "qwe", "asd", "eqw", "eeasqad", "zzz", "mdzz", "nczz", "n", "nss", "snzd","zhangsan", "abc", "nihao", "yidadui", "aasd", "qwe", "asd", "eqw", "eeasqad", "zzz", "mdzz", "nczz", "n", "nss", "snzd","zhangsan", "abc", "nihao", "yidadui", "aasd", "qwe", "asd", "eqw", "eeasqad", "zzz", "mdzz", "nczz", "n", "nss", "snzd"];
    var yourTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Grouped);
    var changing = false;// 是否出现了navigationBar
    let headView = UIImageView.init(frame: CGRectMake(0, 0, WIDTH, 230));//头图
    var headLoadImage = UIImage.init();//头图的图片
    var headImageArr : NSMutableArray = [];//头图的gauss图片数组
    var gaussImage = UIImage.init();//gauss头图
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupNav();
        self.getView();
    }
    func setupNav() -> Void {
        self.navigationItem.title = "FirstInfo";
    }
    func getView() -> Void {
        // 在group形式下的tableView会在最上边默认35的groupTableViewBackgroundColor色的条,在最下边会有20的灰条
        yourTableView.contentInset = UIEdgeInsetsMake(-35, 0, -20, 0);
        yourTableView.tableFooterView = UIView.init();
        yourTableView.delegate = self;
        yourTableView.dataSource = self;
        self.view.addSubview(yourTableView);
        /**
         * ????
         */
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), forBarMetrics: UIBarMetrics.Default);
//        self.navigationController?.navigationBar.shadowImage = UIImage.init();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if !self.changing {
            self.navigationController!.navigationBar.setBackgroundImage(UIImage.init(named:"bigShadow.png"), forBarMetrics: UIBarMetrics.Compact);
            self.navigationController!.navigationBar.layer.masksToBounds = true;
        }
        if self.changing {
            self.navigationController!.navigationBar.setBackgroundImage(self.gaussImage, forBarMetrics: UIBarMetrics.Default);
            self.navigationController!.navigationBar.layer.masksToBounds = false;
            self.yourTableView.contentOffset = CGPointMake(0, self.yourTableView.contentOffset.y+64)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: ""), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage.init(named:""), forBarMetrics: UIBarMetrics.Compact)
        self.navigationController!.navigationBar.layer.masksToBounds = false;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        self.headView.sd_setImageWithURL("http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/01/0E/ChMkJlbKwYmIXMrsAAkXbwebUWwAALGZwCk6UMACReH880.jpg", placeholderImage: nil) { (loadedImage, nil, SDImageCacheTypeDisk, imageUrl) in
            
//            struct abcde {
//                static var onceToken : dispatch_once_t = 0
//            }
//            dispatch_once(&abcde.onceToken) {
//                // 只执行一次的代码, 把下载好的图片先高斯模糊几张, 存起来, 留着在滑动的时候动态改变, 做出渐变效果, swift里是这样使用的
//            }
            
            self.headLoadImage = loadedImage;
            // 将下载好的image, 做几张高斯模糊的图片保存备用
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), {
                //这里写需要放到子线程做的耗时的代码
                if(self.headImageArr.count<1){
                    self.headImageArr.addObject(loadedImage);
                    for i in 1...8{
                        let aImage = loadedImage.applyLightEffectWithValue(0.1*CGFloat(i));
                        self.headImageArr.addObject(aImage);
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    //这里返回主线程，写需要主线程执行的代码
                })
            })
            // 将下载好的图片截取最下边的width*64(再乘图片宽/屏幕宽,可以看成比例尺)部分
            var subImage = loadedImage.subImageInRect(CGRectMake(0,loadedImage.size.height-loadedImage.size.height*64/230.0, loadedImage.size.width, loadedImage.size.height*64/230.0));
            // 将截取后的图片缩放到width*64的尺寸
            subImage = subImage.scaleToSize(CGSizeMake(WIDTH, 64));
            // gauss模糊
            self.gaussImage = subImage.applyLightEffectWithValue((230.0-64)/(230.0+35-64));
        }
        return self.headView;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellName = "qweqweqweqwevfsdwwqqwe";
        var cell = tableView.dequeueReusableCellWithIdentifier(cellName);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellName)
        }
        cell!.textLabel!.text = nameArr[indexPath.row];
        return cell!;
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(self.yourTableView.contentOffset.y);
        if (self.yourTableView.contentOffset.y>230+35-64){
            if !self.changing {
                self.changing = true;
                self.navigationController?.navigationBar
                self.navigationController!.navigationBar.setBackgroundImage(self.gaussImage, forBarMetrics: UIBarMetrics.Default);
                self.navigationController!.navigationBar.layer.masksToBounds = false;
            }
        }else{
            let a = Int(10*(self.yourTableView.contentOffset.y-35)/(230.0+35-64));
            print(a)
            if (a>=0 && a <= 8) {
                if (self.headImageArr.count>a) {
                    self.headView.image = self.headImageArr[a] as? UIImage;
                }
            }
            if ((self.navigationController) != nil) {
                self.changing = false;
                self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: ""), forBarMetrics: UIBarMetrics.Default);
                self.navigationController!.navigationBar.setBackgroundImage(UIImage.init(named:"bigShadow.png"), forBarMetrics: UIBarMetrics.Compact);
                self.navigationController!.navigationBar.layer.masksToBounds = true;
            }
        }
        self.changSelfViewToTop();
    }
    
    func changSelfViewToTop() -> Void {
        if (self.navigationController != nil && self.view != nil) {
            if (Y(self.view) == navigationBar_H(self.navigationController!)) {
                self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
