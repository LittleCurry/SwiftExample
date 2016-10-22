//
//  FirstBallTagViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/20.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstBallTagViewController: BaseViewController {
    
    var sphereView:DBSphereView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.sphereView = DBSphereView.init(frame: CGRectMake(20, 100, WIDTH-40, WIDTH-40));
        let array:NSMutableArray = []
        for i in 0...49 {
            let btn = UIButton.init(type: UIButtonType.System)
            btn.frame = CGRectMake(0, 0, 60, 20)
            btn.setTitle(String.init(format: "P%zd", i), forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(24)
            btn.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            array.addObject(btn)
            sphereView?.addSubview(btn)
        }
        sphereView?.setCloudTags(array as [AnyObject])
        self.view.addSubview(sphereView!)
    }
    
    func buttonPressed(btn:UIButton) -> Void {
        self.sphereView?.timerStop()
        UIView.animateWithDuration(0.3, animations: {
            btn.transform = CGAffineTransformMakeScale(2, 2);
            }) { (finished) in
                self.sphereView?.timerStart()
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
