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
        self.backgroundColor = UIColor.groupTableViewBackground
        headLabel = UILabel()
        headLabel.frame=CGRect(x: 5, y: 0, width: WIDTH-10, height: 25)
        headLabel.font = UIFont.systemFont(ofSize: 13)
        self .addSubview(headLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
