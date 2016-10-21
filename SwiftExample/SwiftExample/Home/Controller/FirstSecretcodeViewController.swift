//
//  FirstSecretcodeViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/20.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstSecretcodeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        var passwordView = PasswordView.init(title: "输入支付密码", detail: "删除该提现方式")
        passwordView.show()
        passwordView.completeHandle = { (inputPwd) in
            var hud = MBProgressHUD.init(view: self.view)
            UIApplication.sharedApplication().keyWindow?.addSubview(hud)
            hud.labelFont = WORDFONT
            hud.labelText = "验证中"
            hud.show(true)
            // 此处验证密码
            passwordView.checkPassword({ (isRight) in
                if(isRight){
                    // 正确
                    passwordView.dismiss()
                    hud.removeFromSuperview()
                }else{
                    // 密码错误
                    hud.removeFromSuperview()
                }
            })
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
