//
//  FirstRadiateMenuViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/27.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstRadiateMenuViewController: BaseViewController, YFRadialMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        self.navigationItem.title = "发散菜单"
        let radialView = YFRadialMenu.init(frame: CGRect(x: WIDTH/2-25, y: HEIGHT-120, width: 50, height: 50))
        radialView.delegate = self;
        radialView.centerView.backgroundColor = UIColor.gray;
        radialView.addPopoutView(nil, withIndentifier: "ONE")
        radialView.addPopoutView(nil, withIndentifier: "TWO")
        radialView.addPopoutView(nil, withIndentifier: "THREE")
        radialView.addPopoutView(nil, withIndentifier: "FOUR")
        self.view.addSubview(radialView)
        radialView.enableDevelopmentMode(self)
    }
    
    func radialMenu(_ radialMenu: YFRadialMenu!, didSelectPopoutWithIndentifier identifier: String!) {
        NSLog("%@",identifier);
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
