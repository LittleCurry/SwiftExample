//
//  LMJEmoticonTextView.swift
//  Weibo2
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit


///拥有占位文字的textview, 推荐使用
class LMJTextView: UITextView {

    private var oldFont: UIFont = UIFont.systemFontOfSize(16)
    
    private lazy var placeHolderLabel: UILabel = UILabel()
    var placeHoldString: String = "发布有趣的事..." {
        didSet{
            textViewChangeFrame()
        }
    }
    var placeHoldColor: UIColor = UIColor.grayColor(){
        didSet{
            textViewChangeFrame()
        }
    }
    
    
    override var font: UIFont! {
        didSet{
            textViewChangeFrame()
        }
    }
    
    override var text: String! {
        didSet{
            textViewChangeFrame()
            //为了通知代理
            self.insertText("")
        }
    }
    
    override var attributedText: NSAttributedString! {
        willSet{
            self.oldFont = self.font
        }
        
        didSet{
            self.font = self.oldFont
             textViewChangeFrame()
            ///为了通知代理
            self.insertText("")
        }
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        self.insertText("")
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func insertText(text: String) {
        super.insertText(text)
         textViewChangeFrame()
    }
    
    override func replaceRange(range: UITextRange, withText text: String) {
        super.replaceRange(range, withText: text)
        self.insertText("")
        textViewChangeFrame()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}


extension LMJTextView
{
    private func setupUI()
    {
        self.addSubview(placeHolderLabel)
        placeHolderLabel.frame.origin.x = 14
        placeHolderLabel.frame.origin.y = 8
        placeHolderLabel.text = placeHoldString
        placeHolderLabel.textColor = placeHoldColor
        self.font = UIFont.systemFontOfSize(16)
        placeHolderLabel.font = self.font
        placeHolderLabel.numberOfLines = 0
        placeHolderLabel.sizeToFit()
        
        alwaysBounceVertical = true
        self.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewTextDidChange", name: UITextViewTextDidChangeNotification, object: self)
    }
}


extension LMJTextView
{
    @objc private func textViewTextDidChange()
    {
        self.placeHolderLabel.hidden = self.hasText()
    }
    
    private func textViewChangeFrame()
    {
        self.placeHolderLabel.text = self.placeHoldString
        self.placeHolderLabel.textColor = self.placeHoldColor
        self.placeHolderLabel.font = self.font
        self.textViewTextDidChange()
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.placeHolderLabel.frame.size.width = self.frame.size.width - 2 * self.placeHolderLabel.frame.origin.x
        self.placeHolderLabel.sizeToFit()
    }
}
