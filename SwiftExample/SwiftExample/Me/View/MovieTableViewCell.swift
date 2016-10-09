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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.whiteView = UIView.init();
        self.titleLabel = UILabel.init();
        self.movieImage = UIImageView.init();
        self.rightImage = UIImageView.init();
        self.smallRightImage1 = UIImageView.init();
        self.timeLenLabel = UILabel.init();
        self.smallRightImage2 = UIImageView.init();
        self.countLabel = UILabel.init();
        self.dateLabel = UILabel.init();
        
        self.whiteView?.backgroundColor = UIColor.whiteColor()
        
        self.titleLabel?.text = "biaoti"
        self.movieImage?.image = UIImage.init(named: "meinv.jpg")
        self.rightImage?.image = UIImage.init(named: "play.png")
        self.smallRightImage1?.image = UIImage.init(named: "smallPlay.png")
        self.timeLenLabel?.text = "12:33"
        self.smallRightImage2?.image = UIImage.init(named: "smallPlay.png")
        self.countLabel?.text = "18888"
        self.dateLabel?.textAlignment = NSTextAlignment.Right
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
        self.whiteView?.frame = CGRectMake(0, 0, WIDTH, 290)
        self.titleLabel?.frame = CGRectMake(10, 0, WIDTH, 40)
        self.movieImage?.frame = CGRectMake(0, 40, WIDTH, 200)
        self.rightImage?.frame = CGRectMake(WIDTH/2-30, 100, 60, 60)
        self.smallRightImage1?.frame = CGRectMake(10, 260, 20, 20)
        self.timeLenLabel?.frame = CGRectMake(30, 260, 50, 20)
        self.smallRightImage2?.frame = CGRectMake(90, 260, 20, 20)
        self.countLabel?.frame = CGRectMake(120, 260, 50, 20)
        self.dateLabel?.frame = CGRectMake(WIDTH-100, 260, 80, 20)
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
