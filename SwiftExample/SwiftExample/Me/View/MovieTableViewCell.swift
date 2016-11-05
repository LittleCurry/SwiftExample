//
//  MovieTableViewCell.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/8.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    var whiteView:UIView?;
    var titleLabel:UILabel?;
    var movieImage:UIImageView?;
    var rightImage:UIImageView?;
    var smallRightImage1:UIImageView?;
    var timeLenLabel:UILabel?;
    var smallRightImage2:UIImageView?;
    var countLabel:UILabel?;
    var dateLabel:UILabel?;
    
    var _video : Video?
    var video : Video?{
        set(newVideo){
            if (_video != newVideo) {
                _video = newVideo;
            }
            self.titleLabel?.text = newVideo?.title;
            self.movieImage?.sd_setImage(withURL: newVideo!.cover, placeholderImage: nil, options: SDWebImageOptions.continueInBackground, completed: { (loadedImage, nil, SDImageCacheTypeDisk, imageUrl) in
                //
            })
            
            self.timeLenLabel?.text = String(newVideo!.length/60) + ":" + String(format: "%02d", newVideo!.length%60);
            self.countLabel?.text = String(newVideo!.playCount);
            let index = newVideo!.ptime.characters.index(newVideo!.ptime.startIndex, offsetBy: 2)
            let index2 = newVideo!.ptime.characters.index(newVideo!.ptime.startIndex, offsetBy: 8)
            self.dateLabel?.text = newVideo!.ptime.substring(from: index)
            self.dateLabel?.text = self.dateLabel?.text!.substring(to: index2)
            // 替换字符串
            self.dateLabel?.text = self.dateLabel?.text!.replacingOccurrences(of: "-", with: "/", options: NSString.CompareOptions.literal, range: nil)
            
        }
        get{
            return self._video;
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.whiteView = UIView.init();
        self.titleLabel = UILabel.init();
        self.movieImage = UIImageView.init();
        self.rightImage = UIImageView.init();
        self.smallRightImage1 = UIImageView.init();
        self.timeLenLabel = UILabel.init();
        self.smallRightImage2 = UIImageView.init();
        self.countLabel = UILabel.init();
        self.dateLabel = UILabel.init();
        
        self.whiteView?.backgroundColor = UIColor.white
        
        self.titleLabel?.text = "标题"
        self.movieImage?.image = UIImage.init(named: "meinv.jpg")
        self.rightImage?.image = UIImage.init(named: "play.png")?.change(with: UIColor.white)
        self.smallRightImage1?.image = UIImage.init(named: "smallPlay.png")
        self.timeLenLabel?.font = UIFont.systemFont(ofSize: 13)
        self.timeLenLabel?.textColor = UIColor.lightGray
        self.timeLenLabel?.text = "12:33"
        self.smallRightImage2?.image = UIImage.init(named: "smallPlay.png")
        self.countLabel?.font = UIFont.systemFont(ofSize: 13)
        self.countLabel?.textColor = UIColor.lightGray
        self.countLabel?.text = "538"
        self.dateLabel?.textAlignment = NSTextAlignment.right
        self.dateLabel?.font = UIFont.systemFont(ofSize: 13)
        self.dateLabel?.textColor = UIColor.lightGray
        self.dateLabel?.text = "16/09/05"
        
        self.contentView.addSubview(self.whiteView!)
        self.contentView.addSubview(self.titleLabel!)
        self.contentView.addSubview(self.movieImage!)
        self.contentView.addSubview(self.rightImage!)
        self.contentView.addSubview(self.smallRightImage1!)
        self.contentView.addSubview(self.timeLenLabel!)
        self.contentView.addSubview(self.smallRightImage2!)
        self.contentView.addSubview(self.countLabel!)
        self.contentView.addSubview(self.dateLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.whiteView?.frame = CGRect(x: 0, y: 0, width: WIDTH, height: 290)
        self.titleLabel?.frame = CGRect(x: 5, y: 0, width: WIDTH-10, height: 40)
        self.movieImage?.frame = CGRect(x: 0, y: 40, width: WIDTH, height: 210)
        self.rightImage?.frame = CGRect(x: WIDTH/2-30, y: 115, width: 60, height: 60)
        self.smallRightImage1?.frame = CGRect(x: 5, y: 260, width: 20, height: 20)
        self.timeLenLabel?.frame = CGRect(x: 25, y: 260, width: 50, height: 20)
        self.smallRightImage2?.frame = CGRect(x: 90, y: 260, width: 20, height: 20)
        self.countLabel?.frame = CGRect(x: 120, y: 260, width: 50, height: 20)
        self.dateLabel?.frame = CGRect(x: WIDTH-90, y: 260, width: 80, height: 20)
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
