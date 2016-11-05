//
//  LMJEmoticonViewController.swift
//  LMJEmoticonKeyBoard
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit

let LMJEmoticonCellID = "LMJEmoticonCellID"

class LMJEmoticonKeyboard: UIView {
    
    lazy var toolBar: LMJEmoticonToolBar = LMJEmoticonToolBar(frame: CGRect.zero)
    fileprivate lazy var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: LMJEnoticonLayout())
    
    fileprivate lazy var packageManager: LMJPackageManager = LMJPackageManager.sharedManager
    
   weak var targetTextView: UITextView?
    
    ///外界需要告知键盘对应的textView, 才能插入表情================================
    init(targetTextView: UITextView)
    {
        super.init(frame: CGRect.zero)
        self.targetTextView = targetTextView
        targetTextView.inputView = self
        setupUI()
    }
    ///==========================================================================
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //====================================================================
    
    deinit
    {
        print("LMJEmoticonKeyboard-deinit")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 38.0 + 3 * itemWH + 15)
    }
}



extension LMJEmoticonKeyboard
{
    fileprivate func setupUI()
    {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 38.0 + 3 * itemWH + 15)
        
        backgroundColor = UIColor(white: 0.851, alpha: 1)
        
        addSubview(toolBar)
        addSubview(collectionView)
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["toolBar" : toolBar, "collectionView" : collectionView] as [String : Any]
        
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-[toolBar]-0-|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        
        cons.append(NSLayoutConstraint(item: toolBar, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 38))
        
        addConstraints(cons)
                
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LMJEmoticonCell.self, forCellWithReuseIdentifier: LMJEmoticonCellID)
        
        toolBar.selectTypeCallBack = {[weak self] (type) -> () in
            self?.collectionView.scrollToItem(at: IndexPath(item: 0, section: type.rawValue), at: .left, animated: false)
        }
        
    }
}

extension LMJEmoticonKeyboard: UICollectionViewDataSource, UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return packageManager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return packageManager.packages[section].emoticons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LMJEmoticonCellID, for: indexPath) as! LMJEmoticonCell
        
        cell.emoticon = packageManager.packages[indexPath.section].emoticons[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let emoticon = (collectionView.cellForItem(at: indexPath) as! LMJEmoticonCell).emoticon!
        
        if !emoticon.isDelete && !emoticon.isEmpty
        {
            if let index = packageManager.packages[0].emoticons.index(of: emoticon)
            {
                packageManager.packages[0].emoticons.remove(at: index)
            }else
            {
                packageManager.packages[0].emoticons.remove(at: 19)
            }
            packageManager.packages[0].emoticons.insert(emoticon, at: 0)
        }
        
        targetTextView?.insertEmotion(emoticon)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let screenW = UIScreen.main.bounds.width
        
        ///每一组的宽度
        let section0W = screenW
        
        let section1W = screenW * CGFloat(packageManager.packages[1].emoticons.count / 21)
        
        let section2W = screenW * CGFloat(packageManager.packages[2].emoticons.count / 21)
        
        let section3W = screenW * CGFloat(packageManager.packages[3].emoticons.count / 21)
        
        ///每一组的范围
        let section0FW = (0..<section0W)
        
        let section1FW = (section0W..<section0W + section1W)
        
        let section2FW = (section0W + section1W..<section0W + section1W + section2W)
        
        let section3FW = (section0W + section1W + section2W..<section0W + section1W + section2W+section3W)
        
        ///判断偏移量
        switch scrollView.contentOffset.x
        {
        case section0FW: toolBar.selectBtn(toolBar.subviews[0] as! UIButton)
        case section1FW: toolBar.selectBtn(toolBar.subviews[1] as! UIButton)
        case section2FW: toolBar.selectBtn(toolBar.subviews[2] as! UIButton)
        case section3FW: toolBar.selectBtn(toolBar.subviews[3] as! UIButton)
        default: _ = 0
        }
    }
    
}


