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
    var searchBar = UISearchBar.init(frame: CGRect(x: 0, y: 307, width: 240, height: 30))
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.grouped);
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "navigationBar_bg"), for: UIBarMetrics.compact)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "scan.png"), style: UIBarButtonItemStyle.done, target: self, action: #selector(FirstStoreHomeViewController.scanAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "message.png"), style: UIBarButtonItemStyle.done, target: self, action: #selector(FirstStoreHomeViewController.messageAction))
        self.searchBar.placeholder = "搜索商铺/店铺"
        for subView:UIView in self.searchBar.subviews {
            for grandSonView:UIView in subView.subviews {
                if grandSonView.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                    grandSonView.alpha = 0
                }
            }
        }
        self.navigationItem.titleView = self.searchBar
        
        for i in 1...6 {
            // normalhImages
            let image = UIImage.init(named: String.init(format:"%ld.tiff", i));
            self.normalImages.add(image!);
        }
        for i in 7...47 {
            // refreshImages
            let image = UIImage.init(named: String(i)+".tiff");
            self.refreshImages.add(image!);
        }
        self.myTableView.contentInset = UIEdgeInsetsMake(-35, 0, 49-20-20, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.register(StoreHomeTableViewCell1.self, forCellReuseIdentifier: self.cellName1)
        self.myTableView.register(StoreHomeTableViewCell2.self, forCellReuseIdentifier: self.cellName2)
        self.myTableView.register(StoreHomeTableViewCell3.self, forCellReuseIdentifier: self.cellName3)
        self.myTableView.register(StoreHomeTableViewCell4.self, forCellReuseIdentifier: self.cellName4)
        self.myTableView.register(StoreHomeTableViewCell5.self, forCellReuseIdentifier: self.cellName5)
        self.myTableView.register(StoreHomeTableViewCell6.self, forCellReuseIdentifier: self.cellName6)
        let header = MJRefreshGifHeader.init(refreshingBlock: {
//            self.count = 0;
//            self.getData();
        });
        header?.setImages(self.normalImages as [AnyObject], for: MJRefreshState.refreshing);
        header?.setImages(self.refreshImages as [AnyObject], for: MJRefreshState.idle);
        header?.setImages(self.normalImages as [AnyObject], for: MJRefreshState.pulling);
        header?.lastUpdatedTimeLabel.isHidden = true;
        header?.stateLabel.isHidden = true;
//        self.myTableView.mj_header = header;
        
        let footer = MJRefreshAutoNormalFooter.init {
//            self.count += 10;
//            self.getData();
        };
//        self.myTableView.mj_footer = footer;
        self.view.addSubview(self.myTableView);
        
        self.topBtn = UIButton.init(type: .custom)
        self.topBtn?.frame = CGRect(x: WIDTH-60, y: HEIGHT-60, width: 40, height: 40)
        self.topBtn?.setBackgroundImage(UIImage.init(named: "goTop.png"), for: UIControlState())
        self.topBtn?.addTarget(self, action: #selector(FirstStoreHomeViewController.goTop), for: UIControlEvents.touchUpInside)
        self.topBtn?.isHidden = true
        self.view.addSubview(self.topBtn!)
        self.loadAvataView = RCDraggableButton.init(inKeyWindowWithFrame: CGRect(x: 0, y: 333.5, width: 60, height: 60))
        self.loadAvataView!.setBackgroundImage(UIImage.init(named: "stopAir.png"), for: UIControlState())
        self.loadAvataView?.longPressBlock = { (avatar) in
            print("longPressBlock")
        }
//        self.loadAvataView!.adjustsImageWhenHighlighted = false // 高亮图变色
     
        self.adUrlArr.add(URL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1402/221/421883372/88115/8cc2231a/55815835N35a44559.jpg")!)
        self.adUrlArr.add(URL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t976/208/1221678737/91179/5d7143d5/5588e849Na2c20c1a.jpg")!)
        self.adUrlArr.add(URL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t805/241/1199341035/289354/8648fe55/5581211eN7a2ebb8a.jpg")!)
        self.adUrlArr.add(URL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1606/199/444346922/48930/355f9ef/55841cd0N92d9fa7c.jpg")!)
        self.adUrlArr.add(URL.init(string: "http://img30.360buyimg.com/mobilecms/s480x180_jfs/t1609/58/409100493/49144/7055bec5/557e76bfNc065aeaf.jpg")!)
        self.cycleScrollView = SDCycleScrollView.init(frame: CGRect(x: 0, y: 64, width: WIDTH, height: 180), imageURLsGroup: self.adUrlArr as [AnyObject])
        self.cycleScrollView!.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        self.cycleScrollView!.delegate = self;
        self.cycleScrollView!.autoScrollTimeInterval = 3.5;
        self.cycleScrollView!.dotColor = UIColor.white;
        self.cycleScrollView!.pageControlDotSize = CGSize(width: 4, height: 4);
        self.cycleScrollView!.titleLabelBackgroundColor = RGBA(121, g: 121, b: 121, a: 0.2);
        self.cycleScrollView!.titleLabelTextColor = UIColor.yellow;
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        NSLog("---点击了第%ld张图片", index);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = UIColor.white;
        self.navigationController!.navigationBar.setBackgroundImage(UIImage.init(named:"bigShadow.png"), for: UIBarMetrics.compact);
        self.navigationController!.navigationBar.layer.masksToBounds = true;
        
        self.loadAvataView!.isHidden = false;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: ""), for: UIBarMetrics.default)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage.init(named:""), for: UIBarMetrics.compact)
        self.navigationController!.navigationBar.layer.masksToBounds = false;
        
        self.loadAvataView!.isHidden = true;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 180
        }
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return self.cycleScrollView
        }
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 220
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            return 180
        }
        return 150*3+110;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            var cell:StoreHomeTableViewCell1 = tableView.dequeueReusableCell(withIdentifier: self.cellName1, for: indexPath) as! StoreHomeTableViewCell1
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell1.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName1)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
            break
        case 1:
            var cell:StoreHomeTableViewCell2 = tableView.dequeueReusableCell(withIdentifier: self.cellName2, for: indexPath) as! StoreHomeTableViewCell2
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell2.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName2)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
            break
        case 2:
            var cell:StoreHomeTableViewCell3 = tableView.dequeueReusableCell(withIdentifier: self.cellName3, for: indexPath) as! StoreHomeTableViewCell3
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell3.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName3)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
            break
        case 3:
            var cell:StoreHomeTableViewCell4 = tableView.dequeueReusableCell(withIdentifier: self.cellName4, for: indexPath) as! StoreHomeTableViewCell4
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell4.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName4)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
            break
        case 4:
            var cell:StoreHomeTableViewCell5 = tableView.dequeueReusableCell(withIdentifier: self.cellName5, for: indexPath) as! StoreHomeTableViewCell5
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell5.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName5)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
            break
        case 5:
            var cell:StoreHomeTableViewCell6 = tableView.dequeueReusableCell(withIdentifier: self.cellName6, for: indexPath) as! StoreHomeTableViewCell6
            if (cell.isEqual(nil)) {
                cell = StoreHomeTableViewCell6.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName6)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
            break
        default:
            break
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func scanAction() -> Void {
        if (validateCamera() && canUseCamera()) {
            let qrVC = QRViewController.init();
            qrVC.qrUrlBlock = { (resultUrl)  in
                MMAlertView.init(confirmTitle: "扫描结果:", detail: resultUrl).show(nil);
            }
            qrVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(qrVC, animated: true)
        }
    }
    
    func messageAction() -> Void {
        //
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event);
        self.searchBar.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < lastContentOffset ){
            //向上
            self.topBtn!.isHidden = true;
        }else if(scrollView.contentOffset.y > lastContentOffset){
            //向下
            self.topBtn!.isHidden = false;
        }
    }
    
    func goTop() -> Void {
        self.myTableView.setContentOffset(CGPoint(x: 0, y: 35), animated: true)
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
