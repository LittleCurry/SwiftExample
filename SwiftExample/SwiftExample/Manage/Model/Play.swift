//
//  Play.swift
//  SwiftTableView
//
//  Created by 李云鹏 on 16/9/20.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class Play: NSObject {
    
    var small_width: CGFloat = 0.0;
    var small_height: CGFloat = 0.0;
    var small_url: String = "";
    var title: String = "";
    
    var image_url: String = "";
    var image_width: CGFloat = 0.0;
    var image_height: CGFloat = 0.0;
    
    /**
     * 原版的一个model类, 里面的属性和纠错方法
     */
//    var name : String?
//    var age  : Int?
//    var wife : LWWife?
//    var cat  : LWCat?
//    var friends : [LWFriend]?
//    var babys : [LWBaby]?
//    // 类名
//    override class func customClassForVariableName() -> [String : AnyClass]? {
//        return ["cat":LWCat.classForCoder(),"wife":LWWife.classForCoder()]
//    }
//    // 数组对象
//    override func objectClassInArray() -> [String : AnyClass]? {
//        return ["friends":LWFriend.classForCoder(),"babys":LWBaby.classForCoder()]
//    }
//    // 可以过滤漏掉字段或者属性转换
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        if key == "age" {
//            age = value as? Int
//        }
//    }
//    
//    override var description: String {
//        return "LWPerson:  name=\(name), age=\(age) ,wife = \(wife),cat=\(cat),friends = \(friends),babys=\(babys)"
//    }
    
    
    /**
     * 下面的没什么用
     */
//    var playId: String = "";
//    var playType: String = "";
//    func initWithDictionary(dic : NSDictionary) ->Play{
//        //个人并不认为这种方法是合理的，但是sample就是这么干的，照抄了
//        self.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
////        self.atomicWeight = aDictionary["atomicWeight"] as String
//        return self;
//    }
    
}
