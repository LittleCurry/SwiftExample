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
        self.sphereView = DBSphereView.init(frame: CGRect(x: 20, y: 100, width: WIDTH-40, height: WIDTH-40));
        let array:NSMutableArray = []
        for i in 0...49 {
            let btn = UIButton.init(type: UIButtonType.system)
            btn.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
            btn.setTitle(String.init(format: "P%zd", i), for: UIControlState())
            btn.setTitleColor(UIColor.darkGray, for: UIControlState())
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            btn.addTarget(self, action: #selector(FirstBallTagViewController.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
            array.add(btn)
            sphereView?.addSubview(btn)
        }
        sphereView?.setCloudTags(array as [AnyObject])
        self.view.addSubview(sphereView!)
    }
    
    func buttonPressed(_ btn:UIButton) -> Void {
        self.sphereView?.timerStop()
        UIView.animate(withDuration: 0.3, animations: {
            btn.transform = CGAffineTransform(scaleX: 2, y: 2);
            }, completion: { (finished) in
                self.sphereView?.timerStart()
        }) 
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
