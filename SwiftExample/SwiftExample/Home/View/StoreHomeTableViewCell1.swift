//
//  StoreHomeTableViewCell.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/18.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class StoreHomeTableViewCell1: UITableViewCell, CAAnimationDelegate {
    
    var button1:UIButton?;
    var label1:UILabel?;
    var button2:UIButton?;
    var label2:UILabel?;
    var button3:UIButton?;
    var label3:UILabel?;
    var button4:UIButton?;
    var label4:UILabel?;
    var button5:UIButton?;
    var label5:UILabel?;
    var button6:UIButton?;
    var label6:UILabel?;
    var button7:UIButton?;
    var label7:UILabel?;
    var button8:UIButton?;
    var label8:UILabel?;
    var whiteView:UIView?;
    var newsArr = ["国行版iPhone7现货发行", "多种品牌正品球鞋满足你的需求", "秋冬新款羽绒夹克火热来袭", "进口零食让你爱不释手"]
    var countInt = 0
    var newsView:NewsView?;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.groupTableViewBackground
        self.button1 = UIButton.init(type: UIButtonType.custom)
        self.label1 = UILabel.init()
        self.button2 = UIButton.init(type: UIButtonType.custom)
        self.label2 = UILabel.init()
        self.button3 = UIButton.init(type: UIButtonType.custom)
        self.label3 = UILabel.init()
        self.button4 = UIButton.init(type: UIButtonType.custom)
        self.label4 = UILabel.init()
        self.button5 = UIButton.init(type: UIButtonType.custom)
        self.label5 = UILabel.init()
        self.button6 = UIButton.init(type: UIButtonType.custom)
        self.label6 = UILabel.init()
        self.button7 = UIButton.init(type: UIButtonType.custom)
        self.label7 = UILabel.init()
        self.button8 = UIButton.init(type: UIButtonType.custom)
        self.label8 = UILabel.init()
        self.whiteView = UIView.init()
        self.newsView = NewsView.init(frame: CGRect(x: 10, y: PART_H(self.contentView) - 40, width: WIDTH - 20, height: 30))
        
        self.button1?.clipsToBounds = true
        self.button1?.layer.cornerRadius = 20;
        self.button1?.backgroundColor = DARKRED
        self.button1?.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        self.button1?.setImage(UIImage.init(named: "love.png"), for: UIControlState())
        self.label1?.font = UIFont.systemFont(ofSize: 12)
        self.label1?.textAlignment = NSTextAlignment.center
        self.label1?.text = "我的关注"
        self.button2?.clipsToBounds = true
        self.button2?.layer.cornerRadius = 20;
        self.button2?.backgroundColor = RGBA(118, g: 189, b: 61, a: 1)
        self.button2?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button2?.setImage(UIImage.init(named: "logistics.png"), for: UIControlState())
        self.label2?.font = UIFont.systemFont(ofSize: 12)
        self.label2?.textAlignment = NSTextAlignment.center
        self.label2?.text = "物流查询"
        self.button3?.clipsToBounds = true
        self.button3?.layer.cornerRadius = 20;
        self.button3?.backgroundColor = RGBA(255, g: 178, b: 32, a: 1)
        self.button3?.imageEdgeInsets = UIEdgeInsetsMake(5, 9, 5, 9);
        self.button3?.setImage(UIImage.init(named: "bill.png"), for: UIControlState())
        self.label3?.font = UIFont.systemFont(ofSize: 12)
        self.label3?.textAlignment = NSTextAlignment.center
        self.label3?.text = "充值"
        self.button4?.clipsToBounds = true
        self.button4?.layer.cornerRadius = 20;
        self.button4?.backgroundColor = RGBA(255, g: 178, b: 32, a: 1)
        self.button4?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button4?.setImage(UIImage.init(named: "tuan.png"), for: UIControlState())
        self.label4?.font = UIFont.systemFont(ofSize: 12)
        self.label4?.textAlignment = NSTextAlignment.center
        self.label4?.text = "生活团购"
        self.button5?.clipsToBounds = true
        self.button5?.layer.cornerRadius = 20;
        self.button5?.backgroundColor = RGBA(86, g: 177, b: 234, a: 1)
        self.button5?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button5?.setImage(UIImage.init(named: "start.png"), for: UIControlState())
        self.label5?.font = UIFont.systemFont(ofSize: 12)
        self.label5?.textAlignment = NSTextAlignment.center
        self.label5?.text = "电影票"
        self.button6?.clipsToBounds = true
        self.button6?.layer.cornerRadius = 20;
        self.button6?.backgroundColor = RGBA(241, g: 83, b: 83, a: 1)
        self.button6?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button6?.setImage(UIImage.init(named: "savings.png"), for: UIControlState())
        self.label6?.font = UIFont.systemFont(ofSize: 12)
        self.label6?.textAlignment = NSTextAlignment.center
        self.label6?.text = "惠赚钱"
        self.button7?.clipsToBounds = true
        self.button7?.layer.cornerRadius = 20;
        self.button7?.backgroundColor = RGBA(141, g: 133, b: 238, a: 1)
        self.button7?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button7?.setImage(UIImage.init(named: "dou.png"), for: UIControlState())
        self.label7?.font = UIFont.systemFont(ofSize: 12)
        self.label7?.textAlignment = NSTextAlignment.center
        self.label7?.text = "签到领京豆"
        self.button8?.clipsToBounds = true
        self.button8?.layer.cornerRadius = 20;
        self.button8?.backgroundColor = RGBA(187, g: 190, b: 194, a: 1)
        self.button8?.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        self.button8?.setImage(UIImage.init(named: "allGoods.png"), for: UIControlState())
        self.label8?.font = UIFont.systemFont(ofSize: 12)
        self.label8?.textAlignment = NSTextAlignment.center
        self.label8?.text = "全部"
        self.whiteView?.backgroundColor = UIColor.white
        self.newsView?.titleLabel.textAlignment = NSTextAlignment.center
        self.newsView?.titleLabel.text = self.newsArr[0]
        UIView.animate(withDuration: 0.7, delay: 0, options: UIViewAnimationOptions.layoutSubviews, animations: { 
            self.newsView?.alpha = 0.2
            self.newsView?.exchangeSubview(at: 1, withSubviewAt: 0)
            self.newsView?.alpha = 1
            }) { (finished) in
                Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(StoreHomeTableViewCell1.displayNews), userInfo: nil, repeats: true)
        }
        
        self.contentView.addSubview(self.button1!)
        self.contentView.addSubview(self.label1!)
        self.contentView.addSubview(self.button2!)
        self.contentView.addSubview(self.label2!)
        self.contentView.addSubview(self.button3!)
        self.contentView.addSubview(self.label3!)
        self.contentView.addSubview(self.button4!)
        self.contentView.addSubview(self.label4!)
        self.contentView.addSubview(self.button5!)
        self.contentView.addSubview(self.label5!)
        self.contentView.addSubview(self.button6!)
        self.contentView.addSubview(self.label6!)
        self.contentView.addSubview(self.button7!)
        self.contentView.addSubview(self.label7!)
        self.contentView.addSubview(self.button8!)
        self.contentView.addSubview(self.label8!)
        self.contentView.addSubview(self.whiteView!)
        self.contentView.addSubview(self.newsView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.button1?.frame = CGRect(x: WIDTH/8-25, y: PART_H(self.contentView)/4-40, width: 50, height: 50)
        self.label1?.frame = CGRect(x: 0, y: Y(self.button1!)+PART_H(self.button1!), width: WIDTH/4, height: 20)
        self.button2?.frame = CGRect(x: WIDTH/8-25+WIDTH/4, y: PART_H(self.contentView)/4-40, width: 50, height: 50)
        self.label2?.frame = CGRect(x: WIDTH/4, y: Y(self.button2!)+PART_H(self.button2!), width: WIDTH/4, height: 20)
        self.button3?.frame = CGRect(x: WIDTH/8-25+WIDTH/2, y: PART_H(self.contentView)/4-40, width: 50, height: 50)
        self.label3?.frame = CGRect(x: WIDTH/2, y: Y(self.button3!)+PART_H(self.button3!), width: WIDTH/4, height: 20)
        self.button4?.frame = CGRect(x: WIDTH/8-25+WIDTH*3/4, y: PART_H(self.contentView)/4-40, width: 50, height: 50)
        self.label4?.frame = CGRect(x: WIDTH*3/4, y: Y(self.button4!)+PART_H(self.button4!), width: WIDTH/4, height: 20)
        
        self.button5?.frame = CGRect(x: WIDTH/8-25, y: PART_H(self.contentView)*3/4-65, width: 50, height: 50)
        self.label5?.frame = CGRect(x: 0, y: Y(self.button5!)+PART_H(self.button5!), width: WIDTH/4, height: 20)
        self.button6?.frame = CGRect(x: WIDTH/8-25+WIDTH/4, y: PART_H(self.contentView)*3/4-65, width: 50, height: 50)
        self.label6?.frame = CGRect(x: WIDTH/4, y: Y(self.button6!)+PART_H(self.button6!), width: WIDTH/4, height: 20)
        self.button7?.frame = CGRect(x: WIDTH/8-25+WIDTH/2, y: PART_H(self.contentView)*3/4-65, width: 50, height: 50)
        self.label7?.frame = CGRect(x: WIDTH/2, y: Y(self.button7!)+PART_H(self.button7!), width: WIDTH/4, height: 20)
        self.button8?.frame = CGRect(x: WIDTH/8-25+WIDTH*3/4, y: PART_H(self.contentView)*3/4-65, width: 50, height: 50)
        self.label8?.frame = CGRect(x: WIDTH*3/4, y: Y(self.button8!)+PART_H(self.button8!), width: WIDTH/4, height: 20)
        self.whiteView?.frame = CGRect(x: 10, y: PART_H(self.contentView) - 45, width: WIDTH - 20, height: 35)
        self.newsView?.frame = CGRect(x: 10, y: PART_H(self.contentView) - 40, width: WIDTH - 20, height: 30)
    }
    
    func displayNews() -> Void {
        //
        self.countInt += 1
        if self.countInt >= self.newsArr.count {
            self.countInt = 0
        }
        let animation = CATransition.init()
        animation.delegate = self
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut) // UIViewAnimationCurve.EaseInOut;
        animation.fillMode = kCAFillModeForwards;
        animation.isRemovedOnCompletion = true;
        animation.type = "cube";
        newsView?.layer.add(animation, forKey: "animationID")
        newsView?.setViewWithTitle(self.newsArr[self.countInt], description: "test")
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
