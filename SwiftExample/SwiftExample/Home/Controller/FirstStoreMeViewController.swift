//
//  FirstStoreMeViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/17.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstStoreMeViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    var scrollView = UIScrollView.init(frame: CGRect(x:0, y:64, width:WIDTH, height:HEIGHT-64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "我的"
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "setup.png"), style: UIBarButtonItemStyle.done, target: self, action: #selector(FirstStoreMeViewController.scanAction(button:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "message.png"), style: UIBarButtonItemStyle.done, target: self, action: #selector(FirstStoreMeViewController.messageAction))
        
        self.scrollView.backgroundColor = UIColor.groupTableViewBackground
        self.view.addSubview(self.scrollView)
        let bigImage = UIImageView.init(frame: CGRect(x:0, y:0, width:WIDTH, height:200))
        bigImage.image = UIImage.init(named: "jigsaw.jpg")?.applyDarkEffect()
        self.scrollView.addSubview(bigImage)
        let headImage = UIImageView.init(frame: CGRect(x:20, y:20, width:100, height:100))
        headImage.clipsToBounds = true
        headImage.layer.cornerRadius = 50
        headImage.image = UIImage.init(named: "meinv.jpg")
        self.scrollView.addSubview(headImage)
        let nameLabel = UILabel.init(frame: CGRect(x:130, y:20, width:100, height:30))
        nameLabel.textColor = UIColor.white
        nameLabel.font = WORDFONT
        nameLabel.text = "jd_6a19ddd4d2b3d"
        nameLabel.sizeToFit()
        self.scrollView.addSubview(nameLabel)
        let superImage = UIImageView.init(frame: CGRect(x:X(nameLabel)+PART_W(nameLabel), y:Y(nameLabel), width:20, height:20))
        superImage.image = UIImage.init(named: "vip.png")
        self.scrollView.addSubview(superImage)
        let blackView = UIView.init(frame: CGRect(x:0, y:156, width:WIDTH, height:44))
        blackView.backgroundColor = UIColor.white
        blackView.alpha = 0.3
        self.scrollView.addSubview(blackView)
        
        let label1 = UILabel.init(frame: CGRect(x:0, y:161, width:WIDTH/3, height:22))
        label1.font = UIFont.systemFont(ofSize: 14)
        label1.textColor = UIColor.red
        label1.textAlignment = .center
        label1.text = "13"
        self.scrollView.addSubview(label1)
        let label11 = UILabel.init(frame: CGRect(x:0, y:178, width:WIDTH/3, height:22))
        label11.font = UIFont.systemFont(ofSize: 12)
        label11.textAlignment = .center
        label11.text = "商品关注"
        self.scrollView.addSubview(label11)
        let lineView1 = UIView.init(frame: CGRect(x:WIDTH/3, y:161, width:0.3, height:34))
        lineView1.backgroundColor = UIColor.groupTableViewBackground
        self.scrollView.addSubview(lineView1)
        
        let label2 = UILabel.init(frame: CGRect(x:WIDTH/3+0.3, y:161, width:WIDTH/3, height:22))
        label2.font = UIFont.systemFont(ofSize: 14)
        label2.textColor = UIColor.red
        label2.textAlignment = .center
        label2.text = "3"
        self.scrollView.addSubview(label2)
        let label22 = UILabel.init(frame: CGRect(x:WIDTH/3+0.3, y:178, width:WIDTH/3, height:22))
        label22.font = UIFont.systemFont(ofSize: 12)
        label22.textAlignment = .center
        label22.text = "店铺关注"
        let lineView2 = UIView.init(frame: CGRect(x:WIDTH*2/3+0.6, y:161, width:0.3, height:34))
        lineView2.backgroundColor = UIColor.groupTableViewBackground
        self.scrollView.addSubview(lineView2)
        
        self.scrollView.addSubview(label22)
        let label3 = UILabel.init(frame: CGRect(x:WIDTH*2/3+0.6, y:161, width:WIDTH/3, height:22))
        label3.font = UIFont.systemFont(ofSize: 14)
        label3.textColor = UIColor.red
        label3.textAlignment = .center
        label3.text = "28"
        self.scrollView.addSubview(label3)
        let label33 = UILabel.init(frame: CGRect(x:WIDTH*2/3+0.6, y:178, width:WIDTH/3, height:22))
        label33.font = UIFont.systemFont(ofSize: 12)
        label33.textAlignment = .center
        label33.text = "浏览记录"
        self.scrollView.addSubview(label33)
        
        let whiteView1 = UIView.init(frame: CGRect(x:0, y:200, width:WIDTH, height:60))
        whiteView1.backgroundColor = UIColor.white
        self.scrollView.addSubview(whiteView1)
        
        let button1 = UIButton.init(type: .custom)
        button1.frame = CGRect(x:0, y:0, width:WIDTH/5, height:60)
        button1.setTitleColor(UIColor.darkGray, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button1.setTitle("待付款", for: .normal)
        button1.setImage(UIImage.init(named: "card.png"), for: .normal)
        // button图上字下
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;//使图片和文字水平居中显示
        button1.titleEdgeInsets = UIEdgeInsetsMake((button1.imageView?.frame.size.height)!, -(button1.imageView?.frame.size.width)!, 0, 0)
        button1.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button1.titleLabel?.bounds.size.width)!)
        whiteView1.addSubview(button1)
        
        let button2 = UIButton.init(type: .custom)
        button2.frame = CGRect(x:WIDTH/5, y:0, width:WIDTH/5, height:60)
        button2.setTitleColor(UIColor.darkGray, for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button2.setTitle("待收货", for: .normal)
        button2.setImage(UIImage.init(named: "lineLogistics.png"), for: .normal)
        button2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        button2.titleEdgeInsets = UIEdgeInsetsMake((button2.imageView?.frame.size.height)!, -(button2.imageView?.frame.size.width)!, 0, 0)
        button2.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button2.titleLabel?.bounds.size.width)!)
        whiteView1.addSubview(button2)
        
        let button3 = UIButton.init(type: .custom)
        button3.frame = CGRect(x:WIDTH*2/5, y:0, width:WIDTH/5, height:60)
        button3.setTitleColor(UIColor.darkGray, for: .normal)
        button3.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button3.setTitle("待评价", for: .normal)
        button3.setImage(UIImage.init(named: "chat.png"), for: .normal)
        button3.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        button3.titleEdgeInsets = UIEdgeInsetsMake((button3.imageView?.frame.size.height)!, -(button3.imageView?.frame.size.width)!, 0, 0)
        button3.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button3.titleLabel?.bounds.size.width)!)
        whiteView1.addSubview(button3)
        
        let button4 = UIButton.init(type: .custom)
        button4.frame = CGRect(x:WIDTH*3/5, y:0, width:WIDTH/5, height:60)
        button4.setTitleColor(UIColor.darkGray, for: .normal)
        button4.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button4.setTitle("退换/修", for: .normal)
        button4.setImage(UIImage.init(named: "deal.png"), for: .normal)
        button4.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        button4.titleEdgeInsets = UIEdgeInsetsMake((button4.imageView?.frame.size.height)!, -(button4.imageView?.frame.size.width)!, 0, 0)
        button4.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button4.titleLabel?.bounds.size.width)!)
        whiteView1.addSubview(button4)
        
        let button5 = UIButton.init(type: .custom)
        button5.frame = CGRect(x:WIDTH*4/5, y:0, width:WIDTH/5, height:60)
        button5.setTitleColor(UIColor.darkGray, for: .normal)
        button5.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button5.setTitle("订单>", for: .normal)
        button5.setImage(UIImage.init(named: "order.png"), for: .normal)
        button5.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        button5.titleEdgeInsets = UIEdgeInsetsMake((button5.imageView?.frame.size.height)!, -(button5.imageView?.frame.size.width)!, 0, 0)
        button5.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button5.titleLabel?.bounds.size.width)!)
        whiteView1.addSubview(button5)
        
        let horizontalLineView1 = UIView.init(frame: CGRect(x:0, y:260, width:WIDTH, height:10))
        horizontalLineView1.backgroundColor = UIColor.groupTableViewBackground
        self.scrollView.addSubview(horizontalLineView1)
        
        let whiteView2 = UIView.init(frame: CGRect(x:0, y:270, width:WIDTH, height:60))
        whiteView2.backgroundColor = UIColor.white
        self.scrollView.addSubview(whiteView2)
        
        let label4 = UILabel.init(frame: CGRect(x:0, y:8, width:WIDTH/5, height:22))
        label4.font = UIFont.systemFont(ofSize: 14)
        label4.textAlignment = .center
        label4.text = "1108"
        whiteView2.addSubview(label4)
        let label44 = UILabel.init(frame: CGRect(x:0, y:30, width:WIDTH/5, height:22))
        label44.font = UIFont.systemFont(ofSize: 14)
        label44.textAlignment = .center
        label44.text = "京豆"
        whiteView2.addSubview(label44)
        
        let label5 = UILabel.init(frame: CGRect(x:WIDTH/5, y:8, width:WIDTH/5, height:22))
        label5.font = UIFont.systemFont(ofSize: 14)
        label5.textAlignment = .center
        label5.text = "3"
        whiteView2.addSubview(label5)
        let label55 = UILabel.init(frame: CGRect(x:WIDTH/5, y:30, width:WIDTH/5, height:22))
        label55.font = UIFont.systemFont(ofSize: 14)
        label55.textAlignment = .center
        label55.text = "优惠券"
        whiteView2.addSubview(label55)
        
        let label6 = UILabel.init(frame: CGRect(x:WIDTH*2/5, y:8, width:WIDTH/5, height:22))
        label6.font = UIFont.systemFont(ofSize: 14)
        label6.textAlignment = .center
        label6.text = "0"
        whiteView2.addSubview(label6)
        let label66 = UILabel.init(frame: CGRect(x:WIDTH*2/5, y:30, width:WIDTH/5, height:22))
        label66.font = UIFont.systemFont(ofSize: 14)
        label66.textAlignment = .center
        label66.text = "白条"
        whiteView2.addSubview(label66)
        
        let label7 = UILabel.init(frame: CGRect(x:WIDTH*3/5, y:8, width:WIDTH/5, height:22))
        label7.font = UIFont.systemFont(ofSize: 14)
        label7.textAlignment = .center
        label7.text = "1"
        whiteView2.addSubview(label7)
        let label77 = UILabel.init(frame: CGRect(x:WIDTH*3/5, y:30, width:WIDTH/5, height:22))
        label77.font = UIFont.systemFont(ofSize: 14)
        label77.textAlignment = .center
        label77.text = "京东E卡"
        whiteView2.addSubview(label77)
        
        let button6 = UIButton.init(type: .custom)
        button6.frame = CGRect(x:WIDTH*4/5, y:0, width:WIDTH/5, height:60)
        button6.setTitleColor(UIColor.darkGray, for: .normal)
        button6.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button6.setTitle("钱包>", for: .normal)
        button6.setImage(UIImage.init(named: "purse.png"), for: .normal)
        button6.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        button6.titleEdgeInsets = UIEdgeInsetsMake((button6.imageView?.frame.size.height)!, -(button6.imageView?.frame.size.width)!, 0, 0)
        button6.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button6.titleLabel?.bounds.size.width)!)
        whiteView2.addSubview(button6)
        
        let horizontalLineView2 = UIView.init(frame: CGRect(x:0, y:330, width:WIDTH, height:10))
        horizontalLineView2.backgroundColor = UIColor.groupTableViewBackground
        self.scrollView.addSubview(horizontalLineView2)
        
        let whiteView3 = UIImageView.init(frame: CGRect(x:0, y:340, width:WIDTH, height:60))
        whiteView3.image = UIImage.init(named: "wallpaper.jpg")
        self.scrollView.addSubview(whiteView3)
        
        let button7 = UIButton.init(type: .custom)
        button7.frame = CGRect(x:0, y:0, width:WIDTH/4, height:60)
        button7.setTitleColor(UIColor.black, for: .normal)
        button7.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button7.setTitle("11.11主会场", for: .normal)
        button7.setImage(UIImage.init(named: "castle.png"), for: .normal)
        button7.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        button7.titleEdgeInsets = UIEdgeInsetsMake((button7.imageView?.frame.size.height)!, -(button7.imageView?.frame.size.width)!, 0, 0)
        button7.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button7.titleLabel?.bounds.size.width)!)
        whiteView3.addSubview(button7)
        
        let button8 = UIButton.init(type: .custom)
        button8.frame = CGRect(x:WIDTH/4, y:0, width:WIDTH/4, height:60)
        button8.setTitleColor(UIColor.black, for: .normal)
        button8.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button8.setTitle("大牌嘉年华", for: .normal)
        button8.setImage(UIImage.init(named: "shopping.png"), for: .normal)
        button8.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        button8.titleEdgeInsets = UIEdgeInsetsMake((button8.imageView?.frame.size.height)!, -(button8.imageView?.frame.size.width)!, 0, 0)
        button8.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button8.titleLabel?.bounds.size.width)!)
        whiteView3.addSubview(button8)
        
        let button9 = UIButton.init(type: .custom)
        button9.frame = CGRect(x:WIDTH/2, y:0, width:WIDTH/4, height:60)
        button9.setTitleColor(UIColor.black, for: .normal)
        button9.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button9.setTitle("必买清单", for: .normal)
        button9.setImage(UIImage.init(named: "list.png"), for: .normal)
        button9.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        button9.titleEdgeInsets = UIEdgeInsetsMake((button9.imageView?.frame.size.height)!, -(button9.imageView?.frame.size.width)!, 0, 0)
        button9.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button9.titleLabel?.bounds.size.width)!)
        whiteView3.addSubview(button9)
        
        let button10 = UIButton.init(type: .custom)
        button10.frame = CGRect(x:WIDTH*3/4, y:0, width:WIDTH/4, height:60)
        button10.setTitleColor(UIColor.black, for: .normal)
        button10.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button10.setTitle("我的11.11", for: .normal)
        button10.setImage(UIImage.init(named: "double11.png"), for: .normal)
        button10.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        button10.titleEdgeInsets = UIEdgeInsetsMake((button10.imageView?.frame.size.height)!, -(button10.imageView?.frame.size.width)!, 0, 0)
        button10.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -(button10.titleLabel?.bounds.size.width)!)
        whiteView3.addSubview(button10)
        
        let horizontalLineView3 = UIView.init(frame: CGRect(x:0, y:400, width:WIDTH, height:10))
        horizontalLineView3.backgroundColor = UIColor.groupTableViewBackground
        self.scrollView.addSubview(horizontalLineView3)
        
        let whiteView4 = UIView.init(frame: CGRect(x:0, y:410, width:WIDTH, height:40))
        whiteView4.backgroundColor = UIColor.white
        self.scrollView.addSubview(whiteView4)
        
        let tableImage1 = UIImageView.init(frame: CGRect(x:10, y:10, width:20, height:20))
        tableImage1.image = UIImage.init(named: "service.png")
        whiteView4.addSubview(tableImage1)
        let tableLabel1 = UILabel.init(frame: CGRect(x:30, y:0, width:80, height:40))
        tableLabel1.font = WORDFONT
        tableLabel1.text = "我的服务"
        whiteView4.addSubview(tableLabel1)
        
        let tableLabel2 = UILabel.init(frame: CGRect(x:WIDTH-150, y:0, width:140, height:40))
        tableLabel2.font = WORDFONT
        tableLabel2.textColor = PLACEHOLODERCOLOR
        tableLabel2.textAlignment = .right
        tableLabel2.text = "预约、营业厅等 >"
        whiteView4.addSubview(tableLabel2)
        
        let horizontalLineView4 = UIView.init(frame: CGRect(x:0, y:450, width:WIDTH, height:10))
        horizontalLineView4.backgroundColor = UIColor.groupTableViewBackground
        self.scrollView.addSubview(horizontalLineView4)
        
        let whiteView5 = UIView.init(frame: CGRect(x:0, y:460, width:WIDTH, height:40))
        whiteView5.backgroundColor = UIColor.white
        self.scrollView.addSubview(whiteView5)
        
        let tableImage2 = UIImageView.init(frame: CGRect(x:10, y:10, width:20, height:20))
        tableImage2.image = UIImage.init(named: "idea.png")
        whiteView5.addSubview(tableImage2)
        let tableLabel3 = UILabel.init(frame: CGRect(x:30, y:0, width:80, height:40))
        tableLabel3.font = WORDFONT
        tableLabel3.text = "意见反馈"
        whiteView5.addSubview(tableLabel3)
        
        let tableLabel4 = UILabel.init(frame: CGRect(x:WIDTH-100, y:0, width:90, height:40))
        tableLabel4.font = WORDFONT
        tableLabel4.textColor = PLACEHOLODERCOLOR
        tableLabel4.textAlignment = .right
        tableLabel4.text = " >"
        whiteView5.addSubview(tableLabel4)
        
        let horizontalLineView5 = UIView.init(frame: CGRect(x:0, y:500, width:WIDTH, height:10))
        horizontalLineView5.backgroundColor = UIColor.groupTableViewBackground
        self.scrollView.addSubview(horizontalLineView5)
        
        let whiteView6 = UIView.init(frame: CGRect(x:0, y:510, width:WIDTH, height:40))
        whiteView6.backgroundColor = UIColor.white
        self.scrollView.addSubview(whiteView6)
        
        let tableImage3 = UIImageView.init(frame: CGRect(x:10, y:10, width:20, height:20))
        tableImage3.image = UIImage.init(named: "like.png")
        whiteView6.addSubview(tableImage3)
        let tableLabel5 = UILabel.init(frame: CGRect(x:30, y:0, width:80, height:40))
        tableLabel5.font = WORDFONT
        tableLabel5.text = "猜你喜欢"
        whiteView6.addSubview(tableLabel5)
        
        let tableLabel6 = UILabel.init(frame: CGRect(x:WIDTH-100, y:0, width:90, height:40))
        tableLabel6.font = WORDFONT
        tableLabel6.textColor = PLACEHOLODERCOLOR
        tableLabel6.textAlignment = .right
        tableLabel6.text = " >"
        whiteView6.addSubview(tableLabel6)
        
        self.scrollView.contentSize = CGSize(width:0, height:PART_H(self.scrollView)>=PART_H(whiteView6)+Y(whiteView6) ? PART_H(self.scrollView)+1 : PART_H(whiteView6)+Y(whiteView6))
    }
    
    func scanAction(button:UIButton) -> Void {
        //
    }
    
    func messageAction() -> Void {
        //
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
