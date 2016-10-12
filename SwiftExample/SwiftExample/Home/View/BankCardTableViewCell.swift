//
//  BankCardTableViewCell.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/11.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class BankCardTableViewCell: UITableViewCell {
    var bigView:UIView?;
    var cardImageView:UIImageView?;
    var numberLabel:UILabel?;
    
    var _bankCard : BankCard?
    var bankCard : BankCard?{
        set(newBankCard){
            if (_bankCard != newBankCard) {
                _bankCard = newBankCard;
            }
            self.cardImageView?.sd_setImageWithURL("https://apimg.alipay.com/combo.png?d=cashier&t="+(newBankCard?.org)!, completed: { (loadImage, error, cacheType, imageURL) in
                
                let subImage = loadImage.subImageInRect(CGRectMake(5, 5, 20, 20))
                self.bigView?.backgroundColor = subImage.mostColor()
                self.cardImageView?.image = loadImage.changeImageWithTintColor(subImage.mostColor(), blendMode: CGBlendMode.Multiply)
            })
            let index = newBankCard!.number.startIndex.advancedBy(newBankCard!.number.characters.count - 4)
            self.numberLabel!.text = "****  ****  ****  " + (newBankCard?.number.substringFromIndex(index))!
            
        }
        get{
            return self._bankCard;
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.bigView = UIView.init();
        self.cardImageView = UIImageView.init();
        self.numberLabel = UILabel.init();
        
        self.bigView!.clipsToBounds = true;
        self.bigView!.layer.cornerRadius = 5;
        self.numberLabel!.textColor = UIColor.whiteColor()
        self.numberLabel!.textAlignment = NSTextAlignment.Right
        self.numberLabel!.font = UIFont.systemFontOfSize(20)
        
        self.contentView.addSubview(self.bigView!)
        self.contentView.addSubview(self.cardImageView!)
        self.contentView.addSubview(self.numberLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.bigView!.frame = CGRectMake(10, 5, WIDTH-20, PART_H(self.contentView)-10);
        self.cardImageView!.frame = CGRectMake(30, 30, 126, 36);
        self.numberLabel!.frame = CGRectMake(WIDTH - 260, PART_H(self.contentView)-50, 240, 30);
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
