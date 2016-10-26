//
//  LMJEmoticonCell.swift
//  LMJEmoticonKeyBoard
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit

let itemWH = UIScreen.mainScreen().bounds.width / 7.0
let rows = 3

class LMJEmoticonCell: UICollectionViewCell {
    
    private lazy var btn: UIButton = UIButton()
    
    
    var emoticon: LMJEmoticon? {
        didSet{
            btn.setTitle(emoticon?.emojiCode, forState: .Normal)
            btn.setImage(UIImage(contentsOfFile: emoticon?.pngPath ?? ""), forState: .Normal)
            
            if emoticon?.isDelete == true
            {
                btn.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
}


extension LMJEmoticonCell
{
    private func setupUI()
    {
        contentView.addSubview(btn)
        
        contentView.backgroundColor = UIColor.clearColor()
        btn.backgroundColor = UIColor.clearColor()
        btn.titleLabel?.font = UIFont.systemFontOfSize(32)
        btn.userInteractionEnabled = false
        btn.contentMode = .Center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.contentMode = .Center
        
        
        let views = ["btn" : btn]
        
        var cons = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[btn]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[btn]-0-|", options: [], metrics: nil, views: views)
        
        contentView.addConstraints(cons)
        
    }
}




class LMJEnoticonLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Horizontal
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        guard let collectionViewi = collectionView else
        {
            return
        }
        
        let margin = (collectionViewi.frame.size.height - 3 * itemWH)
        
        collectionViewi.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: margin-1, right: 0)
        collectionViewi.backgroundColor = UIColor.clearColor()
        collectionViewi.showsHorizontalScrollIndicator = false
        collectionViewi.showsVerticalScrollIndicator = false
        collectionViewi.pagingEnabled = true
    }
}













































