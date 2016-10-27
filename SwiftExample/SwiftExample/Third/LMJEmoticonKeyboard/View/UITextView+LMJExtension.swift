//
//  UITextView+Extension.swift
//  LMJEmoticonKeyBoard
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit

extension UITextView
{
    ///获得文本输入框中的表情富文本并且返回给服务器的字段, 字符串:[偷笑]、@M了个J: 老鼠这么尖叫、兔子这么尖叫[吃惊]
    var stringText: String {
        
        let atrbsM = NSMutableAttributedString(attributedString: self.attributedText)
        
        atrbsM.enumerateAttributesInRange(NSRange(location: 0, length: atrbsM.length), options: []) { (dict, range, _) -> Void in
            
            if let attachment = dict["NSAttachment"] as? LMJEmoticonTextAttachment
            {
                if let chs = attachment.emoticon?.chs
                {
                    atrbsM.replaceCharactersInRange(range, withString: chs)
                }
            }
        }
        
        return atrbsM.string
    }
    
    ///把服务器给的字符串:[偷笑]、@M了个J: 老鼠这么尖叫、兔子这么尖叫[吃惊], 转为富文本, 
    ///并且设置到textview
    func setEmoticonAttributedStringWithStringText(stringText: String)
    {
        let selfFont = self.font!
        
        if let atrbs = LMJEmoticonTool.sharedTool.emoticonAttributedString(stringText, font: selfFont)
        {
            self.attributedText = atrbs
            self.font = selfFont
        }
        
    }
    
    func insertEmotion(emoticon: LMJEmoticon)
    {
        if emoticon.isEmpty
        {
            return
        }
        
        if emoticon.isDelete
        {
            self.deleteBackward()
            return
        }
        
        if let emojiCode = emoticon.emojiCode
        {
            self.insertText(emojiCode)
            //            let textRange = textView.selectedTextRange!
            //            textView.replaceRange(textRange, withText: emojiCode)
            return
        }
        
        if let pngPath = emoticon.pngPath
        {
            let image = UIImage(contentsOfFile: pngPath)!
            
            let selfFont = self.font == nil ? UIFont.systemFontOfSize(14) : self.font!
            
            let range = self.selectedRange
            
            let atrbsM = NSMutableAttributedString(attributedString: self.attributedText)
            
            let attachment = LMJEmoticonTextAttachment()
            attachment.emoticon = emoticon
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -4, width: selfFont.lineHeight, height: selfFont.lineHeight)
            
            let emoticonAtrbs = NSAttributedString(attachment: attachment)
            
            atrbsM.insertAttributedString(emoticonAtrbs, atIndex: range.location)
            //            atrbsM.replaceCharactersInRange(range, withAttributedString: emoticonAtrbs)
            
            self.attributedText = atrbsM
            
            self.font = selfFont
            self.selectedRange = NSMakeRange(range.location + 1, 0)
        }
    }
    
    func _firstBaselineOffsetFromTop() -> Void {
        
    }
    
    func _baselineOffsetFromBottom() -> Void {
        
    }
}
