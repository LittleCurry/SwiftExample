//
//  FirstHiddenWordViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/20.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstHiddenWordViewController: BaseViewController {
    
    var shineLabel:RQShineLabel?;
    var textArray:NSArray?;
    var textIndex:Int?;
    var wallpaper1:UIImageView?;
    var wallpaper2:UIImageView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        //
        self.navigationItem.title = "文字渐变"
        self.textArray = [
            "For something this complicated, it’s really hard to design products by focus groups. A lot of times, people don’t know what they want until you show it to them.",
            "We’re just enthusiastic about what we do.",
            "We made the buttons on the screen look so good you’ll want to lick them."
        ];
        self.textIndex  = 0;
        self.wallpaper1 = UIImageView.init(frame: self.view.bounds)
//        self.wallpaper1?.contentMode = UIViewContentMode.ScaleAspectFill
        self.wallpaper1?.image = UIImage.init(named: "autumn1.jpg")
        self.view.addSubview(self.wallpaper1!)
        self.wallpaper2 = UIImageView.init(frame: self.view.bounds)
        self.wallpaper2!.alpha = 0;
//        self.wallpaper2?.contentMode = UIViewContentMode.ScaleAspectFill
        self.wallpaper2?.image = UIImage.init(named: "autumn2.jpg")
        self.view.addSubview(self.wallpaper2!)
        self.shineLabel = RQShineLabel.init(frame: CGRectMake(16, 16, 320 - 32, CGRectGetHeight(self.view.bounds) - 16))
        self.shineLabel?.backgroundColor = UIColor.clearColor()
        self.shineLabel?.numberOfLines = 0
        self.shineLabel?.text = self.textArray![self.textIndex!] as? String
        self.shineLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 24)
        self.shineLabel?.sizeToFit()
        self.shineLabel?.center = self.view.center
        self.view.addSubview(self.shineLabel!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.shineLabel?.shine()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        if (self.shineLabel?.visible == true) {
            self.shineLabel?.fadeOutWithCompletion({
                self.changeText();
                UIView.animateWithDuration(2.5, animations: {
                    if (self.wallpaper1!.alpha > 0.1) {
                        self.wallpaper1!.alpha = 0;
                        self.wallpaper2!.alpha = 1;
                    }
                    else {
                        self.wallpaper1!.alpha = 1;
                        self.wallpaper2!.alpha = 0;
                    }
                })
                self.shineLabel!.shine()
            })
        }else {
            self.shineLabel!.shine()
        }
    }
    
    func changeText() -> Void {
        self.textIndex = self.textIndex!+1
        self.shineLabel?.text = self.textArray![self.textIndex! % self.textArray!.count] as? String
    }
    
//    -(UIStatusBarStyle)preferredStatusBarStyle
//    {
//    return UIStatusBarStyleLightContent;
//    }
    
    
    
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
