//
//  LMJPackageManager.swift
//  LMJEmoticonKeyBoard
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 NJHu. All rights reserved.
//

import UIKit

class LMJPackageManager {

    static var sharedManager: LMJPackageManager = LMJPackageManager()
    
    var packages: [LMJEmoticonPackage] = [LMJEmoticonPackage]()
    
    
    init()
    {
        let ids = ["", "default", "emoji", "lxh"]
        
        for i in 0 ..< ids.count
        {
            let package = LMJEmoticonPackage(id: ids[i])

            packages.append(package)
        }
    }

}
