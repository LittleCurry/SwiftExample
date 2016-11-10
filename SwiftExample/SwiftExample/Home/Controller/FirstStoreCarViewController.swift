//
//  FirstStoreCarViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/17.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstStoreCarViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var storeCarArr : NSMutableArray = [];
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.grouped);
    let cellName = "qwes21d123ssasdsassasqwe";
    var allMoney = 0.0
    var count = 0;
    let myAllMoneyLabel = UILabel.init(frame: CGRect(x:120,y:HEIGHT-49,width:100,height:49))
    let goPayButton = UIButton.init(type: .custom)
    var isAllChose = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView();
        self.getData();
    }
    
    func getView() -> Void {
        self.navigationItem.title = "购物车"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "message.png"), style: UIBarButtonItemStyle.done, target: self, action: #selector(FirstStoreCarViewController.messageAction))
        
        self.myTableView.contentInset = UIEdgeInsetsMake(64-35+10, 0, 49+3-20-20, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.register(StoreCarTableViewCell.self, forCellReuseIdentifier: self.cellName)
        self.view.addSubview(self.myTableView);
        
        let whiteView = UIView.init(frame: CGRect(x:0,y:HEIGHT-49,width:WIDTH,height:49))
        whiteView.backgroundColor = UIColor.groupTableViewBackground
        self.view.addSubview(whiteView)
        let circleButton = UIButton.init(type: .custom)
        circleButton.frame = CGRect(x: 10, y: HEIGHT-49, width: 50, height: 49)
        circleButton.imageEdgeInsets = UIEdgeInsetsMake(14.5, 0, 14.5, 30)
        circleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        circleButton.setImage(UIImage.init(named: "circle.png"), for: .normal)
        circleButton.setTitleColor(GRAY121COLOR, for: .normal)
        circleButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        circleButton.setTitle("全选", for: .normal)
        circleButton.addTarget(self, action: #selector(allChoseAction(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(circleButton)
        
        let allMoneyLabel = UILabel.init(frame: CGRect(x:70,y:HEIGHT-49,width:50,height:49))
        allMoneyLabel.text = "合计:¥"
        self.view.addSubview(allMoneyLabel)
        self.myAllMoneyLabel.text = "0.00"
        self.view.addSubview(self.myAllMoneyLabel)
        self.goPayButton.frame = CGRect(x:WIDTH-100,y:HEIGHT-49,width:100,height:49)
        self.goPayButton.setTitle("去结算", for: .normal)
        self.goPayButton.alpha = 0.5
        self.goPayButton.isUserInteractionEnabled = false
        self.goPayButton.backgroundColor = UIColor.red
        self.view.addSubview(self.goPayButton)
    }
    
    func messageAction() -> Void {
        //
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeCarArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:StoreCarTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellName, for: indexPath) as! StoreCarTableViewCell
        if (cell.isEqual(nil)) {
            cell = StoreCarTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName)
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.circleButton?.tag = indexPath.row + 99;
        // swiftselector,ocselector, button的方法选择器 或者#selector(FirstStoreCarViewController.choseAction)
        cell.circleButton?.addTarget(self, action: #selector(choseAction(_:)), for: UIControlEvents.touchUpInside)
        
//        var aImage = UIImage.init()
//        if (cell.isChose) {
//            aImage = UIImage.init(named: "yes.png")!
//        } else {
//            aImage = UIImage.init(named: "circle.png")!
//        }
//        cell.circleButton?.setBackgroundImage(aImage, for: .normal)
        
        cell.reduceButton?.tag = indexPath.row + 99999;
        cell.reduceButton?.addTarget(self, action: #selector(reduceAction(_:)), for: UIControlEvents.touchUpInside)
        cell.addButton?.tag = indexPath.row + 999999;
        cell.addButton?.addTarget(self, action: #selector(addAction(_:)), for: UIControlEvents.touchUpInside)
        
        cell.storeCar = self.storeCarArr[indexPath.row] as? StoreCar
        return cell
    }
    
    func choseAction(_ button:UIButton) {
//        let index = NSIndexPath.init(row: button.tag - 99, section: 0)
        let storeCar = self.storeCarArr[button.tag - 99] as! StoreCar
//        let cell = self.myTableView.cellForRow(at: index as IndexPath) as! StoreCarTableViewCell
//        let aImage = cell.isChose ? UIImage.init(named: "circle.png") : UIImage.init(named: "yes.png")
//        button.setBackgroundImage(aImage, for: .normal)
//        cell.isChose = !cell.isChose
        storeCar.isChose = !storeCar.isChose
        self.myTableView.reloadData()
        checkAllMoney()
    }
    
    func allChoseAction(_ button:UIButton) -> Void {
        let aImage = self.isAllChose ? UIImage.init(named: "circle.png") : UIImage.init(named: "yes.png")
        button.setImage(aImage, for: .normal)
        for i in 0...self.storeCarArr.count-1 {
            let storeCar = self.storeCarArr[i] as! StoreCar
            storeCar.isChose = !self.isAllChose
        }
        self.isAllChose = !self.isAllChose
        self.myTableView.reloadData()
        self.checkAllMoney()
    }
    
    func reduceAction(_ button:UIButton) {
        let storeCar = self.storeCarArr[button.tag - 99999] as! StoreCar
        if storeCar.count > 1 {
            storeCar.count -= 1
        }
        if storeCar.count == 1{
            button.isUserInteractionEnabled = false
            button.alpha = 0.5
        }
        self.myTableView.reloadData()
        self.checkAllMoney()
    }
    
    func addAction(_ button:UIButton) {
        let index = NSIndexPath.init(row: button.tag - 999999, section: 0)
        let storeCar = self.storeCarArr[button.tag - 999999] as! StoreCar
        let cell = self.myTableView.cellForRow(at: index as IndexPath) as! StoreCarTableViewCell
        cell.reduceButton?.isUserInteractionEnabled = true
        cell.reduceButton?.alpha = 1
        storeCar.count += 1
        self.myTableView.reloadData()
        self.checkAllMoney()
    }
    
    func checkAllMoney() {
        self.allMoney = 0.0
        self.count = 0
        for i in 0...self.storeCarArr.count-1 {
            let storeCar = self.storeCarArr[i] as! StoreCar
            if (storeCar.isChose) {
                self.allMoney += Double(storeCar.count)*(storeCar.money)
                self.count += storeCar.count
            }
        }
        self.myAllMoneyLabel.text = String.init(format: "%.2f", self.allMoney)
        self.goPayButton.setTitle(String.init(format: "去结算(%ld)", self.count), for: .normal)
        self.goPayButton.alpha = 1
        self.goPayButton.isUserInteractionEnabled = true
        if self.count==0 {
            self.goPayButton.setTitle("去结算", for: .normal)
            self.goPayButton.alpha = 0.5
            self.goPayButton.isUserInteractionEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    
    func getData() -> Void {
        let tempArr:NSMutableArray = []        
        tempArr.add(["chargeType":"满减", "charge":"已购满1999元, 可领取赠品", "getFree":"领赠品>", "isChose":false, "bigImage":"goods3.jpg", "name":"正品Apple/苹果 9.7 英寸 iPad Pro WLAN 32GBwifi版超薄平板电脑", "colorText":"颜色:白色", "money":"4018.00", "count":1])
        tempArr.add(["chargeType":"换购", "charge":"已购满1999元, 可领取赠品", "getFree":"领赠品>", "isChose":false, "bigImage":"goods26.jpg", "name":"三星 指纹锁密码锁家用防盗门锁智能电子锁磁卡锁DP728可连接手机", "colorText":"颜色:银色", "money":"3218.00", "count":1])
        tempArr.add(["chargeType":"换购", "charge":"购满299.00元, 即可换购商品", "getFree":"去凑单>", "isChose":false, "bigImage":"goods66.jpg", "name":"凡兔短袖T恤男秋装纯棉宽松圆领白色运动休闲男士上衣短袖打底衫", "colorText":"颜色:粉色", "money":"79.00", "count":1])
        tempArr.add(["chargeType":"换购", "charge":"购满199.00元, 即可换购商品", "getFree":"去凑单>", "isChose":false, "bigImage":"goods8.jpg", "name":"格洋 U盘32G高速防水车载金属u盘16G个性迷你64G电脑U盘128G优盘", "colorText":"颜色:橘黄", "money":"30.00", "count":1])
        tempArr.add(["chargeType":"满减", "charge":"购满299.00元, 即可换购商", "getFree":"去凑单>", "isChose":false, "bigImage":"goods60.jpg", "name":"JOOC/玖诗2016春夏新款性感尖头网纱细高跟鞋真皮凉鞋女单鞋Q803", "colorText":"颜色:黑", "money":"288.00", "count":1])
        tempArr.add(["chargeType":"满减", "charge":"已购满39999元, 可领取赠品", "getFree":"领赠品>", "isChose":false, "bigImage":"goods13.jpg", "name":"Apple/苹果 9.7 英寸 iPad Pro WLAN 128GB Apple/苹果 12 英寸 MacBook 512GB", "colorText":"颜色:银色", "money":"55806.00", "count":1])
        tempArr.add(["chargeType":"换购", "charge":"已购满199元, 可领取赠品", "getFree":"领赠品>", "isChose":false, "bigImage":"goods46.jpg", "name":"婚纱照结婚鞋子尖头高跟鞋细跟灰姑娘水晶鞋婚鞋新娘鞋水钻单鞋女", "colorText":"颜色:银白", "money":"368.00", "count":1])
        tempArr.add(["chargeType":"返现", "charge":"购满299.00元, 即可换购商", "getFree":"去凑单>", "isChose":false, "bigImage":"goods55.jpg", "name":"保罗品牌男鞋新款2016秋季男士休闲运动鞋旅游鞋跑步耐磨冬季板鞋", "colorText":"颜色:黑白", "money":"155.00", "count":1])
        tempArr.add(["chargeType":"返现", "charge":"已购满699元, 可领取赠品", "getFree":"领赠品>", "isChose":false, "bigImage":"goods33.jpg", "name":"Nike 耐克官方 NIKE AIR MAX EFFORT TR 男子训练鞋 705353", "colorText":"颜色:黑白", "money":"798.00", "count":1])
        tempArr.add(["chargeType":"换购", "charge":"已购满999元, 可领取赠品", "getFree":"领赠品>", "isChose":false, "bigImage":"goods17.jpg", "name":"虹PAD E90 8.9英寸 WIFI四核 WIN8 视网膜高清屏32GB平板电脑", "colorText":"颜色:银白", "money":"999.00", "count":1])
        tempArr.add(["chargeType":"返现", "charge":"购满199.00元, 即可换购商品", "getFree":"去凑单>", "isChose":false, "bigImage":"goods45.jpg", "name":"2016欧美磨砂绒面黑色高跟鞋职业OL红底鞋超高跟鞋细跟尖头单鞋女", "colorText":"颜色:黑", "money":"79.00", "count":1])
        tempArr.add(["chargeType":"返现", "charge":"已购满299元, 可领取赠品", "getFree":"领赠品>", "isChose":false, "bigImage":"goods68.jpg", "name":"ADIDAS阿迪达斯 男装2016秋款男子透气防风夹克外套B34626 B34627", "colorText":"颜色:纯白", "money":"359.00", "count":1])
        tempArr.add(["chargeType":"换购", "charge":"已购满1999元, 可领取赠品", "getFree":"领赠品>", "isChose":false, "bigImage":"goods5.jpg", "name":"【蚂蚁摄影】花呗分期Canon/佳能 EOS700D 18-135套机单反照相机", "colorText":"颜色:黑", "money":"4799.00", "count":1])

        for oneDic in tempArr {
            let storeCar = StoreCar.objectWithDictionary(oneDic as! [String : AnyObject]) as? StoreCar
            self.storeCarArr.add(storeCar!);
        }
        self.myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
