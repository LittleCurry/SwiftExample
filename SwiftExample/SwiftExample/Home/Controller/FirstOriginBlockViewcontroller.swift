//
//  ThirdViewController.swift
//  SwiftTableView
//
//  Created by 李云鹏 on 16/9/12.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstOriginBlockViewcontroller: BaseViewController {
    var myButton = UIButton.init(type: UIButtonType.system);
    var myLabel = UILabel.init(frame: CGRect(x: 50, y: 300, width: 200, height: 30));
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView();
    }
    
    func getView() -> Void {
        myButton.frame = CGRect(x: 50, y: 150, width: 200, height: 30);
        myButton.setTitle("123", for: UIControlState())
        myButton.addTarget(self, action: #selector(FirstOriginBlockViewcontroller.nextAction), for: UIControlEvents.touchUpInside);
        self.view.addSubview(self.myButton)
        self.myLabel.text = "原来的";
        self.view.addSubview(self.myLabel)
    }
    
    func nextAction(){
        let blockInfo = FirstLaterBlockViewController.init()
        //将当前someFunctionThatTakesAClosure函数指针传到第二个界面，第二个界面的闭包拿到该函数指针后会进行回调该函
        blockInfo.initWithClosure(someFunctionThatTakesAClosure)
        self.navigationController!.pushViewController(blockInfo,animated:true)
    }
    
    func someFunctionThatTakesAClosure(_ string:String) -> Void {
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
