//
//  StoreHomeTableViewCell4.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/19.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class StoreHomeTableViewCell4: UITableViewCell {
    
    var bigImage:UIImageView?;
    
    var _video : Video?
    var video : Video?{
        set(newVideo){
            if (_video != newVideo) {
                _video = newVideo;
            }
            self.bigImage?.sd_setImageWithURL(newVideo!.cover, placeholderImage: nil, completed: { (loadedImage, nil, SDImageCacheTypeDisk, imageUrl) in
                //
            })
        }
        get{
            return self._video;
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.bigImage = UIImageView.init();
        self.bigImage?.image = UIImage.init(named: "meinv.jpg")
        self.contentView.addSubview(self.bigImage!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.bigImage?.frame = CGRectMake(0, 0, WIDTH, PART_H(self.contentView))
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
