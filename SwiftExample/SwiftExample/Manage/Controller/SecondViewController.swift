//
//  SecondViewController.swift
//  SwiftTableView
//
//  Created by 李云鹏 on 16/9/12.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var playReuseIdentifier = "PlayCell";
    var collectionView : UICollectionView!
    var playArr : NSMutableArray = [];
    var pn:NSInteger = 0;
    var tag1 = "明星";
    var tag2 = "全部";
    var normalImages:NSMutableArray = [];// gif图片
    var refreshImages:NSMutableArray = [];// gif图片
    var downView = DownEditView.init();
    var listArr = [["img" : "circleGirl.png", "title" : "美女"], ["img" : "superStar.png", "title" : "明星"], ["img" : "car.png", "title" : "汽车"], ["img" : "pet.png", "title" : "宠物"], ["img" : "cartoon.png", "title" : "动漫"], ["img" : "design.png", "title" : "设计"], ["img" : "furniture.png", "title" : "家居"], ["img" : "marry.png", "title" : "婚嫁"], ["img" : "photograph.png", "title" : "摄影"], ["img" : "food.png", "title" : "美食"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView();
        self.getData();
    }
    func getView() -> Void {
        self.navigationItem.title = "明星"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(SecondViewController.pushEditView))
        let layout = HMWaterflowLayout.init();
        layout.heightBlock = { (sender, index) -> (CGFloat) in
            let photo = self.playArr[(index?.item)!] as!Play;
            return photo.small_height / photo.small_width * sender;
        }
        layout.columnsCount = 2;
        
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
        
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout);
        self.collectionView.backgroundColor = RGBA(239, g: 239, b: 244, a: 1);
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.contentInset = UIEdgeInsetsMake(navigationBar_H(self.navigationController!), 0, tabBar_H(self.tabBarController!), 0);
        self.collectionView.register(PlayCollectionViewCell.self, forCellWithReuseIdentifier: playReuseIdentifier);
        
        let header = MJRefreshGifHeader.init(refreshingBlock: {
            self.pn = 0;
            self.getData();
        });
        header?.setImages(self.normalImages as [AnyObject], for: MJRefreshState.refreshing);
        header?.setImages(self.refreshImages as [AnyObject], for: MJRefreshState.idle);
        header?.setImages(self.normalImages as [AnyObject], for: MJRefreshState.pulling);
        header?.lastUpdatedTimeLabel.isHidden = true;
        header?.stateLabel.isHidden = true;
        self.collectionView.mj_header = header;
        
        let footer = MJRefreshAutoNormalFooter.init {
            self.pn += 60;
            self.getData();
        };
        self.collectionView.mj_footer = footer;
        self.view.addSubview(self.collectionView);
    }
    
    func pushEditView() -> Void {
        self.downView = DownEditView.init(arr: self.listArr)
        for view:UIView in self.downView.blackView.subviews {
            if view.isKind(of: UIButton.self) {
                let button = view as! UIButton
                button.addTarget(self, action: #selector(SecondViewController.clickEditButton(_:)), for: UIControlEvents.touchUpInside);
            }
        }
        UIApplication.shared.keyWindow?.addSubview(self.downView)
    }
    
    func clickEditButton(_ button:UIButton) -> Void {
        let dic = self.listArr[button.tag-888] as NSDictionary
        self.navigationItem.title = dic.value(forKey: "title") as! String
        self.tag1 = dic.value(forKey: "title") as! String
        self.tag2 = "全部"
        self.pn = 0
        self.getData()
        self.downView.remove()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.playArr.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playReuseIdentifier, for: indexPath) as! PlayCollectionViewCell
        cell.play = self.playArr[indexPath.item] as?Play;
        return cell
    }
    
    func getData() -> Void {
        let dic = ["pn":self.pn, "rn":60];
        let urlstr = "http://image.baidu.com/wisebrowse/data?tag1="+self.tag1+"&tag2="+self.tag2;
        NetHandler.getDataWithUrl(urlstr, parameters: dic, tokenKey: "", tokenValue: "", ifCaches: false, cachesData: { (cacheData) in
            //
            }, success: { (successData) in
                let dict = try! JSONSerialization.jsonObject(with: successData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary;
                print(dict)
                let imgArr = dict["imgs"] as! NSMutableArray;
                if(self.pn == 0){
                    self.playArr.removeAllObjects();
                }
                for oneDic in imgArr {
                    let play = Play.objectWithDictionary(oneDic as! [String : AnyObject]) as? Play
                    self.playArr.add(play!);
                }
                self.collectionView.reloadData();
                
                self.collectionView.mj_header.endRefreshing();
                self.collectionView.mj_footer.endRefreshing();
                if(imgArr.count < 60){
                    self.collectionView.mj_footer.endRefreshingWithNoMoreData();
                }
            }, failure: { (failData) in
                self.collectionView.mj_header.endRefreshing();
                self.collectionView.mj_footer.endRefreshing();
        })
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
