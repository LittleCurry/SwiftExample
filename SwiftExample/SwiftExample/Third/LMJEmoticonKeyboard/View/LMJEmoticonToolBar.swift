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
    case Recent = 0
    case Default = 1
    case Emoji = 2
    case LXH = 3
}


class LMJEmoticonToolBar: UIStackView {
    
    var sentButton = UIButton.init(type: UIButtonType.Custom)
    
    private var lastSelectedBtn: UIButton?
    
    var selectTypeCallBack: ((type: LMJEmoticonToolBarItemType) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        //        print(self.subviews)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    deinit
    {
        print("LMJEmoticonToolBar-deinit")
    }
}

extension LMJEmoticonToolBar
{
    private func setupUI()
    {
        axis = .Horizontal
        distribution = .FillEqually
        
        addChildBtn("最近", imageName: nil, type: .Recent)
        addChildBtn("", imageName: "defaultSmile.png", type: .Default)
        addChildBtn("", imageName: "emoji.png", type: .Emoji)
        addChildBtn("", imageName: "langxiaohua.png", type: .LXH)
        
        self.sentButton.frame = CGRectMake(self.frame.size.width-44, 0, 44, self.frame.size.height)
        self.sentButton.backgroundColor = RGBA(0, g: 121, b: 253, a: 1)
        self.sentButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.sentButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.sentButton.setTitle("发送", forState: UIControlState.Normal)
        self.addArrangedSubview(self.sentButton)
    }
    
    private func addChildBtn(title: String, imageName: String?, type: LMJEmoticonToolBarItemType)
    {
        let btn = UIButton()
        self.addArrangedSubview(btn)
        
        btn.tag = type.rawValue
        btn.setTitle(title, forState: .Normal)
        
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        btn.setTitleColor(UIColor.grayColor(), forState: .Disabled)
        
        btn.backgroundColor = UIColor(white: 0.93, alpha: 1)
        if imageName != nil {
            btn.setImage(UIImage.init(named: imageName!), forState: .Normal)
        }
        //        btn.setBackgroundImage(UIImage(named: imageName + "_normal"), forState: .Normal)
        //        btn.setBackgroundImage(UIImage(named: imageName + "_selected"), forState: .Selected)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        //        btn.adjustsImageWhenHighlighted = false
        
        if type == .Recent
        {
            btn.enabled = false
            self.lastSelectedBtn = btn
        }
        
        btn.addTarget(self, action: "selectBtn:isNotCallBack:", forControlEvents: .TouchUpInside)
    }
    
}

extension LMJEmoticonToolBar
{
    func selectBtn(selectBtn: UIButton, isNotCallBack: Bool = true)
    {
        self.lastSelectedBtn?.enabled = true
        selectBtn.enabled = false
        self.lastSelectedBtn = selectBtn
        
        if !isNotCallBack
        {
            selectTypeCallBack?(type: LMJEmoticonToolBarItemType(rawValue: selectBtn.tag)!)
        }
        
    }
}























































































































