//
//  OneGoodsClassCollectionViewCell.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/11/1.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class OneGoodsClassCollectionViewCell: UICollectionViewCell {
    var photoImage:UIImageView?;
    var titleLabel:UILabel?;
    
//    var _play : Play?
//    var play : Play?{
//        set(newPlay){
//            if (_play != newPlay) {
//                _play = newPlay;
//            }
//            self.backgroundColor = RGBA(CGFloat(arc4random()%255), g: CGFloat(arc4random()%255), b: CGFloat(arc4random()%255), a: 0.6);
//            self.photoImage?.sd_setImageWithURL(newPlay!.image_url, placeholderImage: nil, completed: { (loadedImage, nil, SDImageCacheTypeDisk, imageUrl) in
//                //
//            })
//            self.titleLabel?.text = newPlay?.title;
//        }
//        get{
//            return self._play;
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.photoImage = UIImageView.init();
        self.titleLabel = UILabel.init();
        self.titleLabel?.textAlignment = NSTextAlignment.center;
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel?.textColor = PLACEHOLODERCOLOR
        self.contentView.addSubview(self.photoImage!);
        self.contentView.addSubview(self.titleLabel!);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        self.photoImage?.frame = CGRect(x: 0, y: 0, width: layoutAttributes.size.width, height: layoutAttributes.size.height-20);
        self.titleLabel?.frame = CGRect(x: 0, y: layoutAttributes.size.height-20, width: layoutAttributes.size.width, height: 20);
    }
}
