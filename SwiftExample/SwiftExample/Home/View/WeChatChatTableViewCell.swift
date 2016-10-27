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
    var pinView:ThreepinView?;
    var headImageView:UIImageView?;
    
    var _chat : Chat?
    var chat : Chat?{
        set(newChat){
            if (_chat != newChat) {
                _chat = newChat;
            }
            self.myTextLabel?.attributedText = newChat!.chatText
            self.headImageView?.image = UIImage.init(named: "jigsaw.jpg")
        }
        get{
            return self._chat;
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.pinView = ThreepinView.init()
        self.myTextLabel = UILabel.init();
        self.headImageView = UIImageView.init();
        
        self.myTextLabel?.backgroundColor = RGBA(0, g: 207, b: 13, a: 1)
        self.myTextLabel!.textColor = UIColor.whiteColor()
        self.myTextLabel?.clipsToBounds = true
        self.myTextLabel?.layer.cornerRadius = 5
        self.myTextLabel!.textAlignment = NSTextAlignment.Center
        self.myTextLabel!.font = WORDFONT
        self.myTextLabel?.numberOfLines = 0
        
        self.contentView.addSubview(self.pinView!)
        self.contentView.addSubview(self.myTextLabel!)
        self.contentView.addSubview(self.headImageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.pinView!.frame = CGRectMake(WIDTH-60, 20, 10, 10);
        var rect = CGRectMake(0, 0, 0, 0)
        if (self.myTextLabel?.attributedText) != nil {
            rect = (self.myTextLabel?.attributedText!.boundingRectWithSize(CGSizeMake(WIDTH-80, 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil))!
        }
        var cellH:CGFloat = 0
        cellH = rect.size.height > 40.0 ? rect.size.height : 40.0
        self.myTextLabel!.frame = CGRectMake(20, 5, WIDTH-80, cellH);
        self.headImageView!.frame = CGRectMake(WIDTH - 50, 5, 40, 40);
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
