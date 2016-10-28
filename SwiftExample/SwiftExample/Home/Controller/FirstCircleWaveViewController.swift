//
//  FirstCircleWaveViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/27.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstCircleWaveViewController: BaseViewController {
    
    var rippleView : RippleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        self.navigationItem.title = "水波"
        let context = EAGLContext.init(API: EAGLRenderingAPI.OpenGLES2)
        self.rippleView = RippleView.init(frame: self.view.bounds, context: context)
        self.view.addSubview(self.rippleView!)
        let pan = UIPanGestureRecognizer.init(target: self, action: "handleGesture:")
        self.rippleView?.addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer.init(target: self, action: "handleGesture:")
        self.rippleView?.addGestureRecognizer(tap)
    }
    
    func handleGesture(gesture:UITapGestureRecognizer) -> Void {
        let location = gesture.locationInView(self.rippleView)
        self.rippleView?.ripple.initiateRippleAtLocation(location)
        
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
