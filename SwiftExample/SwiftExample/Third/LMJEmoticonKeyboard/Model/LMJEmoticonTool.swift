//
//  LMJEmoticonTool.swift
//  LMJEmoticonKeyBoard
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit

class LMJEmoticonTool {

    static var sharedTool: LMJEmoticonTool = LMJEmoticonTool()
    
    ///把服务器给的字符串:[偷笑]、@M了个J: 老鼠这么尖叫、兔子这么尖叫[吃惊], 转为富文本
    func emoticonAttributedString(_ stringText: String, font: UIFont) -> NSMutableAttributedString?
    {
        let atrbsM = NSMutableAttributedString(string: stringText)
        
        let pattern = "\\[.*?\\]"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else
        {
            return nil
        }
        
        let results = regex.matches(in: stringText, options: [], range: NSMakeRange(0, stringText.characters.count))
        
        for i in (results.count - 1)...0
//        for var i = results.count - 1; i >= 0; i -= 1
        {
            let result = results[i]
            
            let range = result.range
            
            let str = (stringText as NSString).substring(with: range)
            
            guard let image = searchEmoticon(str) else
            {
                continue
            }
            
            guard let imageAtrbs = imageAttributedString(image, font: font) else
            {
                continue
            }
            
            atrbsM.replaceCharacters(in: range, with: imageAtrbs)
        }
        
        return atrbsM
    }
    
}




extension LMJEmoticonTool
{
    ///根据image, 获得富文本
    func imageAttributedString(_ image: UIImage, font: UIFont) -> NSAttributedString?
    {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        
        return NSAttributedString(attachment: attachment)
    }
    
    
    ///根据一个表情的中文, 获得表情图片
    func searchEmoticon(_ chs: String) -> UIImage?
    {
        for package in LMJPackageManager.sharedManager.packages
        {
            
            for emoticon in package.emoticons
            {
                if let text = emoticon.chs, text == chs
                {
                    if let pngPath = emoticon.pngPath, let image = UIImage(contentsOfFile: pngPath)
                    {
                        return image
                    }
                }
            }
        }
        
        return nil
    }

}
