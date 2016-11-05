//
//  LMJEmoticonPackage.swift
//  LMJEmoticonKeyBoard
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit

class LMJEmoticonPackage: NSObject {

    var emoticons: [LMJEmoticon] = [LMJEmoticon]()
    
    
    
    init(id: String) {
       
        super.init()
        guard let infoPath = Bundle.main.path(forResource: "Contents/Resources/\(id)/info", ofType: "plist", inDirectory: "Emoticons.bundle") else
        {
            addEmptyEmoticon(true, count: 0)
            return
        }
        
        guard let dictArray = NSArray(contentsOfFile: infoPath) as? [[String : AnyObject]] else
        {
            return
        }
        
        
        var index = 0
        
        for var dict in dictArray
        {
            if let png = dict["png"] as? String
            {
                dict["png"] = id + "/" + png as AnyObject?
            }
            
            let emoticon = LMJEmoticon(dict: dict)
            
            emoticons.append(emoticon)
            
            index += 1
            
            if index == 20
            {
                index = 0
                
                emoticons.append(LMJEmoticon(isDelete: true))
            }
        }
        
        self.addEmptyEmoticon(false, count: emoticons.count)
        
    }
    
    fileprivate func addEmptyEmoticon(_ isRecent: Bool, count: Int)
    {
        var yushu = count % 21
        
        if !isRecent && yushu == 0
        {
            return
        }
        
        yushu = 21 - yushu
        
        for _ in 0..<yushu-1
        {
            emoticons.append(LMJEmoticon(isEmpty: true))
        }
        
        emoticons.append(LMJEmoticon(isDelete: true))
    }
}
