//
//  StoreHomeTableViewCell.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/18.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class StoreHomeTableViewCell1: UITableViewCell {
    
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
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.button1 = UIButton.init(type: UIButtonType.Custom)
        self.label1 = UILabel.init()
        self.button2 = UIButton.init(type: UIButtonType.Custom)
        self.label2 = UILabel.init()
        self.button3 = UIButton.init(type: UIButtonType.Custom)
        self.label3 = UILabel.init()
        self.button4 = UIButton.init(type: UIButtonType.Custom)
        self.label4 = UILabel.init()
        self.button5 = UIButton.init(type: UIButtonType.Custom)
        self.label5 = UILabel.init()
        self.button6 = UIButton.init(type: UIButtonType.Custom)
        self.label6 = UILabel.init()
        self.button7 = UIButton.init(type: UIButtonType.Custom)
        self.label7 = UILabel.init()
        self.button8 = UIButton.init(type: UIButtonType.Custom)
        self.label8 = UILabel.init()
        
        self.button1?.clipsToBounds = true
        self.button1?.layer.cornerRadius = 20;
        self.button1?.backgroundColor = DARKRED
        self.button1?.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        self.button1?.setImage(UIImage.init(named: "love.png"), forState: UIControlState.Normal)
        self.label1?.font = UIFont.systemFontOfSize(12)
        self.label1?.textColor = PLACEHOLODERCOLOR
        self.label1?.textAlignment = NSTextAlignment.Center
        self.label1?.text = "我的关注"
        self.button2?.clipsToBounds = true
        self.button2?.layer.cornerRadius = 20;
        self.button2?.backgroundColor = RGBA(118, g: 189, b: 61, a: 1)
        self.button2?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button2?.setImage(UIImage.init(named: "logistics.png"), forState: UIControlState.Normal)
        self.label2?.font = UIFont.systemFontOfSize(12)
        self.label2?.textColor = PLACEHOLODERCOLOR
        self.label2?.textAlignment = NSTextAlignment.Center
        self.label2?.text = "物流查询"
        self.button3?.clipsToBounds = true
        self.button3?.layer.cornerRadius = 20;
        self.button3?.backgroundColor = RGBA(255, g: 178, b: 32, a: 1)
        self.button3?.imageEdgeInsets = UIEdgeInsetsMake(5, 9, 5, 9);
        self.button3?.setImage(UIImage.init(named: "bill.png"), forState: UIControlState.Normal)
        self.label3?.font = UIFont.systemFontOfSize(12)
        self.label3?.textColor = PLACEHOLODERCOLOR
        self.label3?.textAlignment = NSTextAlignment.Center
        self.label3?.text = "充值"
        self.button4?.clipsToBounds = true
        self.button4?.layer.cornerRadius = 20;
        self.button4?.backgroundColor = RGBA(255, g: 178, b: 32, a: 1)
        self.button4?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button4?.setImage(UIImage.init(named: "tuan.png"), forState: UIControlState.Normal)
        self.label4?.font = UIFont.systemFontOfSize(12)
        self.label4?.textColor = PLACEHOLODERCOLOR
        self.label4?.textAlignment = NSTextAlignment.Center
        self.label4?.text = "生活团购"
        self.button5?.clipsToBounds = true
        self.button5?.layer.cornerRadius = 20;
        self.button5?.backgroundColor = RGBA(86, g: 177, b: 234, a: 1)
        self.button5?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button5?.setImage(UIImage.init(named: "start.png"), forState: UIControlState.Normal)
        self.label5?.font = UIFont.systemFontOfSize(12)
        self.label5?.textColor = PLACEHOLODERCOLOR
        self.label5?.textAlignment = NSTextAlignment.Center
        self.label5?.text = "电影票"
        self.button6?.clipsToBounds = true
        self.button6?.layer.cornerRadius = 20;
        self.button6?.backgroundColor = RGBA(241, g: 83, b: 83, a: 1)
        self.button6?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button6?.setImage(UIImage.init(named: "savings.png"), forState: UIControlState.Normal)
        self.label6?.font = UIFont.systemFontOfSize(12)
        self.label6?.textColor = PLACEHOLODERCOLOR
        self.label6?.textAlignment = NSTextAlignment.Center
        self.label6?.text = "惠赚钱"
        self.button7?.clipsToBounds = true
        self.button7?.layer.cornerRadius = 20;
        self.button7?.backgroundColor = RGBA(141, g: 133, b: 238, a: 1)
        self.button7?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.button7?.setImage(UIImage.init(named: "dou.png"), forState: UIControlState.Normal)
        self.label7?.font = UIFont.systemFontOfSize(12)
        self.label7?.textColor = PLACEHOLODERCOLOR
        self.label7?.textAlignment = NSTextAlignment.Center
        self.label7?.text = "签到领京豆"
        self.button8?.clipsToBounds = true
        self.button8?.layer.cornerRadius = 20;
        self.button8?.backgroundColor = RGBA(187, g: 190, b: 194, a: 1)
        self.button8?.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        self.button8?.setImage(UIImage.init(named: "allGoods.png"), forState: UIControlState.Normal)
        self.label8?.font = UIFont.systemFontOfSize(12)
        self.label8?.textColor = PLACEHOLODERCOLOR
        self.label8?.textAlignment = NSTextAlignment.Center
        self.label8?.text = "全部"
        
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.button1?.frame = CGRectMake(WIDTH/8-25, PART_H(self.contentView)/4-40, 50, 50)
        self.label1?.frame = CGRectMake(0, Y(self.button1!)+PART_H(self.button1!), WIDTH/4, 20)
        self.button2?.frame = CGRectMake(WIDTH/8-25+WIDTH/4, PART_H(self.contentView)/4-40, 50, 50)
        self.label2?.frame = CGRectMake(WIDTH/4, Y(self.button2!)+PART_H(self.button2!), WIDTH/4, 20)
        self.button3?.frame = CGRectMake(WIDTH/8-25+WIDTH/2, PART_H(self.contentView)/4-40, 50, 50)
        self.label3?.frame = CGRectMake(WIDTH/2, Y(self.button3!)+PART_H(self.button3!), WIDTH/4, 20)
        self.button4?.frame = CGRectMake(WIDTH/8-25+WIDTH*3/4, PART_H(self.contentView)/4-40, 50, 50)
        self.label4?.frame = CGRectMake(WIDTH*3/4, Y(self.button4!)+PART_H(self.button4!), WIDTH/4, 20)
        
        self.button5?.frame = CGRectMake(WIDTH/8-25, PART_H(self.contentView)*3/4-65, 50, 50)
        self.label5?.frame = CGRectMake(0, Y(self.button5!)+PART_H(self.button5!), WIDTH/4, 20)
        self.button6?.frame = CGRectMake(WIDTH/8-25+WIDTH/4, PART_H(self.contentView)*3/4-65, 50, 50)
        self.label6?.frame = CGRectMake(WIDTH/4, Y(self.button6!)+PART_H(self.button6!), WIDTH/4, 20)
        self.button7?.frame = CGRectMake(WIDTH/8-25+WIDTH/2, PART_H(self.contentView)*3/4-65, 50, 50)
        self.label7?.frame = CGRectMake(WIDTH/2, Y(self.button7!)+PART_H(self.button7!), WIDTH/4, 20)
        self.button8?.frame = CGRectMake(WIDTH/8-25+WIDTH*3/4, PART_H(self.contentView)*3/4-65, 50, 50)
        self.label8?.frame = CGRectMake(WIDTH*3/4, Y(self.button8!)+PART_H(self.button8!), WIDTH/4, 20)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
