//
//  FirstGaussViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/5.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstGaussViewController: BaseViewController {
    
    var myImageView = UIImageView.init(frame: UIScreen.main.bounds)
    var effectview = UIVisualEffectView.init();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
        
    }
    func getView() -> Void {
        self.navigationItem.title = "gauss";
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "出现", style: UIBarButtonItemStyle.done, target: self, action: #selector(FirstGaussViewController.hideOnecut))
        self.myImageView.image = UIImage.init(named: "meinv.jpg")
        self.view.addSubview(self.myImageView);
        let slider = UISlider.init(frame: CGRect(x: 20, y: HEIGHT-60, width: WIDTH-40, height: 10))
        slider.addTarget(self, action: "sliderAction:", for: UIControlEvents.valueChanged)
        self.view.addSubview(slider)
        let blur = UIBlurEffect.init(style: UIBlurEffectStyle.dark)
        self.effectview = UIVisualEffectView.init(effect: blur)
        self.effectview.frame = CGRect(x: 50, y: 80, width: WIDTH-100, height: WIDTH-100);
        self.effectview.alpha = 0.8;
        self.view.addSubview(self.effectview)
        self.view.sendSubview(toBack: self.effectview)
    }
    
    func hideOnecut() -> Void {
        if self.navigationItem.rightBarButtonItem?.title == "出现" {
            self.view.bringSubview(toFront: self.effectview)
        }
        if self.navigationItem.rightBarButtonItem?.title == "隐藏" {
            self.view.sendSubview(toBack: self.effectview);
        }
        self.navigationItem.rightBarButtonItem?.title = self.navigationItem.rightBarButtonItem?.title == "出现" ? "隐藏": "出现";
    }
    
    func sliderAction(_ aSlider:UISlider) -> Void {
        let aImage = UIImage.init(named: "meinv.jpg")
        let aColor = UIColor.init(white: 1.3-CGFloat(aSlider.value), alpha: CGFloat(aSlider.value)/1.2)
        self.myImageView.image = aImage?.applyBlur(withRadius: CGFloat(aSlider.value)*30, tintColor: aColor, saturationDeltaFactor: 1.8, maskImage: nil)        
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
