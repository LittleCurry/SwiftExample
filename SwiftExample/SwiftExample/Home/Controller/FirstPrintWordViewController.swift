//
//  FirstPrintWordViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/20.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstPrintWordViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "打印机文字效果"
        self.view.backgroundColor = UIColor.blackColor()
        let myLbl = ZTypewriteEffectLabel.init(frame: CGRectMake(5, 100, WIDTH-10, 450))
        myLbl.tag = 10;
        myLbl.backgroundColor = UIColor.clearColor()
        myLbl.numberOfLines = 0;
        myLbl.text = "\t\t\t打印机输出特效\n\n\t GitHub是一个面向开源及私有软件项目的托管平台，因为只支持Git作为唯一的版本库格式进行托管，故名 GitHub.GitHub 于 2008 年 4 月 10 日正式上线，除了 Git 代码仓库托管及基本的 Web 管理界面以外，还提供了订阅、讨论组、文本渲染、在线文件编辑器、协作图谱（报表）、代码片段分享（Gist）等功能。目前，其注册用户已经超过350万，托管版本数量也是非常之多，其中不乏知名开源项目 Ruby on Rails、jQuery 等\n\n\t帮助开发者收集高质量的开源代码，并允许用户分享自己编写的代码。会为每份代码做严格的模拟机和真机测试，并为每份代码配上文字说明、屏幕截屏效果图以及视频演示（如果需要）。同时， 允许用户自行上传代码分享给其他用户。调动开发者用户积极性的同时，充分的发挥了开源分享的精神。 \n\n\t\t\t\t\t\t\t\tBy\tgithub ";
        myLbl.textColor = self.view.backgroundColor;
        
        
        myLbl.typewriteEffectColor = UIColor.greenColor();
        myLbl.hasSound = false;
        myLbl.typewriteTimeInterval = 0.3;
        myLbl.typewriteEffectBlock = {
            print("打印完成")
        };
        
        self.view.addSubview(myLbl);
        /** Z
         *	1秒后开始打印输出
         */
        self.performSelector("startOutPut", withObject: nil, afterDelay: 1)
        
    }
    
    func startOutPut() -> Void {
        let myLbl:ZTypewriteEffectLabel = self.view.viewWithTag(10) as! ZTypewriteEffectLabel
        myLbl.startTypewrite()
    }
    
//    -(void)startOutPut
//    {
//    ZTypewriteEffectLabel *myLbl = (ZTypewriteEffectLabel *)[self.view viewWithTag:10];
//    [myLbl startTypewrite];
//    }
    
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
