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
        self.nameLabel.frame = CGRect(x: 30, y: 200, width: WIDTH-60, height: 40)
        self.nameLabel.backgroundColor = UIColor.cyan
        self.nameLabel.textAlignment = NSTextAlignment.center
        self.nameLabel.font = UIFont.init(name: "Font: Courier-Bold", size: 20)
        self.nameLabel.text = "我是原来的内容"
        self.view.addSubview(self.nameLabel)
        /**
         计划使用JSPatch改变下面这个函数
         */
        self.myChangeFunc()
    }
    // 加dynamic关键字是为了让自定义的方法myChangeFunc()具有动态性. 继承自NSObject的Swift类，其继承自父类的方法具有动态性，其他自定义方法、属性需要加dynamic修饰才可以获得动态性
    dynamic func myChangeFunc() -> Void {
        //
        print("原来的代码")
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
