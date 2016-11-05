//
//  LMJEmoticonCell.swift
//  LMJEmoticonKeyBoard
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit

let itemWH = UIScreen.main.bounds.width / 7.0
let rows = 3

class LMJEmoticonCell: UICollectionViewCell {
    
    fileprivate lazy var btn: UIButton = UIButton()
    
    
    var emoticon: LMJEmoticon? {
        didSet{
            btn.setTitle(emoticon?.emojiCode, for: UIControlState())
            btn.setImage(UIImage(contentsOfFile: emoticon?.pngPath ?? ""), for: UIControlState())
            
            if emoticon?.isDelete == true
            {
                btn.setImage(UIImage(named: "compose_emotion_delete"), for: UIControlState())
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
    fileprivate func setupUI()
    {
        contentView.addSubview(btn)
        
        contentView.backgroundColor = UIColor.clear
        btn.backgroundColor = UIColor.clear
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        btn.isUserInteractionEnabled = false
        btn.contentMode = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.contentMode = .center
        
        
        let views = ["btn" : btn]
        
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[btn]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[btn]-0-|", options: [], metrics: nil, views: views)
        
        contentView.addConstraints(cons)
        
    }
}




class LMJEnoticonLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        guard let collectionViewi = collectionView else
        {
            return
        }
        
        let margin = (collectionViewi.frame.size.height - 3 * itemWH)
        
        collectionViewi.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: margin-1, right: 0)
        collectionViewi.backgroundColor = UIColor.clear
        collectionViewi.showsHorizontalScrollIndicator = false
        collectionViewi.showsVerticalScrollIndicator = false
        collectionViewi.isPagingEnabled = true
    }
}













































