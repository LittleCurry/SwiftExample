//
//  OneGoodsClassCollectionReusableView.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/11/3.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class OneGoodsClassCollectionReusableView: UICollectionReusableView {
    var headLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.groupTableViewBackgroundColor()
        headLabel = UILabel()
        headLabel.frame=CGRectMake(5, 0, WIDTH-10, 25)
        headLabel.font = UIFont.systemFontOfSize(13)
        self .addSubview(headLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
