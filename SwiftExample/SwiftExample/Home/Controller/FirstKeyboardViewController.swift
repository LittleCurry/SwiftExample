//
//  FirstKeyboardViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/9/29.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstKeyboardViewController: BaseViewController {
    
    var messageInputView = UIView.init();
    var myTextField = UITextField.init();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView();
        self.addMonitor()// 注册监听键盘的通知
    }
    
    func getView() -> Void {
        self.messageInputView.frame = CGRectMake(0, HEIGHT - 44, WIDTH, 44);
        self.messageInputView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.view.addSubview(self.messageInputView)
        var voiceButton = UIButton.init(type: UIButtonType.Custom);
        voiceButton.frame = CGRectMake(5, 5, 34, 34);
        voiceButton.setBackgroundImage(UIImage.init(named: "jiezhi.jpg"), forState: UIControlState.Normal)
        self.messageInputView.addSubview(voiceButton);
        self.myTextField.frame = CGRectMake(44, 5, WIDTH-44-100, 34);
        self.myTextField.backgroundColor = UIColor.whiteColor()
        self.myTextField.layer.masksToBounds = true;
        self.myTextField.layer.cornerRadius = 3;
        self.myTextField.layer.borderWidth = 1;//设置边界的宽度
        self.myTextField.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.messageInputView.addSubview(self.myTextField)
        
    }
    
    func addMonitor() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }
    
    func keyboardWillShow(aNotification: NSNotification) -> Void {
        
        let info:NSDictionary = aNotification.userInfo!;
        let kbSize:CGSize = (info.objectForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue().size)!;
        self.messageInputView.frame = CGRectMake(X(self.messageInputView), HEIGHT-44-kbSize.height, PART_W(self.messageInputView), PART_H(self.messageInputView));
        
//        NSInteger Duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];//获取键盘显示动画持续时间
//        UIViewAnimationOptions option = ([[noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] );//获取键盘显示动画曲线
//        CGFloat bottom = [[noti.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;//获取键盘高度
//        self.BottomConstraint.constant = bottom;//frame的改变方法，根据具体情况来写
//        [UIView animateWithDuration:Duration delay:0 options:option animations:^{
//            [self.view layoutIfNeeded];
//            } completion:^(BOOL finished) {}];
//        [self.button setTitle:@"收键盘" forState:UIControlStateNormal];
    }
    
    func keyboardWillHide(aNotification: NSNotification) -> Void {
        var info:NSDictionary = aNotification.userInfo!;
        var kbSize:CGSize = (info.objectForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue().size)!;
        self.messageInputView.frame = CGRectMake(X(self.messageInputView), HEIGHT-44, PART_W(self.messageInputView), PART_H(self.messageInputView));
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event);
        self.myTextField.resignFirstResponder()
        
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
