//
//  StoreCarTableViewCell.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/11/7.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class StoreCarTableViewCell: UITableViewCell {
    
    var chargeTypeLabel:UILabel?;
    var chargeLabel:UILabel?;
    var getFreeLabel:UILabel?;
    var choseButton:UIButton?;
    var bigImage:UIImageView?;
    var nameLabel:UILabel?;
    var colorLabel:UILabel?;
    var choseServiceLabel:UILabel?;
    var moneyLabel:UILabel?;
    var circleView:UIView?;
    var reduceButton:UIButton?;
    var countLabel:UILabel?;
    var addButton:UIButton?;
    
//    var _video : Video?
//    var video : Video?{
//        set(newVideo){
//            if (_video != newVideo) {
//                _video = newVideo;
//            }
//            self.chargeLabel?.text = newVideo?.title;
//            self.movieImage?.sd_setImage(withURL: newVideo!.cover, placeholderImage: nil, options: SDWebImageOptions.continueInBackground, completed: { (loadedImage, nil, SDImageCacheTypeDisk, imageUrl) in
//                //
//            })
//            
//            self.timeLenLabel?.text = String(newVideo!.length/60) + ":" + String(format: "%02d", newVideo!.length%60);
//            self.countLabel?.text = String(newVideo!.playCount);
//            let index = newVideo!.ptime.characters.index(newVideo!.ptime.startIndex, offsetBy: 2)
//            let index2 = newVideo!.ptime.characters.index(newVideo!.ptime.startIndex, offsetBy: 8)
//            self.dateLabel?.text = newVideo!.ptime.substring(from: index)
//            self.dateLabel?.text = self.dateLabel?.text!.substring(to: index2)
//            // 替换字符串
//            self.dateLabel?.text = self.dateLabel?.text!.replacingOccurrences(of: "-", with: "/", options: NSString.CompareOptions.literal, range: nil)
//            
//        }
//        get{
//            return self._video;
//        }
//    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.chargeTypeLabel = UILabel.init();
        self.chargeLabel = UILabel.init();
        self.getFreeLabel = UILabel.init();
        self.choseButton = UIButton.init(type: UIButtonType.system)
        self.bigImage = UIImageView.init();
        self.nameLabel = UILabel.init();
        self.colorLabel = UILabel.init();
        self.choseServiceLabel = UILabel.init();
        self.moneyLabel = UILabel.init();
        self.circleView = UIView.init();
        self.reduceButton = UIButton.init(type: UIButtonType.custom)
        self.countLabel = UILabel.init();
        self.addButton = UIButton.init(type: UIButtonType.custom)
        
        
        self.chargeTypeLabel?.textColor = UIColor.red
        self.chargeTypeLabel?.layer.masksToBounds = true;
        self.chargeTypeLabel?.layer.cornerRadius = 3;
        self.chargeTypeLabel?.layer.borderWidth = 1;//设置边界的宽度
        self.chargeTypeLabel?.font = UIFont.systemFont(ofSize: 10)
        self.chargeTypeLabel?.layer.borderColor = UIColor.red.cgColor
        self.chargeTypeLabel?.textAlignment = .center
        self.chargeTypeLabel?.text = "满减"
        self.chargeLabel?.text = "已购满99元, 可领取赠品"
        self.chargeLabel?.textColor = PLACEHOLODERCOLOR
        self.chargeLabel?.font = UIFont.systemFont(ofSize: 12)
        self.getFreeLabel?.text = "领赠品 >"
        self.getFreeLabel?.textColor = UIColor.red
        self.getFreeLabel?.font = UIFont.systemFont(ofSize: 12)
        self.choseButton?.setBackgroundImage(UIImage.init(named: "circle.png"), for: UIControlState.normal)
        self.bigImage?.image = UIImage.init(named: "meinv.jpg")
        self.nameLabel?.font = WORDFONT
        self.nameLabel?.numberOfLines = 0
        self.nameLabel?.text = "iPhone7+ 78G 玫瑰金 土豪黑 超级豪华定制版 可贵了"
        self.colorLabel?.textColor = PLACEHOLODERCOLOR
        self.colorLabel?.font = UIFont.systemFont(ofSize: 12)
        self.colorLabel?.text = "颜色:玫瑰金"
        self.choseServiceLabel?.textColor = PLACEHOLODERCOLOR
        self.choseServiceLabel?.font = UIFont.systemFont(ofSize: 12)
        self.choseServiceLabel?.text = "选服务"
        self.moneyLabel?.textColor = UIColor.red
        self.moneyLabel?.text = "¥3780.00"
        
        self.circleView?.layer.masksToBounds = true
        self.circleView?.layer.masksToBounds = true;
        self.circleView?.layer.cornerRadius = 3;
        self.circleView?.layer.borderWidth = 0.3;//设置边界的宽度
        self.circleView?.layer.borderColor = PLACEHOLODERCOLOR.cgColor
        self.reduceButton?.setTitleColor(UIColor.black, for: .normal)
        self.reduceButton?.setTitle("－", for: .normal)
        self.countLabel?.layer.borderWidth = 0.3;//设置边界的宽度
        self.countLabel?.layer.borderColor = PLACEHOLODERCOLOR.cgColor
        self.countLabel?.textAlignment = .center
        self.countLabel?.font = UIFont.systemFont(ofSize: 12)
        self.countLabel?.text = "1"
        self.addButton?.setTitleColor(UIColor.black, for: .normal)
        self.addButton?.setTitle("＋", for: .normal)
        
        self.contentView.addSubview(self.chargeTypeLabel!)
        self.contentView.addSubview(self.chargeLabel!)
        self.contentView.addSubview(self.getFreeLabel!)
        self.contentView.addSubview(self.choseButton!)
        self.contentView.addSubview(self.bigImage!)
        self.contentView.addSubview(self.nameLabel!)
        self.contentView.addSubview(self.colorLabel!)
        self.contentView.addSubview(self.choseServiceLabel!)
        self.contentView.addSubview(self.moneyLabel!)
        self.contentView.addSubview(self.circleView!)
        self.contentView.addSubview(self.reduceButton!)
        self.contentView.addSubview(self.countLabel!)
        self.contentView.addSubview(self.addButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.chargeTypeLabel?.frame = CGRect(x: 10, y: 23, width: 25, height: 14)
        self.chargeLabel?.frame = CGRect(x: 45, y: 20, width: WIDTH-110, height: 20)
        self.getFreeLabel?.frame = CGRect(x: WIDTH-60, y: 20, width: 50, height: 20)
        self.choseButton?.frame = CGRect(x: 20, y: 90, width: 20, height: 20)
        self.bigImage?.frame = CGRect(x: 50, y: 50, width: 80, height: 100)
        self.nameLabel?.frame = CGRect(x: 140, y: 50, width: WIDTH-150, height: 60)
        self.colorLabel?.frame = CGRect(x: 140, y: 110, width: 80, height: 20)
        self.choseServiceLabel?.frame = CGRect(x: WIDTH-50, y: 110, width: 40, height: 20)
        self.moneyLabel?.frame = CGRect(x: 140, y: 140, width: 100, height: 25)
        self.circleView?.frame = CGRect(x: WIDTH-105, y: 140, width: 90, height: 25)
        self.reduceButton?.frame = CGRect(x: WIDTH-105, y: 140, width: 25, height: 25)
        self.countLabel?.frame = CGRect(x: WIDTH-80, y: 140, width: 40, height: 25)
        self.addButton?.frame = CGRect(x: WIDTH-40, y: 140, width: 25, height: 25)
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
