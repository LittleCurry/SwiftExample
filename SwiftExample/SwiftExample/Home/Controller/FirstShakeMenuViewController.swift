//
//  FirstShakeMenuViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/24.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstShakeMenuViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "抖动菜单"
        var button = UIButton.init(type: UIButtonType.Custom)
        button.frame = CGRectMake(WIDTH/2-30, 100, 60, 44)
        button.backgroundColor = DARKRED
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setTitle("弹出", forState: UIControlState.Normal)
        self.view.addSubview(button)
        button.addTarget(self, action: "pushMenu", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func pushMenu() -> Void {
        
        let menuView = XRPopMenuView.init()
        menuView.addMenuItemWithTitle("微信", andIcon: UIImage.init(named: "wechat.png")) {
            NSLog("创建标签 selected");
        }
        menuView.addMenuItemWithTitle("", andIcon: UIImage.init(named: "jianshu.png")) {
        }
        menuView.addMenuItemWithTitle("", andIcon: UIImage.init(named: "tuite.png")) {
        }
        menuView.addMenuItemWithTitle("", andIcon: UIImage.init(named: "zhihu.png")) {
        }
        menuView.addMenuItemWithTitle("创建标签", andIcon: UIImage.init(named: "editButton.png")) {
        }
        menuView.addMenuItemWithTitle("添加标签", andIcon: UIImage.init(named: "markButton.png")) {
        }
        menuView.addMenuItemWithTitle("创建标签", andIcon: UIImage.init(named: "editButton.png")) {
        }
        
        menuView.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
