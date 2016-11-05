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
        self.view.backgroundColor = UIColor.white;
//        self.navigationController!.navigationBar.barTintColor = mainColor;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationController!.navigationBar.tintColor = UIColor.black;
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()];
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage.init(named: "back.png")!.change(with: UIColor.black).resizableImage(withCapInsets: UIEdgeInsetsMake(0, 20, 0, 0)), for: UIControlState(), barMetrics: UIBarMetrics.default)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
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
