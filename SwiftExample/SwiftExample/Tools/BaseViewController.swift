//
//  BaseViewController.swift
//  SwiftTableView
//
//  Created by 李云鹏 on 16/9/12.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor();
        self.navigationController!.navigationBar.barTintColor = RGBA(240, g: 166, b: 116, a: 1);
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()];
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage.init(named: "back.png")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 20, 0, 0)), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        
        /**
         *  ???
         */
//        var leftButtonIcon = UIImage.init(named: "back.png");
//        var leftButton = UIBarButtonItem.init(image: leftButtonIcon, style: UIBarButtonItemStyle.Bordered, target: self, action: "goBack");
//        self.navigationItem.leftBarButtonItem = leftButton;
        //修复navigationController侧滑关闭失效的问题
//        self.navigationController!.interactivePopGestureRecognizer!.delegate = self;
    }
    
//    func goBack() -> Void {
//        self.navigationController?.popViewControllerAnimated(true)
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
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
