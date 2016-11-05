//
//  StoreHomeTableViewCell5.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/19.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class StoreHomeTableViewCell5: UITableViewCell {
    
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
        
        self.backgroundColor = UIColor.groupTableViewBackground
        self.bigImage = UIImageView.init()
        self.scrollView = UIScrollView.init();
        for i in 0...13 {
            let button = UIButton.init(type: UIButtonType.custom)
            button.frame = CGRect(x: CGFloat(i%5)*WIDTH/3, y: CGFloat(i/5)*150, width: WIDTH/3, height: 150)
            button.backgroundColor = UIColor.white
            button.layer.masksToBounds = true;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = UIColor.lightGray.cgColor;
            self.scrollView?.addSubview(button)
            
            let label1 = UILabel.init(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
            label1.backgroundColor = UIColor.red
            label1.textColor = UIColor.white
            label1.font = WORDFONT
            label1.textAlignment = NSTextAlignment.center
            let tagArr = ["热门", "首发", "特卖", "大牌", "满减", "低价"]
            label1.text = tagArr[Int(arc4random()%6)];
            if arc4random()%10 >= 5 {
                button.addSubview(label1)
            }
            let label2 = UILabel.init(frame: CGRect(x: 0, y: 20, width: WIDTH/3, height: 20))
            label2.font = WORDFONT
            label2.textAlignment = NSTextAlignment.center
            label2.text = "潮流服装"
            button.addSubview(label2)
            let label3 = UILabel.init(frame: CGRect(x: 0, y: 40, width: WIDTH/3, height: 20))
            label3.textColor = PLACEHOLODERCOLOR
            label3.font = UIFont.systemFont(ofSize: 13)
            label3.textAlignment = NSTextAlignment.center
            label3.text = "秋冬新款不再寒冷"
            button.addSubview(label3)
            let aImage = UIImageView.init(frame: CGRect(x: 15, y: 60, width: WIDTH/3-30, height: 150-60))
            aImage.image = UIImage.init(named: String.init(format: "goods%ld.jpg", arc4random()%30+61))
            button.addSubview(aImage)
        }
        
        self.bigImage?.image = UIImage.init(named: "storeHeader3.jpg")
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.contentSize = CGSize(width: WIDTH/3*5+1, height: 0)
        
        self.contentView.addSubview(self.bigImage!)
        self.contentView.addSubview(self.scrollView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.bigImage?.frame = CGRect(x: 5, y: 5, width: WIDTH-10, height: 100)
        self.scrollView?.frame = CGRect(x: 0, y: 110, width: WIDTH, height: PART_H(self.contentView)-110)
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
