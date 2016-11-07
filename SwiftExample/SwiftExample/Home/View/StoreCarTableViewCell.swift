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
        self.reduceButton = UIButton.init(type: UIButtonType.system)
        self.countLabel = UILabel.init();
        self.addButton = UIButton.init(type: UIButtonType.system)
        
        
        self.chargeTypeLabel?.text = "满减"
        self.chargeTypeLabel?.textColor = UIColor.red
        self.chargeTypeLabel?.layer.masksToBounds = true;
        self.chargeTypeLabel?.layer.cornerRadius = 3;
        self.chargeTypeLabel?.layer.borderWidth = 0.5;//设置边界的宽度
        self.chargeTypeLabel?.font = UIFont.systemFont(ofSize: 10)
        self.chargeTypeLabel?.layer.borderColor = UIColor.red.cgColor
        self.chargeLabel?.text = "已购满99元, 可领取赠品"
        self.chargeLabel?.textColor = PLACEHOLODERCOLOR
        self.chargeLabel?.font = UIFont.systemFont(ofSize: 12)
        self.getFreeLabel?.text = "领赠品＞"
        self.getFreeLabel?.textColor = UIColor.red
        self.getFreeLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addButton?.setBackgroundImage(UIImage.init(named: "add.png"), for: UIControlState.normal)
        self.bigImage?.image = UIImage.init(named: "meinv.jpg")
        self.nameLabel?.text = "iPhone7+ 78G 玫瑰金 土豪黑"
        self.colorLabel?.text = "颜色:玫瑰金"
        self.colorLabel?.textColor = PLACEHOLODERCOLOR
        self.colorLabel?.font = UIFont.systemFont(ofSize: 12)
        self.choseServiceLabel?.textColor = PLACEHOLODERCOLOR
        self.choseServiceLabel?.text = "选服务"
        self.moneyLabel?.text = "¥3780.00"
        self.reduceButton?.setTitle("－", for: .normal)
        self.countLabel?.font = UIFont.systemFont(ofSize: 12)
        self.countLabel?.text = "1"
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
        self.contentView.addSubview(self.reduceButton!)
        self.contentView.addSubview(self.countLabel!)
        self.contentView.addSubview(self.addButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.chargeTypeLabel?.frame = CGRect(x: 5, y: 5, width: 22, height: 10)
        self.chargeLabel?.frame = CGRect(x: 30, y: 5, width: WIDTH-80, height: 20)
        self.getFreeLabel?.frame = CGRect(x: WIDTH-60, y: 5, width: 50, height: 20)
        self.choseButton?.frame = CGRect(x: 20, y: 55, width: 20, height: 20)
        self.bigImage?.frame = CGRect(x: 50, y: 25, width: 80, height: 100)
        self.nameLabel?.frame = CGRect(x: 140, y: 5, width: WIDTH-150, height: 60)
        self.colorLabel?.frame = CGRect(x: 140, y: 65, width: 60, height: 20)
        self.choseServiceLabel?.frame = CGRect(x: WIDTH-50, y: 65, width: 40, height: 20)
        self.moneyLabel?.frame = CGRect(x: 140, y: 65, width: 100, height: 30)
        self.reduceButton?.frame = CGRect(x: WIDTH-130, y: 65, width: 30, height: 30)
        self.countLabel?.frame = CGRect(x: WIDTH-100, y: 65, width: 40, height: 30)
        self.addButton?.frame = CGRect(x: WIDTH-40, y: 65, width: 30, height: 30)
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
