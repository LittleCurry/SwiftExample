//
//  FirstKeyboardViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/9/29.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstKeyboardViewController: BaseViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var chatArr : NSMutableArray = [];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Plain);
    let cellName = "qweqweasdasasad123ssasdsassasqwe";
    
    // 承载输入框的背景view
    var messageInputView = UIView.init();
    var myTextView = UITextView.init(frame: CGRectMake(44, 8, WIDTH-44-86, 28));
    // 表情板
    private lazy var keyboard: LMJEmoticonKeyboard = LMJEmoticonKeyboard(targetTextView: self.myTextView)
    // 表情or文字
    var smileBoardType = false    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView();
        self.addMonitor()// 注册监听键盘的通知
    }
    
    func getView() -> Void {
        
        self.navigationItem.title = "狂奔的蜗牛"
        self.myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.registerClass(WeChatChatTableViewCell.self, forCellReuseIdentifier: self.cellName)
        self.view.addSubview(self.myTableView);
        
        self.messageInputView.frame = CGRectMake(0, HEIGHT - 44, WIDTH, 44);
        self.messageInputView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.view.addSubview(self.messageInputView)
        let voiceButton = UIButton.init(type: UIButtonType.Custom);
        voiceButton.frame = CGRectMake(8, 8, 28, 28);
        voiceButton.setBackgroundImage(UIImage.init(named: "voice.png"), forState: UIControlState.Normal)
        self.messageInputView.addSubview(voiceButton);
        
        self.myTextView.frame = CGRectMake(44, 8, WIDTH-44-86, 28);
        self.myTextView.backgroundColor = UIColor.whiteColor()
        self.myTextView.layer.masksToBounds = true;
        self.myTextView.layer.cornerRadius = 3;
        self.myTextView.layer.borderWidth = 0.5;//设置边界的宽度
        self.myTextView.font = WORDFONT
        self.myTextView.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.myTextView.returnKeyType = UIReturnKeyType.Send
        self.myTextView.delegate = self
//        self.addCancelKeyboardMethodWhenTouchSpace(self.myTextView)
        self.messageInputView.addSubview(self.myTextView)
        let smileButton = UIButton.init(type: UIButtonType.Custom)
        smileButton.frame = CGRectMake(WIDTH-76, 8, 28, 28)
        smileButton.setBackgroundImage(UIImage.init(named: "smile.png"), forState: UIControlState.Normal)
        smileButton.addTarget(self, action: "changeBoardType:", forControlEvents: UIControlEvents.TouchUpInside)
        self.messageInputView.addSubview(smileButton)
        let addButton = UIButton.init(type: UIButtonType.Custom)
        addButton.frame = CGRectMake(WIDTH-38, 8, 28, 28)
        addButton.setBackgroundImage(UIImage.init(named: "circleAdd.png"), forState: UIControlState.Normal)
        self.messageInputView.addSubview(addButton)
    }
    
    // 点击切换表情或键盘模式
    func changeBoardType(button:UIButton) -> Void {
        self.myTextView.becomeFirstResponder()
        if self.smileBoardType {
            button.setBackgroundImage(UIImage.init(named: "smile.png"), forState: UIControlState.Normal)
            self.myTextView.inputView = nil
        }else{
            button.setBackgroundImage(UIImage.init(named: "keyBoard.png"), forState: UIControlState.Normal)
            self.myTextView.inputView = self.keyboard
            self.keyboard.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.keyboard.toolBar.sentButton.addTarget(self, action: "sendAction", forControlEvents: UIControlEvents.TouchUpInside)
        }
        self.myTextView.reloadInputViews()
        self.smileBoardType = !self.smileBoardType
    }
    
    // 点击return
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.sendAction()
            return false
        }
        return true
    }
    
    // 发送消息
    func sendAction() -> Void {
        let oneDic = ["chatText":self.myTextView.attributedText,"headImage":"http://img2.a0bi.com/upload/ttq/20141005/1412488594189.jpg"]
        let chat = Chat.objectWithDictionary(oneDic) as? Chat
        chat?.chatText = self.myTextView.attributedText
        self.chatArr.addObject(chat!);
        self.myTextView.attributedText = NSAttributedString.init()
        self.myTableView.reloadData()
        
        // 这个是选择哪一行的cell，让该行的cell滑到tableView的最底端
        // [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
        let indexPath = NSIndexPath.init(forRow: self.chatArr.count-1, inSection: 0)
        // 这个是指定某一行的cell，让该行的cell滑到tableView的最底端
        self.myTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    // 注册监听
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
        let info:NSDictionary = aNotification.userInfo!;
        let kbSize:CGSize = (info.objectForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue().size)!;
        self.messageInputView.frame = CGRectMake(X(self.messageInputView), HEIGHT-44, PART_W(self.messageInputView), PART_H(self.messageInputView));
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let chat = self.chatArr[indexPath.row] as! Chat
        let rect = chat.chatText.boundingRectWithSize(CGSizeMake(WIDTH-80, 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        return rect.size.height + 10 > 50 ? rect.size.height + 10 : 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:WeChatChatTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellName, forIndexPath: indexPath) as! WeChatChatTableViewCell
        if (cell.isEqual(nil)) {
            cell = WeChatChatTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName)
        }
        cell.chat = self.chatArr[indexPath.item] as?Chat;
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.myTextView.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event);
        self.myTextView.resignFirstResponder()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil);
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
