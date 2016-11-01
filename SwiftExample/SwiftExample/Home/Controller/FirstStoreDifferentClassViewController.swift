//
//  FirstStoreDifferentClassViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/17.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstStoreDifferentClassViewController: BaseViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var searchBar = UISearchBar.init(frame: CGRectMake(0, 307, 240, 30))
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, 100, HEIGHT), style: UITableViewStyle.Grouped)
    let cellName = "asdaseasdlllccrad324";
    var selectRow = 0
    var goodsClassArr = ["推荐分类", "潮流女装","品牌男装" ,"个护化妆" ,"家用电器" ,"电脑办公" ,"手机数码" ,"母婴童装" ,"图书音像" ,"家居家纺" ,"居家生活" ,"家具建材" ,"食品生鲜" ,"酒水饮料" ,"运动户外" ,"鞋靴箱包" ,"奢品礼品" ,"钟表珠宝" ,"玩具乐器" ,"内衣配饰" ,"汽车用品" ,"医药保健" ,"计生情趣" ,"京东金融" ,"生活旅行" ,"宠物农资"]
    
    var playArr : NSMutableArray = [];
    var playReuseIdentifier = "PlayCell";
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "商城分类"
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "navigationBar_bg"), forBarMetrics: UIBarMetrics.Compact)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "scan.png"), style: UIBarButtonItemStyle.Done, target: self, action: "scanAction")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "message.png"), style: UIBarButtonItemStyle.Done, target: self, action: "messageAction")
        self.searchBar.placeholder = "搜索商铺/店铺"
        for subView:UIView in self.searchBar.subviews {
            for grandSonView:UIView in subView.subviews {
                if grandSonView.isKindOfClass(NSClassFromString("UISearchBarBackground")!) {
                    grandSonView.alpha = 0
                }
            }
        }
        self.navigationItem.titleView = self.searchBar
        self.myTableView.contentInset = UIEdgeInsetsMake(64-35, 0, -20, 0);
//        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
//        self.myTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellName)
        self.view.addSubview(self.myTableView);
        
        //???????
        let layout = HMWaterflowLayout.init();
        layout.HeightBlock = { (sender, index) -> (CGFloat) in
            let photo = self.playArr[index.item] as!Play;
            return photo.small_height / photo.small_width * sender;
        }
        layout.columnsCount = 2;
        
        
        self.collectionView = UICollectionView.init(frame: CGRectMake(100, 0, WIDTH-100, HEIGHT), collectionViewLayout: layout);
        self.collectionView.backgroundColor = RGBA(239, g: 239, b: 244, a: 1);
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.contentInset = UIEdgeInsetsMake(navigationBar_H(self.navigationController!), 0, tabBar_H(self.tabBarController!), 0);
        self.collectionView.registerClass(PlayCollectionViewCell.self, forCellWithReuseIdentifier: playReuseIdentifier);
        
//        let header = MJRefreshGifHeader.init(refreshingBlock: {
//            self.pn = 0;
//            self.getData();
//        });
//        header.setImages(self.normalImages as [AnyObject], forState: MJRefreshState.Refreshing);
//        header.setImages(self.refreshImages as [AnyObject], forState: MJRefreshState.Idle);
//        header.setImages(self.normalImages as [AnyObject], forState: MJRefreshState.Pulling);
//        header.lastUpdatedTimeLabel.hidden = true;
//        header.stateLabel.hidden = true;
//        self.collectionView.mj_header = header;
        
//        let footer = MJRefreshAutoNormalFooter.init {
//            self.pn += 60;
//            self.getData();
//        };
//        self.collectionView.mj_footer = footer;
        self.view.addSubview(self.collectionView);
        
        
        
        
    }
    
    func scanAction() -> Void {
        //
    }
    
    func messageAction() -> Void {
        //
    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.1
//    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0 {
//            return self.cycleScrollView
//        }
//        return UIView.init()
//    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44;
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goodsClassArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellName, forIndexPath: indexPath) as! UITableViewCell
        if (cell.isEqual(nil)) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName)
        }
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel!.textColor = UIColor.blackColor()
        cell.textLabel?.font = UIFont.systemFontOfSize(14)
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.text = self.goodsClassArr[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if indexPath.row == self.selectRow {
            cell.textLabel?.textColor = UIColor.redColor()
            cell.backgroundColor = UIColor.groupTableViewBackgroundColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectRow = indexPath.row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        cell?.textLabel?.textColor = UIColor.redColor()
        self.myTableView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.playArr.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(playReuseIdentifier, forIndexPath: indexPath) as! PlayCollectionViewCell
        cell.play = self.playArr[indexPath.item] as?Play;
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
