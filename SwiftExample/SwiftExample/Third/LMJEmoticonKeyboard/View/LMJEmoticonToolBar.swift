//
//  LMJEmoticonToolBar.swift
//  LMJEmoticonKeyBoard
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit

enum LMJEmoticonToolBarItemType: Int
{
    case recent = 0
    case `default` = 1
    case emoji = 2
    case lxh = 3
}


class LMJEmoticonToolBar: UIStackView {
    
    var sentButton = UIButton.init(type: UIButtonType.custom)
    
    fileprivate var lastSelectedBtn: UIButton?
    
    var selectTypeCallBack: ((_ type: LMJEmoticonToolBarItemType) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        //        print(self.subviews)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        setupUI()
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupUI()
//    }
    
    deinit
    {
        print("LMJEmoticonToolBar-deinit")
    }
}

extension LMJEmoticonToolBar
{
    fileprivate func setupUI()
    {
        axis = .horizontal
        distribution = .fillEqually
        
        addChildBtn("最近", imageName: nil, type: .recent)
        addChildBtn("", imageName: "defaultSmile.png", type: .default)
        addChildBtn("", imageName: "emoji.png", type: .emoji)
        addChildBtn("", imageName: "langxiaohua.png", type: .lxh)
        
        self.sentButton.frame = CGRect(x: self.frame.size.width-44, y: 0, width: 44, height: self.frame.size.height)
        self.sentButton.backgroundColor = RGBA(0, g: 121, b: 253, a: 1)
        self.sentButton.setTitleColor(UIColor.white, for: UIControlState())
        self.sentButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.sentButton.setTitle("发送", for: UIControlState())
        self.addArrangedSubview(self.sentButton)
    }
    
    fileprivate func addChildBtn(_ title: String, imageName: String?, type: LMJEmoticonToolBarItemType)
    {
        let btn = UIButton()
        self.addArrangedSubview(btn)
        
        btn.tag = type.rawValue
        btn.setTitle(title, for: UIControlState())
        
        btn.setTitleColor(UIColor.darkGray, for: UIControlState())
        
        btn.setTitleColor(UIColor.gray, for: .disabled)
        
        btn.backgroundColor = UIColor(white: 0.93, alpha: 1)
        if imageName != nil {
            btn.setImage(UIImage.init(named: imageName!), for: UIControlState())
        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        //        btn.adjustsImageWhenHighlighted = false
        
        if type == .recent
        {
            btn.isEnabled = false
            self.lastSelectedBtn = btn
        }
        
        btn.addTarget(self, action: #selector(LMJEmoticonToolBar.selectBtn(_:isNotCallBack:)), for: .touchUpInside)
    }
    
}

extension LMJEmoticonToolBar
{
    func selectBtn(_ selectBtn: UIButton, isNotCallBack: Bool = true)
    {
        self.lastSelectedBtn?.isEnabled = true
        selectBtn.isEnabled = false
        self.lastSelectedBtn = selectBtn
        
        if !isNotCallBack
        {
            selectTypeCallBack?(LMJEmoticonToolBarItemType(rawValue: selectBtn.tag)!)
        }
        
    }
}























































































































