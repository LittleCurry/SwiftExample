//
//  WeChatChatTableViewCell.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/25.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class WeChatChatTableViewCell: UITableViewCell {
    var myTextLabel:UILabel?;
    var pinView:UIView?;
    
//    var _bankCard : BankCard?
//    var bankCard : BankCard?{
//        set(newBankCard){
//            if (_bankCard != newBankCard) {
//                _bankCard = newBankCard;
//            }
//            self.cardImageView?.sd_setImageWithURL("https://apimg.alipay.com/combo.png?d=cashier&t="+(newBankCard?.org)!, completed: { (loadImage, error, cacheType, imageURL) in
//                
//                let subImage = loadImage.subImageInRect(CGRectMake(5, 5, 20, 20))
//                self.bigView?.backgroundColor = subImage.mostColor()
//                self.cardImageView?.image = loadImage.changeImageWithTintColor(subImage.mostColor(), blendMode: CGBlendMode.Multiply)
//            })
//            let index = newBankCard!.number.startIndex.advancedBy(newBankCard!.number.characters.count - 4)
//            self.myTextLabel!.text = "****  ****  ****  " + (newBankCard?.number.substringFromIndex(index))!
//            
//        }
//        get{
//            return self._bankCard;
//        }
//    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.pinView = UIView.init();
        self.myTextLabel = UILabel.init();
        
        self.pinView!.clipsToBounds = true;
        self.pinView!.layer.cornerRadius = 5;
        self.myTextLabel!.textColor = UIColor.whiteColor()
        self.myTextLabel!.textAlignment = NSTextAlignment.Right
        self.myTextLabel!.font = UIFont.systemFontOfSize(20)
        
        self.contentView.addSubview(self.pinView!)
        self.contentView.addSubview(self.myTextLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.pinView!.frame = CGRectMake(10, 5, WIDTH-20, PART_H(self.contentView)-10);
        self.myTextLabel!.frame = CGRectMake(WIDTH - 260, PART_H(self.contentView)-50, 240, 30);
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
