//
//  FirstGaussViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/5.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstGaussViewController: BaseViewController {
    
    var myImageView = UIImageView.init(frame: UIScreen.mainScreen().bounds)
    var effectview = UIVisualEffectView.init();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
        
    }
    func getView() -> Void {
        self.navigationItem.title = "gauss";
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "出现", style: UIBarButtonItemStyle.Done, target: self, action: "hideOnecut")
        self.myImageView.image = UIImage.init(named: "meinv.jpg")
        self.view.addSubview(self.myImageView);
        let slider = UISlider.init(frame: CGRectMake(20, HEIGHT-60, WIDTH-40, 10))
        slider.addTarget(self, action: "sliderAction:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(slider)
        var blur = UIBlurEffect.init(style: UIBlurEffectStyle.Dark)
        self.effectview = UIVisualEffectView.init(effect: blur)
        self.effectview.frame = CGRectMake(50, 80, WIDTH-100, WIDTH-100);
        self.effectview.alpha = 0.8;
        self.view.addSubview(self.effectview)
        self.view.sendSubviewToBack(self.effectview)
    }
    
    func hideOnecut() -> Void {
        if self.navigationItem.rightBarButtonItem?.title == "出现" {
            self.view.bringSubviewToFront(self.effectview)
        }
        if self.navigationItem.rightBarButtonItem?.title == "隐藏" {
            self.view.sendSubviewToBack(self.effectview);
        }
        self.navigationItem.rightBarButtonItem?.title = self.navigationItem.rightBarButtonItem?.title == "出现" ? "隐藏": "出现";
    }
    
    func sliderAction(aSlider:UISlider) -> Void {
        let aImage = UIImage.init(named: "meinv.jpg")
        let aColor = UIColor.init(white: 1.3-CGFloat(aSlider.value), alpha: CGFloat(aSlider.value)/1.2)
        self.myImageView.image = aImage?.applyBlurWithRadius(CGFloat(aSlider.value)*30, tintColor: aColor, saturationDeltaFactor: 1.8, maskImage: nil)        
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
