//
//  ThirdViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/8.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit
import MediaPlayer

class ThirdViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var normalImages:NSMutableArray = [];// gif图片
    var refreshImages:NSMutableArray = [];// gif图片
    var videoArr : NSMutableArray = [];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Grouped);
    let cellName = "qweqweasdasasad123ssasdsassasqwe";
    var count = 0;
    var player : MPMoviePlayerController?
    var currtRow = 0;
    var loadImage = UIImageView.init()
    var textTypeArr = ["奇葩", "萌宠", "美女", "精品"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView();
        self.getData();
    }
    
    func getView() -> Void {
        self.navigationItem.title = "视频"
        
        for i in 1...6 {
            // normalhImages
            let image = UIImage.init(named: String.init(format:"%ld.tiff", i));
            self.normalImages.addObject(image!);
        }
        for i in 7...47 {
            // refreshImages
            let image = UIImage.init(named: String(i)+".tiff");
            self.refreshImages.addObject(image!);
        }
        self.myTableView.contentInset = UIEdgeInsetsMake(64-35, 0, 49-20-20, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.registerClass(MovieTableViewCell.self, forCellReuseIdentifier: self.cellName)
        let header = MJRefreshGifHeader.init(refreshingBlock: {
            self.count = 0;
            self.getData();
        });
        header.setImages(self.normalImages as [AnyObject], forState: MJRefreshState.Refreshing);
        header.setImages(self.refreshImages as [AnyObject], forState: MJRefreshState.Idle);
        header.setImages(self.normalImages as [AnyObject], forState: MJRefreshState.Pulling);
        header.lastUpdatedTimeLabel.hidden = true;
        header.stateLabel.hidden = true;
        self.myTableView.mj_header = header;
        
        let footer = MJRefreshAutoNormalFooter.init {
            self.count += 10;
            self.getData();
        };
        self.myTableView.mj_footer = footer;
        self.view.addSubview(self.myTableView);
        self.loadImage.image = UIImage.init(named: "loading.png")
        self.myTableView.addSubview(self.loadImage)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArr.count;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRectMake(0, 0, WIDTH
            , WIDTH/4))
        var imageTypeArr = ["design.png", "pet.png", "circleGirl.png", "furniture.png"]
        
        for i in 0...3 {
            let aButtonView = UIButton.init(type: UIButtonType.System)
            aButtonView.frame = CGRectMake(CGFloat(i)*WIDTH/4.0, 0, (WIDTH-3)/4, WIDTH/4)
            aButtonView.backgroundColor = UIColor.whiteColor()
            aButtonView.addTarget(self, action: "typeAction:", forControlEvents: UIControlEvents.TouchUpInside)
            aButtonView.tag = i+456;
            headerView.addSubview(aButtonView)
            let aImageView = UIImageView.init(frame: CGRectMake(WIDTH/16, 10, WIDTH/8, WIDTH/8))
            aImageView.image = UIImage.init(named: imageTypeArr[i])
            aButtonView.addSubview(aImageView)
            let aLabel = UILabel.init(frame: CGRectMake(0, WIDTH/4-25, WIDTH/4, 20))
            aLabel.textAlignment = NSTextAlignment.Center
            aLabel.text = self.textTypeArr[i]
            aButtonView.addSubview(aLabel)
        }
        return headerView;
    }
    
    func typeAction(button:UIButton) -> Void {
        //
        let typeVC = ThirdOneTypeViewController.init()
        typeVC.hidesBottomBarWhenPushed = true
        typeVC.movieType = button.tag-456
        print(typeVC.movieType)
        self.navigationController?.pushViewController(typeVC, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return WIDTH/4+10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:MovieTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellName, forIndexPath: indexPath) as! MovieTableViewCell
        if (cell.isEqual(nil)) {
            cell = MovieTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName)
        }
        cell.video = self.videoArr[indexPath.item] as?Video;
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let video = self.videoArr[indexPath.row] as! Video;
        if (self.player != nil) {
            self.player!.view.removeFromSuperview()
        }
        self.currtRow = indexPath.row;
        self.player = MPMoviePlayerController.init()
        self.player!.contentURL = NSURL.init(string: video.mp4_url)
        self.player!.view.frame = CGRectMake(0,CGFloat(indexPath.row*300)+WIDTH/4+10+40+35, WIDTH, 210);
//        self.player!.controlStyle = MPMovieControlStyle.None;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "movieDidFinish", name: MPMoviePlayerPlaybackDidFinishNotification, object: self.player)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "movieStateDidChange", name: MPMoviePlayerPlaybackStateDidChangeNotification, object: self.player)
        //        [self setupLoadingView];
        self.myTableView.addSubview(self.player!.view)
        self.player!.play()
        self.loadImage.frame = CGRectMake(WIDTH/2-30, CGFloat(indexPath.row*300)+WIDTH/4+10+40+35+105-30, 60, 60)
        self.myTableView.bringSubviewToFront(self.loadImage)
        self.startLoading()
    }
    
    func movieDidFinish() -> Void {
        self.player!.view.removeFromSuperview()
    }
    
    func movieStateDidChange() -> Void {
        if (self.player!.playbackState == MPMoviePlaybackState.Playing) {
//            self.circleLoadingV.stopAnimating()
            print("开始了")
            self.endLoading()
        }
    }
    func startLoading() -> Void {
        // 手动添加动画
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = M_PI * 2.0
        rotationAnimation.duration = 1
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = 99999
        self.loadImage.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }
    func endLoading() -> Void {
        //
        self.loadImage.layer.removeAllAnimations()
        self.myTableView.sendSubviewToBack(self.loadImage)
    }
    
    func getData() -> Void {
        
        let urlstr = "http://c.m.163.com/nc/video/home/" + String(self.count) + "-10.html";
        NetHandler.getDataWithUrl(urlstr, parameters: nil, tokenKey: "", tokenValue: "", ifCaches: false, cachesData: { (cacheData) in
            //
            }, success: { (successData) in
                let dict = try! NSJSONSerialization.JSONObjectWithData(successData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let dataArr = dict["videoList"] as! NSMutableArray;
                print(dataArr)
                if(self.count == 0){
                    self.videoArr.removeAllObjects();
                }
                for oneDic in dataArr {
                    let video = Video.objectWithDictionary(oneDic as! [String : AnyObject]) as? Video
                    self.videoArr.addObject(video!);
                }
                self.myTableView.reloadData();
                
                self.myTableView.mj_header.endRefreshing();
                self.myTableView.mj_footer.endRefreshing();
                if(dataArr.count < 10){
                    self.myTableView.mj_footer.endRefreshingWithNoMoreData();
                }
            }, failure: { (failData) in
                self.myTableView.mj_header.endRefreshing();
                self.myTableView.mj_footer.endRefreshing();
        })
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
        if ((self.player) != nil) {
            NSLog("销毁了");
            self.player!.view.removeFromSuperview()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
