//
//  FirstShareViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/6.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstShareViewController: BaseViewController, UMSocialUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView();
    }
    
    func getView() -> Void {
        self.navigationItem.title = "share"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "share.png"), style: UIBarButtonItemStyle.Done, target: self, action: "shareAction")
    }
    
    func shareAction() -> Void {
        var shareImage = UIImage.init(named: "1024.png")
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "5705cd51e0f55a586d000567", shareText: "分享内容你好", shareImage: shareImage, shareToSnsNames: [UMShareToSina, UMShareToWechatSession,UMShareToQQ, UMShareToTencent, UMShareToQzone, UMShareToEmail, UMShareToSms, UMShareToWechatTimeline, UMShareToAlipaySession], delegate: self)
//        UMSocialSnsService.presentSnsController(self, appKey: "5705cd51e0f55a586d000567", shareText: "分享内容123", shareImage: shareImage, shareToSnsNames: [UMShareToSina, UMShareToWechatSession,UMShareToQQ, UMShareToTencent, UMShareToQzone, UMShareToEmail, UMShareToSms, UMShareToWechatTimeline, UMShareToAlipaySession], delegate: self)
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
