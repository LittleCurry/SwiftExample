//
//  FirstStoreViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/17.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstStoreHomeViewController: BaseViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate {
    
    var normalImages:NSMutableArray = [];// gif图片
    var refreshImages:NSMutableArray = [];// gif图片
    var searchBar = UISearchBar.init(frame: CGRectMake(0, 307, 240, 30))
    var nameArr = ["navigationBar使用背景图片", "输入框随键盘一起动"];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Grouped);
    let cellName1 = "asdaserad324";
    let cellName2 = "r90asdferwuuf";
    let cellName3 = "aschasdfd78ads";
    let cellName4 = "asdfhasfda98";
    let cellName5 = "adf8ahasdf9waafe";
    let cellName6 = "qwe3cd23ssasdsassasqwe";
    var adUrlArr:NSMutableArray = []
    var wordArr:NSMutableArray = []
    var cycleScrollView: SDCycleScrollView?
    
    var loadAvataView:RCDraggableButton?;// 拖动按钮
    var topBtn:UIButton?;// 回到顶部
    var lastContentOffset:CGFloat = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = ""
        
        // 修复侧滑回退功能消失的问题
        // self.navigationController!.interactivePopGestureRecognizer!.enabled = true
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
        self.myTableView.contentInset = UIEdgeInsetsMake(-35, 0, 49-20-20, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.registerClass(StoreHomeTableViewCell1.self, forCellReuseIdentifier: self.cellName1)
        self.myTableView.registerClass(StoreHomeTableViewCell2.self, forCellReuseIdentifier: self.cellName2)
        self.myTableView.registerClass(StoreHomeTableViewCell3.self, forCellReuseIdentifier: self.cellName3)
        self.myTableView.registerClass(StoreHomeTableViewCell4.self, forCellReuseIdentifier: self.cellName4)
        self.myTableView.registerClass(StoreHomeTableViewCell5.self, forCellReuseIdentifier: self.cellName5)
        self.myTableView.registerClass(StoreHomeTableViewCell6.self, forCellReuseIdentifier: self.cellName6)
        let header = MJRefreshGifHeader.init(refreshingBlock: {
//            self.count = 0;
//            self.getData();
        });
        header.setImages(self.normalImages as [AnyObject], forState: MJRefreshState.Refreshing);
        header.setImages(self.refreshImages as [AnyObject], forState: MJRefreshState.Idle);
        header.setImages(self.normalImages as [AnyObject], forState: MJRefreshState.Pulling);
        header.lastUpdatedTimeLabel.hidden = true;
        header.stateLabel.hidden = true;
//        self.myTableView.mj_header = header;
        
        let footer = MJRefreshAutoNormalFooter.init {
//            self.count += 10;
//            self.getData();
        };
//        self.myTableView.mj_footer = footer;
        self.view.addSubview(self.myTableView);
        
        self.topBtn = UIButton.init(type: .Custom)
        self.topBtn?.frame = CGRectMake(WIDTH-60, HEIGHT-60, 40, 40)
        self.topBtn?.setBackgroundImage(UIImage.init(named: "goTop.png"), forState: UIControlState.Normal)
        self.topBtn?.addTarget(self, action: "goTop", forControlEvents: UIControlEvents.TouchUpInside)
        self.topBtn?.hidden = true
        self.view.addSubview(self.topBtn!)
        self.loadAvataView = RCDraggableButton.init(inKeyWindowWithFrame: CGRectMake(0, 333.5, 60, 60))
        self.loadAvataView!.setBackgroundImage(UIImage.init(named: "stopAir.png"), forState: UIControlState.Normal)
        self.loadAvataView?.longPressBlock = { (avatar) in
            print("longPressBlock")
        }
//        self.loadAvataView!.adjustsImageWhenHighlighted = false // 高亮图变色
     
        self.adUrlArr.addObject(NSURL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1402/221/421883372/88115/8cc2231a/55815835N35a44559.jpg")!)
        self.adUrlArr.addObject(NSURL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t976/208/1221678737/91179/5d7143d5/5588e849Na2c20c1a.jpg")!)
        self.adUrlArr.addObject(NSURL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t805/241/1199341035/289354/8648fe55/5581211eN7a2ebb8a.jpg")!)
        self.adUrlArr.addObject(NSURL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1606/199/444346922/48930/355f9ef/55841cd0N92d9fa7c.jpg")!)
        self.adUrlArr.addObject(NSURL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1609/58/409100493/49144/7055bec5/557e76bfNc065aeaf.jpg")!)
        self.cycleScrollView = SDCycleScrollView.init(frame: CGRectMake(0, 64, WIDTH, 180), imageURLsGroup: self.adUrlArr as [AnyObject])
        self.cycleScrollView!.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        self.cycleScrollView!.delegate = self;
        self.cycleScrollView!.autoScrollTimeInterval = 3.5;
        self.cycleScrollView!.dotColor = UIColor.whiteColor();
        self.cycleScrollView!.pageControlDotSize = CGSizeMake(4, 4);
        self.cycleScrollView!.titleLabelBackgroundColor = RGBA(121, g: 121, b: 121, a: 0.2);
        self.cycleScrollView!.titleLabelTextColor = UIColor.yellowColor();
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        NSLog("---点击了第%ld张图片", index);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
        self.navigationController!.navigationBar.setBackgroundImage(UIImage.init(named:"bigShadow.png"), forBarMetrics: UIBarMetrics.Compact);
        self.navigationController!.navigationBar.layer.masksToBounds = true;
        
        self.loadAvataView!.hidden = false;
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: ""), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage.init(named:""), forBarMetrics: UIBarMetrics.Compact)
        self.navigationController!.navigationBar.layer.masksToBounds = false;
        
        self.loadAvataView!.hidden = true;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 180
        }
        return 0.1
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return self.cycleScrollView
        }
        return UIView.init()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 220
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            return 180
        }
        return 150*3+110;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            var cell:StoreHomeTableViewCell1 = tableView.dequeueReusableCellWithIdentifier(self.cellName1, forIndexPath: indexPath) as! StoreHomeTableViewCell1
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell1.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName1)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            break
        case 1:
            var cell:StoreHomeTableViewCell2 = tableView.dequeueReusableCellWithIdentifier(self.cellName2, forIndexPath: indexPath) as! StoreHomeTableViewCell2
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell2.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName2)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            break
        case 2:
            var cell:StoreHomeTableViewCell3 = tableView.dequeueReusableCellWithIdentifier(self.cellName3, forIndexPath: indexPath) as! StoreHomeTableViewCell3
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell3.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName3)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            break
        case 3:
            var cell:StoreHomeTableViewCell4 = tableView.dequeueReusableCellWithIdentifier(self.cellName4, forIndexPath: indexPath) as! StoreHomeTableViewCell4
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell4.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName4)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            break
        case 4:
            var cell:StoreHomeTableViewCell5 = tableView.dequeueReusableCellWithIdentifier(self.cellName5, forIndexPath: indexPath) as! StoreHomeTableViewCell5
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell5.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName5)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            break
        case 5:
            var cell:StoreHomeTableViewCell6 = tableView.dequeueReusableCellWithIdentifier(self.cellName6, forIndexPath: indexPath) as! StoreHomeTableViewCell6
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell6.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName6)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            break
        default:
            break
        }
        return UITableViewCell.init()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func scanAction() -> Void {
        //
    }
    
    func messageAction() -> Void {
        //
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event);
        self.searchBar.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < lastContentOffset ){
            //向上
            self.topBtn!.hidden = true;
        }else if(scrollView.contentOffset.y > lastContentOffset){
            //向下
            self.topBtn!.hidden = false;
        }
    }
    
    func goTop() -> Void {
        self.myTableView.setContentOffset(CGPointMake(0, 35), animated: true)
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
