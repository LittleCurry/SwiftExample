//
//  StoreHomeTableViewCell6.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/19.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class StoreHomeTableViewCell6: UITableViewCell {
    
    var scrollView : UIScrollView?;
    var bigImage : UIImageView?;
    var label1 : UILabel?
    var label2 : UILabel?
    var label3 : UILabel?
    var label4 : UILabel?
    var label5 : UILabel?
    var label6 : UILabel?
    var label7 : UILabel?
    var label8 : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.bigImage = UIImageView.init()
        self.scrollView = UIScrollView.init();
        for i in 0...29 {
            let button = UIButton.init(type: UIButtonType.Custom)
            button.frame = CGRectMake(CGFloat(i%10)*WIDTH/3, CGFloat(i/10)*150, WIDTH/3, 150)
            button.backgroundColor = UIColor.whiteColor()
            button.layer.masksToBounds = true;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = UIColor.lightGrayColor().CGColor;
            self.scrollView?.addSubview(button)
            
            let label1 = UILabel.init(frame: CGRectMake(0, 0, 40, 20))
            label1.backgroundColor = UIColor.redColor()
            label1.textColor = UIColor.whiteColor()
            label1.font = WORDFONT
            label1.textAlignment = NSTextAlignment.Center
            let tagArr = ["热门", "首发", "特卖", "大牌", "满减", "低价"]
            label1.text = tagArr[Int(arc4random()%6)];
            if arc4random()%10 >= 5 {
                button.addSubview(label1)
            }
            let label2 = UILabel.init(frame: CGRectMake(0, 20, WIDTH/3, 20))
            label2.font = WORDFONT
            label2.textAlignment = NSTextAlignment.Center
            label2.text = "美味零食"
            button.addSubview(label2)
            let label3 = UILabel.init(frame: CGRectMake(0, 40, WIDTH/3, 20))
            label3.textColor = PLACEHOLODERCOLOR
            label3.font = UIFont.systemFontOfSize(13)
            label3.textAlignment = NSTextAlignment.Center
            label3.text = "进口零食爱不释手"
            button.addSubview(label3)
            let aImage = UIImageView.init(frame: CGRectMake(15, 60, WIDTH/3-30, 150-60))
            aImage.image = UIImage.init(named: String.init(format: "goods%ld.jpg", arc4random()%30+91))
            button.addSubview(aImage)
        }
        
        self.bigImage?.image = UIImage.init(named: "storeHeader4.jpg")
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.contentSize = CGSizeMake(WIDTH/3*10+1, 0)
        
        self.contentView.addSubview(self.bigImage!)
        self.contentView.addSubview(self.scrollView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.bigImage?.frame = CGRectMake(5, 5, WIDTH-10, 100)
        self.scrollView?.frame = CGRectMake(0, 110, WIDTH, PART_H(self.contentView)-110)
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
