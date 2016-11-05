//
//  FirstGraduallyColorViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/24.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstGraduallyColorViewController: BaseViewController {
    
    var gradientLayer = CAGradientLayer.init()
    var timer = Timer.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        
        self.navigationItem.title = "渐变色"
        let myImageView = UIImageView.init(frame: CGRect(x: 0, y: 64, width: WIDTH, height: WIDTH))
        myImageView.image = UIImage.init(named: "jigsaw.jpg")
        self.view.addSubview(myImageView)
        self.gradientLayer.frame = myImageView.bounds;
        myImageView.layer.addSublayer(self.gradientLayer)
        //设置渐变颜色方向
        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0);
        self.gradientLayer.endPoint = CGPoint(x: 0, y: 1);
        //设定颜色组
        self.gradientLayer.colors = [UIColor.clear.cgColor, UIColor.purple.cgColor]
        //设定颜色分割点
        self.gradientLayer.locations = [0.5, 1.0];
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(FirstGraduallyColorViewController.changColor), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.timer.invalidate()
    }
    
    func changColor() {
        //定时改变颜色
        self.gradientLayer.colors = [UIColor.clear.cgColor, RGBA(CGFloat(arc4random() % 255), g: CGFloat(arc4random() % 255), b: CGFloat(arc4random() % 255), a: 1).cgColor]
        //定时改变分割点
        self.gradientLayer.locations = [NSNumber.init(value: (Float(CGFloat(arc4random() % 10)/10.0))), 1.0];
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
