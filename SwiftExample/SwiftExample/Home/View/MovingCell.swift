//
//  MovingCell.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/12/6.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

protocol MovingDelegate {
//    static func longPress(_:)
}

class MovingCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var myLabel:UILabel?;
    var delegate:MovingDelegate?;
    
    var _movingItem : MovingItem?
    var movingItem : MovingItem?{
        set(newMovingItem){
            if (_movingItem != newMovingItem) {
                _movingItem = newMovingItem;
            }
            self.myLabel?.text = newMovingItem?.title
            self.backgroundColor = newMovingItem?.backGroundColor
        }
        get{
            return self._movingItem;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.myLabel = UILabel.init()
        self.myLabel?.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.myLabel!)
        
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = true;
        
//        let longPressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(longPress))
//        longPressGesture.delegate = self;
//        self.addGestureRecognizer(longPressGesture)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func longPress(longGesture:UILongPressGestureRecognizer) {
//        if (self.delegate != nil){
//            self.delegate.longPress(longGesture)
//        }
//    }
    
//    - (void)longPress:(UILongPressGestureRecognizer *)longPress{
//    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(longPress:)]) {
//    [self.delegate longPress:longPress];
//    }
//    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        self.myLabel?.frame = CGRect(x: 0, y: 0, width: layoutAttributes.size.width, height: layoutAttributes.size.height);
    }
    
    
   
    
    
    
    
    
    
    
    
    
}
