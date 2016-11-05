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
        self.myTextLabel!.textColor = UIColor.white
        self.myTextLabel?.clipsToBounds = true
        self.myTextLabel?.layer.cornerRadius = 5
        self.myTextLabel!.textAlignment = NSTextAlignment.center
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
        self.pinView!.frame = CGRect(x: WIDTH-60, y: 20, width: 10, height: 10);
        var rect = CGRect(x: 0, y: 0, width: 0, height: 0)
        if (self.myTextLabel?.attributedText) != nil {
            rect = (self.myTextLabel?.attributedText!.boundingRect(with: CGSize(width: WIDTH-80, height: 10000), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil))!
        }
        var cellH:CGFloat = 0
        cellH = rect.size.height > 40.0 ? rect.size.height : 40.0
        self.myTextLabel!.frame = CGRect(x: 20, y: 5, width: WIDTH-80, height: cellH);
        self.headImageView!.frame = CGRect(x: WIDTH - 50, y: 5, width: 40, height: 40);
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
