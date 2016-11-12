//
//  FirstStoreDifferentClassViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/17.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstStoreDifferentClassViewController: BaseViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var searchBar = UISearchBar.init(frame: CGRect(x: 0, y: 307, width: 240, height: 30))
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: 100, height: HEIGHT), style: UITableViewStyle.grouped)
    let cellName = "asdaseasdlllccrad324";
    var selectRow = 0
    var goodsClassArr = ["推荐分类", "潮流女装","品牌男装" ,"个护化妆" ,"家用电器" ,"电脑办公" ,"手机数码" ,"母婴童装" ,"图书音像" ,"家居家纺" ,"居家生活" ,"家具建材" ,"食品生鲜" ,"酒水饮料" ,"运动户外" ,"鞋靴箱包" ,"奢品礼品" ,"钟表珠宝" ,"玩具乐器" ,"内衣配饰" ,"汽车用品" ,"医药保健" ,"计生情趣" ,"京东金融" ,"生活旅行" ,"宠物农资"]
    var oneGoodsClassArr : NSMutableArray = []
    var oneGoodsReuseId = "OneGoodsCell";
    var collectionHeaderId = "collectionHeaderId";
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
        self.getData()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "商城分类"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "navigationBar_bg"), for: UIBarMetrics.compact)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "scan.png"), style: UIBarButtonItemStyle.done, target: self, action: #selector(FirstStoreDifferentClassViewController.scanAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "message.png"), style: UIBarButtonItemStyle.done, target: self, action: #selector(FirstStoreDifferentClassViewController.messageAction))
        self.searchBar.placeholder = "搜索商铺/店铺"
        for subView:UIView in self.searchBar.subviews {
            for grandSonView:UIView in subView.subviews {
                if grandSonView.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                    grandSonView.alpha = 0
                }
            }
        }
        self.navigationItem.titleView = self.searchBar
        self.myTableView.contentInset = UIEdgeInsetsMake(64-35, 0, -20, 0);
//        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        // 分割线位置
//        self.myTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellName)
        self.view.addSubview(self.myTableView);
        
        let flow = UICollectionViewFlowLayout.init()
        flow.itemSize = CGSize(width: (WIDTH-120)/3, height: (WIDTH-120)/3+20)
        flow.headerReferenceSize = CGSize(width: WIDTH, height: 30);
        self.collectionView = UICollectionView.init(frame: CGRect(x: 110, y: navigationBar_H(self.navigationController!), width: WIDTH-120, height: HEIGHT-navigationBar_H(self.navigationController!)), collectionViewLayout: flow);
        self.collectionView.backgroundColor = RGBA(239, g: 239, b: 244, a: 1);
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.register(OneGoodsClassCollectionViewCell.self, forCellWithReuseIdentifier: self.oneGoodsReuseId);
        self.collectionView.register(OneGoodsClassCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.collectionHeaderId)
        self.view.addSubview(self.collectionView);
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goodsClassArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellName, for: indexPath) 
        if (cell.isEqual(nil)) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName)
        }
        cell.backgroundColor = UIColor.white
        cell.textLabel!.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = self.goodsClassArr[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if indexPath.row == self.selectRow {
            cell.textLabel?.textColor = UIColor.red
            cell.backgroundColor = UIColor.groupTableViewBackground
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectRow = indexPath.row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.groupTableViewBackground
        cell?.textLabel?.textColor = UIColor.red
        self.myTableView.reloadData()
        self.refreshData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: WIDTH, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header:OneGoodsClassCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.collectionHeaderId, for: indexPath) as! OneGoodsClassCollectionReusableView
        let dict = self.oneGoodsClassArr[indexPath.section] as! NSDictionary
        let title =  dict["headerTitle"] as! String
        header.headLabel!.text = title
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.oneGoodsClassArr.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dict = self.oneGoodsClassArr[section] as! NSDictionary
        let arr = dict["arr"] as! NSArray
        return arr.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.oneGoodsReuseId, for: indexPath) as! OneGoodsClassCollectionViewCell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    }
    
    func getData() -> Void {
        self.oneGoodsClassArr.add(["headerTitle":"数码电器", "arr":[["img":"goods1.jpg", "name":"U盘"], ["img":"goods2.jpg", "name":"虚拟现实"], ["img":"goods3.jpg", "name":"掌上电脑"], ["img":"goods4.jpg", "name":"智能手表"], ["img":"goods5.jpg", "name":"单反"], ["img":"goods6.jpg", "name":"耳机耳麦"], ["img":"goods7.jpg", "name":"摄像头"], ["img":"goods8.jpg", "name":"读卡器"]]])
        self.oneGoodsClassArr.add(["headerTitle":"鞋子", "arr":[["img":"goods31.jpg", "name":"透气网鞋"], ["img":"goods32.jpg", "name":"旅游鞋"], ["img":"goods33.jpg", "name":"运动鞋"], ["img":"goods34.jpg", "name":"超轻跑鞋"], ["img":"goods35.jpg", "name":"黑曼巴"], ["img":"goods36.jpg", "name":"内置增高"], ["img":"goods37.jpg", "name":"篮球鞋"], ["img":"goods38.jpg", "name":"经典战靴"], ["img":"goods39.jpg", "name":"安踏"], ["img":"goods40.jpg", "name":"耐克"], ["img":"goods41.jpg", "name":"皮鞋"]]])
        self.oneGoodsClassArr.add(["headerTitle":"服装", "arr":[["img":"goods61.jpg", "name":"李宁"], ["img":"goods62.jpg", "name":"Kappa"], ["img":"goods63.jpg", "name":"361°"], ["img":"goods64.jpg", "name":"连衣裙"], ["img":"goods65.jpg", "name":"运动服"], ["img":"goods66.jpg", "name":"短袖"], ["img":"goods67.jpg", "name":"美国队长"], ["img":"goods68.jpg", "name":"秋冬新款"], ["img":"goods69.jpg", "name":"Adidas"], ["img":"goods70.jpg", "name":"Polo衫"]]])
        self.oneGoodsClassArr.add(["headerTitle":"零食", "arr":[["img":"goods91.jpg", "name":"大枣"], ["img":"goods92.jpg", "name":"饼干"], ["img":"goods93.jpg", "name":"薯片"], ["img":"goods94.jpg", "name":"糖果"], ["img":"goods95.jpg", "name":"cookie"], ["img":"goods96.jpg", "name":"爆米花"], ["img":"goods97.jpg", "name":"田园薯片"], ["img":"goods98.jpg", "name":"乡巴佬"], ["img":"goods99.jpg", "name":"酥卷"]]])
        self.oneGoodsClassArr.add(["headerTitle":"生活日用", "arr":[["img":"goods86.jpg", "name":"休闲服装"], ["img":"goods56.jpg", "name":"品牌鞋子"], ["img":"goods23.jpg", "name":"厨房电器"], ["img":"goods113.jpg", "name":"特色零食"], ["img":"goods27.jpg", "name":"家居水暖"], ["img":"goods21.jpg", "name":"按摩仪"]]])
        self.oneGoodsClassArr.add(["headerTitle":"家装软饰", "arr":[["img":"goods20.jpg", "name":"iPhone"], ["img":"goods22.jpg", "name":"遥控飞机"], ["img":"goods23.jpg", "name":"空气净化器"], ["img":"goods24.jpg", "name":"路由器"], ["img":"goods26.jpg", "name":"智能家居"], ["img":"goods27.jpg", "name":"加湿器"], ["img":"goods29.jpg", "name":"手环"], ["img":"goods10.jpg", "name":"剃须刀"]]])
        self.oneGoodsClassArr.add(["headerTitle":"厨房配件", "arr":[["img":"goods11.jpg", "name":"风筒"], ["img":"goods12.jpg", "name":"血糖仪"], ["img":"goods14.jpg", "name":"橱柜"], ["img":"goods15.jpg", "name":"清洁器"], ["img":"goods18.jpg", "name":"微波炉"]]])
    }
    
    func refreshData() {
        for i in 0...5 {
            let randomNum = Int(arc4random() % UInt32(self.oneGoodsClassArr.count))
            let randomNum2 = Int(arc4random() % UInt32(self.oneGoodsClassArr.count))
            let obj = self.oneGoodsClassArr[randomNum] as! NSDictionary
            self.oneGoodsClassArr[randomNum] = self.oneGoodsClassArr[randomNum2]
            self.oneGoodsClassArr[randomNum2] = obj
        }
        self.collectionView.reloadData()
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
