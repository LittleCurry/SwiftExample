//
//  FirstStoreDifferentClassViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/17.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstStoreDifferentClassViewController: BaseViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var searchBar = UISearchBar.init(frame: CGRectMake(0, 307, 240, 30))
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, 100, HEIGHT), style: UITableViewStyle.Grouped)
    let cellName = "asdaseasdlllccrad324";
    var selectRow = 0
    var goodsClassArr = ["推荐分类", "潮流女装","品牌男装" ,"个护化妆" ,"家用电器" ,"电脑办公" ,"手机数码" ,"母婴童装" ,"图书音像" ,"家居家纺" ,"居家生活" ,"家具建材" ,"食品生鲜" ,"酒水饮料" ,"运动户外" ,"鞋靴箱包" ,"奢品礼品" ,"钟表珠宝" ,"玩具乐器" ,"内衣配饰" ,"汽车用品" ,"医药保健" ,"计生情趣" ,"京东金融" ,"生活旅行" ,"宠物农资"]
    var oneGoodsClassArr : NSMutableArray = []
    var playArr : NSMutableArray = [];
    var oneGoodsReuseIdentifier = "OneGoodsCell";
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
        self.getData()
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
//        let layout = HMWaterflowLayout.init();
//        layout.HeightBlock = { (sender, index) -> (CGFloat) in
//            let photo = self.playArr[index.item] as!Play;
//            return photo.small_height / photo.small_width * sender;
//        }
//        layout.columnsCount = 3;
        let flow = UICollectionViewFlowLayout.init()
        flow.itemSize = CGSizeMake((WIDTH-110)/3, 200)
        
//        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        
        self.collectionView = UICollectionView.init(frame: CGRectMake(100, 0, WIDTH-100, HEIGHT), collectionViewLayout: flow);
        self.collectionView.backgroundColor = RGBA(239, g: 239, b: 244, a: 1);
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.contentInset = UIEdgeInsetsMake(navigationBar_H(self.navigationController!), 0, tabBar_H(self.tabBarController!), 0);
        self.collectionView.registerClass(OneGoodsClassCollectionViewCell.self, forCellWithReuseIdentifier: self.oneGoodsReuseIdentifier);
        
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
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        <#code#>
//    }
    viewForHeader
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        <#code#>
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.oneGoodsClassArr.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dict = self.oneGoodsClassArr[section] as! NSDictionary
        let arr = dict["arr"] as! NSArray
        return arr.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.oneGoodsReuseIdentifier, forIndexPath: indexPath) as! OneGoodsClassCollectionViewCell
        let dict = self.oneGoodsClassArr[indexPath.section] as! NSDictionary
        let arr =  dict["arr"] as! NSArray
        let dic = arr[indexPath.item] as! NSDictionary
        let imageName = dic["img"] as! String
        
        cell.titleLabel?.text = dic["name"] as? String
        
        cell.photoImage?.image = UIImage.init(named: imageName)
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        //
//    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        //
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        //
        return 2
    }
 
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsetsMake(2.0, 0.0, 2.0, 0.0);
    }
    
    
    
//    - (CGSize) collectionView:(UICollectionView *)collectionView
//    　　layout:(UICollectionViewLayout *)collectionViewLayout
//    　　sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//    　　return CGSizeMake(104.0f, 104.0f);
//    }
//    - (CGFloat) collectionView:(UICollectionView *)collectionView
//    layout:(UICollectionViewLayout *)collectionViewLayout
//    minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//    {
//    return 2.0f;
//    }
//    - (CGFloat) collectionView:(UICollectionView *)collectionView
//    layout:(UICollectionViewLayout *)collectionViewLayout
//    minimumLineSpacingForSectionAtIndex:(NSInteger)section
//    {
//    return 2.0f;
//    }
//    - (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
//    layout:(UICollectionViewLayout *)collectionViewLayout
//    insetForSectionAtIndex:(NSInteger)section
//    {
//    return UIEdgeInsetsMake(2.0f, 0.0f, 2.0f, 0.0f);
//    }
    
    func getData() -> Void {
        
        self.oneGoodsClassArr = [
            ["headerTitle":"数码电器", "arr":[["img":"goods1.jpg", "name":"U盘"], ["img":"goods2.jpg", "name":"虚拟现实"], ["img":"goods3.jpg", "name":"掌上电脑"], ["img":"goods4.jpg", "name":"智能手表"], ["img":"goods5.jpg", "name":"单反"], ["img":"goods6.jpg", "name":"耳机耳麦"], ["img":"goods7.jpg", "name":"摄像头"], ["img":"goods8.jpg", "name":"读卡器"]]],
            ["headerTitle":"鞋子", "arr":[["img":"goods31.jpg", "name":"透气网鞋"], ["img":"goods32.jpg", "name":"旅游鞋"], ["img":"goods33.jpg", "name":"运动鞋"], ["img":"goods34.jpg", "name":"超轻跑鞋"], ["img":"goods35.jpg", "name":"黑曼巴"], ["img":"goods36.jpg", "name":"内置增高"], ["img":"goods37.jpg", "name":"篮球鞋"], ["img":"goods1.jpg", "name":"经典战靴"], ["img":"goods39.jpg", "name":"安踏"], ["img":"goods40.jpg", "name":"耐克"], ["img":"goods41.jpg", "name":"皮鞋"]]],
            ["headerTitle":"服装", "arr":[["img":"goods61.jpg", "name":"李宁"], ["img":"goods62.jpg", "name":"Kappa"], ["img":"goods63.jpg", "name":"361°"], ["img":"goods64.jpg", "name":"连衣裙"], ["img":"goods65.jpg", "name":"运动服"], ["img":"goods66.jpg", "name":"短袖"], ["img":"goods67.jpg", "name":"美国队长"], ["img":"goods68.jpg", "name":"秋冬新款"], ["img":"goods69.jpg", "name":"Adidas"], ["img":"goods70.jpg", "name":"Polo衫"]]],
            ["headerTitle":"零食", "arr":[["img":"goods91.jpg", "name":"大枣"], ["img":"goods92.jpg", "name":"饼干"], ["img":"goods93.jpg", "name":"薯片"], ["img":"goods94.jpg", "name":"糖果"], ["img":"goods95.jpg", "name":"cookie"], ["img":"goods96.jpg", "name":"爆米花"], ["img":"goods97.jpg", "name":"田园薯片"], ["img":"goods98.jpg", "name":"乡巴佬"], ["img":"goods99.jpg", "name":"酥卷"]]],
            ["headerTitle":"生活日用", "arr":[["img":"goods86.jpg", "name":"休闲服装"], ["img":"goods56.jpg", "name":"品牌鞋子"], ["img":"goods23.jpg", "name":"厨房电器"], ["img":"goods113.jpg", "name":"特色零食"], ["img":"goods27.jpg", "name":"家居水暖"], ["img":"goods21.jpg", "name":"按摩仪"]]],["headerTitle":"家装软饰", "arr":[["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods27.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"]]],
            ["headerTitle":"水具酒具", "arr":[["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"]]],
            ["headerTitle":"生活日用", "arr":[["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"]]],
            ["headerTitle":"厨房配件", "arr":[["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"], ["img":"goods1.jpg", "name":"净化除味"]]]
        ]
        
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
