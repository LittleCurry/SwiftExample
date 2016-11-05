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
        var button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x: WIDTH/2-30, y: 100, width: 60, height: 44)
        button.backgroundColor = DARKRED
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.setTitle("弹出", for: UIControlState())
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(FirstShakeMenuViewController.pushMenu), for: UIControlEvents.touchUpInside)
    }
    
    func pushMenu() -> Void {
        
        let menuView = XRPopMenuView.init()
        menuView.addMenuItem(withTitle: "微信", andIcon: UIImage.init(named: "wechat.png")) {
            NSLog("创建标签 selected");
        }
        menuView.addMenuItem(withTitle: "", andIcon: UIImage.init(named: "jianshu.png")) {
        }
        menuView.addMenuItem(withTitle: "", andIcon: UIImage.init(named: "tuite.png")) {
        }
        menuView.addMenuItem(withTitle: "", andIcon: UIImage.init(named: "zhihu.png")) {
        }
        menuView.addMenuItem(withTitle: "创建标签", andIcon: UIImage.init(named: "editButton.png")) {
        }
        menuView.addMenuItem(withTitle: "添加标签", andIcon: UIImage.init(named: "markButton.png")) {
        }
        menuView.addMenuItem(withTitle: "创建标签", andIcon: UIImage.init(named: "editButton.png")) {
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
