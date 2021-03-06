//
//  ThirdInfoViewController.swift
//  SwiftTableView
//
//  Created by 李云鹏 on 16/9/20.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

//类似于OC中的typedef
typealias sendValueClosure=(_ string:String)->Void
class FirstLaterBlockViewController: BaseViewController {
    var i = 0;
    //声明一个闭包
    var myClosure:sendValueClosure?
    //下面这个方法需要传入上个界面的someFunctionThatTakesAClosure函数指针
    func initWithClosure(_ closure:sendValueClosure?){
        //将函数指针赋值给myClosure闭包，该闭包中涵盖了someFunctionThatTakesAClosure函数中的局部变量等的引用
        myClosure = closure
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView();
    }
    
    func getView() -> Void {
        let btn = UIButton.init(type: UIButtonType.system)
        btn.frame = CGRect(x: 0,y: 100,width: 320,height: 50)
        btn.setTitle("点击我" ,for:UIControlState())
        btn.addTarget(self,action:#selector(FirstLaterBlockViewController.action), for:UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    func action() -> Void {
        i += 1
        //判空
        if ((myClosure) != nil){
            //闭包隐式调用someFunctionThatTakesAClosure函数：回调。
            myClosure!("好好哦\(i)")
            self.navigationController?.popViewController(animated: true)
        }
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
