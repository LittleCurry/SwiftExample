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
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.plain);
    let cellName = "qweqweasdasasad123ssasdsassasqwe";
    
    // 承载输入框的背景view
    var messageInputView = UIView.init();
    var myTextView = UITextView.init(frame: CGRect(x: 44, y: 8, width: WIDTH-44-86, height: 28));
    // 表情板
    fileprivate lazy var keyboard: LMJEmoticonKeyboard = LMJEmoticonKeyboard(targetTextView: self.myTextView)
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
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.register(WeChatChatTableViewCell.self, forCellReuseIdentifier: self.cellName)
        self.view.addSubview(self.myTableView);
        
        self.messageInputView.frame = CGRect(x: 0, y: HEIGHT - 44, width: WIDTH, height: 44);
        self.messageInputView.backgroundColor = UIColor.groupTableViewBackground
        self.view.addSubview(self.messageInputView)
        let voiceButton = UIButton.init(type: UIButtonType.custom);
        voiceButton.frame = CGRect(x: 8, y: 8, width: 28, height: 28);
        voiceButton.setBackgroundImage(UIImage.init(named: "voice.png"), for: UIControlState())
        self.messageInputView.addSubview(voiceButton);
        
        self.myTextView.frame = CGRect(x: 44, y: 8, width: WIDTH-44-86, height: 28);
        self.myTextView.backgroundColor = UIColor.white
        self.myTextView.layer.masksToBounds = true;
        self.myTextView.layer.cornerRadius = 3;
        self.myTextView.layer.borderWidth = 0.5;//设置边界的宽度
        self.myTextView.font = WORDFONT
        self.myTextView.layer.borderColor = UIColor.lightGray.cgColor;
        self.myTextView.returnKeyType = UIReturnKeyType.send
        self.myTextView.delegate = self
//        self.addCancelKeyboardMethodWhenTouchSpace(self.myTextView)
        self.messageInputView.addSubview(self.myTextView)
        let smileButton = UIButton.init(type: UIButtonType.custom)
        smileButton.frame = CGRect(x: WIDTH-76, y: 8, width: 28, height: 28)
        smileButton.setBackgroundImage(UIImage.init(named: "smile.png"), for: UIControlState())
        smileButton.addTarget(self, action: #selector(FirstKeyboardViewController.changeBoardType(_:)), for: UIControlEvents.touchUpInside)
        self.messageInputView.addSubview(smileButton)
        let addButton = UIButton.init(type: UIButtonType.custom)
        addButton.frame = CGRect(x: WIDTH-38, y: 8, width: 28, height: 28)
        addButton.setBackgroundImage(UIImage.init(named: "circleAdd.png"), for: UIControlState())
        self.messageInputView.addSubview(addButton)
    }
    
    // 点击切换表情或键盘模式
    func changeBoardType(_ button:UIButton) -> Void {
        self.myTextView.becomeFirstResponder()
        if self.smileBoardType {
            button.setBackgroundImage(UIImage.init(named: "smile.png"), for: UIControlState())
            self.myTextView.inputView = nil
        }else{
            button.setBackgroundImage(UIImage.init(named: "keyBoard.png"), for: UIControlState())
            self.myTextView.inputView = self.keyboard
            self.keyboard.backgroundColor = UIColor.groupTableViewBackground
            self.keyboard.toolBar.sentButton.addTarget(self, action: #selector(FirstKeyboardViewController.sendAction), for: UIControlEvents.touchUpInside)
        }
        self.myTextView.reloadInputViews()
        self.smileBoardType = !self.smileBoardType
    }
    
    // 点击return
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.sendAction()
            return false
        }
        return true
    }
    
    // 发送消息
    func sendAction() -> Void {
        let oneDic = ["chatText":self.myTextView.attributedText,"headImage":"http://img2.a0bi.com/upload/ttq/20141005/1412488594189.jpg"] as [String : Any]
        let chat = Chat.objectWithDictionary(oneDic as [String : AnyObject]) as? Chat
        chat?.chatText = self.myTextView.attributedText
        self.chatArr.add(chat!);
        self.myTextView.attributedText = NSAttributedString.init()
        self.myTableView.reloadData()
        
        // 这个是选择哪一行的cell，让该行的cell滑到tableView的最底端
        // [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
        let indexPath = IndexPath.init(row: self.chatArr.count-1, section: 0)
        // 这个是指定某一行的cell，让该行的cell滑到tableView的最底端
        self.myTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
    }
    
    // 注册监听
    func addMonitor() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(FirstKeyboardViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(FirstKeyboardViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    func keyboardWillShow(_ aNotification: Notification) -> Void {
        
        let info:NSDictionary = aNotification.userInfo! as NSDictionary;
        let kbSize:CGSize = ((info.object(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject).cgRectValue.size);
        self.messageInputView.frame = CGRect(x: X(self.messageInputView), y: HEIGHT-44-kbSize.height, width: PART_W(self.messageInputView), height: PART_H(self.messageInputView));
        
//        NSInteger Duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];//获取键盘显示动画持续时间
//        UIViewAnimationOptions option = ([[noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] );//获取键盘显示动画曲线
//        CGFloat bottom = [[noti.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;//获取键盘高度
//        self.BottomConstraint.constant = bottom;//frame的改变方法，根据具体情况来写
//        [UIView animateWithDuration:Duration delay:0 options:option animations:^{
//            [self.view layoutIfNeeded];
//            } completion:^(BOOL finished) {}];
//        [self.button setTitle:@"收键盘" forState:UIControlStateNormal];
    }
    
    func keyboardWillHide(_ aNotification: Notification) -> Void {
        let info:NSDictionary = aNotification.userInfo! as NSDictionary;
        let kbSize:CGSize = ((info.object(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject).cgRectValue.size);
        self.messageInputView.frame = CGRect(x: X(self.messageInputView), y: HEIGHT-44, width: PART_W(self.messageInputView), height: PART_H(self.messageInputView));
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chat = self.chatArr[indexPath.row] as! Chat
        let rect = chat.chatText.boundingRect(with: CGSize(width: WIDTH-80, height: 10000), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return rect.size.height + 10 > 50 ? rect.size.height + 10 : 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:WeChatChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellName, for: indexPath) as! WeChatChatTableViewCell
        if (cell.isEqual(nil)) {
            cell = WeChatChatTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName)
        }
        cell.chat = self.chatArr[indexPath.item] as?Chat;
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.myTextView.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event);
        self.myTextView.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil);
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
