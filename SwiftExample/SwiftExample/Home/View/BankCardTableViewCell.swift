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
            self.cardImageView?.sd_setImage(withURL: "https://apimg.alipay.com/combo.png?d=cashier&t="+(newBankCard?.org)!, completed: { (loadImage, error, cacheType, imageURL) in
                
                let subImage = loadImage?.subImage(in: CGRect(x: 5, y: 5, width: 20, height: 20))
                self.bigView?.backgroundColor = subImage?.mostColor()
                self.cardImageView?.image = loadImage?.change(withTintColor: subImage?.mostColor(), blendMode: CGBlendMode.multiply)
            })
            let index = newBankCard!.number.characters.index(newBankCard!.number.startIndex, offsetBy: newBankCard!.number.characters.count - 4)
            self.numberLabel!.text = "****  ****  ****  " + (newBankCard?.number.substring(from: index))!
            
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
        self.numberLabel!.textColor = UIColor.white
        self.numberLabel!.textAlignment = NSTextAlignment.right
        self.numberLabel!.font = UIFont.systemFont(ofSize: 20)
        
        self.contentView.addSubview(self.bigView!)
        self.contentView.addSubview(self.cardImageView!)
        self.contentView.addSubview(self.numberLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.bigView!.frame = CGRect(x: 10, y: 5, width: WIDTH-20, height: PART_H(self.contentView)-10);
        self.cardImageView!.frame = CGRect(x: 30, y: 30, width: 126, height: 36);
        self.numberLabel!.frame = CGRect(x: WIDTH - 260, y: PART_H(self.contentView)-50, width: 240, height: 30);
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
