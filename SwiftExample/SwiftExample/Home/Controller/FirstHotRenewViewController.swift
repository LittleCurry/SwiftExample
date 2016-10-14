//
//  FirstHotRenewViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/11.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstHotRenewViewController: BaseViewController {
    let nameLabel = UILabel.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "JSPatch"
        self.nameLabel.frame = CGRectMake(30, 200, WIDTH-60, 40)
        self.nameLabel.backgroundColor = UIColor.cyanColor()
        self.nameLabel.textAlignment = NSTextAlignment.Center
        self.nameLabel.font = UIFont.init(name: "Font: Courier-Bold", size: 20)
        self.nameLabel.text = "我是原来的内容"
        self.view.addSubview(self.nameLabel)
        /**
         计划使用JSPatch改变下面这个函数
         */
        self.myChangeFunc()
    }
    
    func myChangeFunc() -> Void {
        //
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
