//
//  LMJEmoticon.swift
//  LMJEmoticonKeyBoard
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit

class LMJEmoticon: NSObject {

    var code: String?{
        didSet{
            if let code = code
            {
                let scanner = NSScanner(string: code)
                
                var value: UInt32 = 0
                
                scanner.scanHexInt(&value)
                
                let c = Character(UnicodeScalar(value))
                
                emojiCode = String(c)
            }
        }
    }
    
    var chs: String?
    
    var png: String?{
        
        didSet{
            if let png = png
            {
                pngPath = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/Contents/Resources/" + png
            }
        }
    }


    var pngPath: String?
    
    var emojiCode: String?
    
    var isDelete: Bool = false
    
    var isEmpty: Bool = false
    
    init(dict: [String : AnyObject]) {
        
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    init(isDelete: Bool) {
        super.init()
        self.isDelete = isDelete
    }
    
    init(isEmpty: Bool) {
        super.init()
        self.isEmpty = isEmpty
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}
