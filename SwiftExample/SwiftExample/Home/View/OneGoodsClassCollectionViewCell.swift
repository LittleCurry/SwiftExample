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
        self.backgroundColor = UIColor.whiteColor()
        self.photoImage = UIImageView.init();
        self.titleLabel = UILabel.init();
        self.titleLabel?.textAlignment = NSTextAlignment.Center;
        self.titleLabel?.font = UIFont.systemFontOfSize(13)
        self.titleLabel?.textColor = PLACEHOLODERCOLOR
        self.contentView.addSubview(self.photoImage!);
        self.contentView.addSubview(self.titleLabel!);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        self.photoImage?.frame = CGRectMake(0, 0, layoutAttributes.size.width, layoutAttributes.size.height-20);
        self.titleLabel?.frame = CGRectMake(0, layoutAttributes.size.height-20, layoutAttributes.size.width, 20);
    }
}
