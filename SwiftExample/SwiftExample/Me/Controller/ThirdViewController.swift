//
//  ThirdViewController.swift
//  SwiftTableView
//
//  Created by 李云鹏 on 16/9/12.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class ThirdViewController: BaseViewController {
    var myButton = UIButton.init(type: UIButtonType.System);
    var myLabel = UILabel.init(frame: CGRectMake(50, 300, 200, 30));
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView();
    }
    
    func getView() -> Void {
        myButton.frame = CGRectMake(50, 150, 200, 30);
        myButton.setTitle("123", forState: UIControlState.Normal)
        myButton.addTarget(self, action: "nextAction", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(self.myButton)
        self.myLabel.text = "Closure";
        self.view.addSubview(self.myLabel)
    }
    
    func nextAction(){
        let thirdInfo = ThirdInfoViewController.init()
        //将当前someFunctionThatTakesAClosure函数指针传到第二个界面，第二个界面的闭包拿到该函数指针后会进行回调该函
        thirdInfo.initWithClosure(someFunctionThatTakesAClosure)
        self.navigationController!.pushViewController(thirdInfo,animated:true)
    }
    
    func someFunctionThatTakesAClosure(string:String) -> Void {
        // function body goes here
       self.myLabel.text = string
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
