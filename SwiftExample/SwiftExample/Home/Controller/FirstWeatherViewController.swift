//
//  FirstWeatherViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/9.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstWeatherViewController: BaseViewController {
    var bigImageView = UIImageView.init()
    var middleImageView = UIImageView.init()
    var temperatureLabel = UILabel.init()
    var cloudLabel = UILabel.init()
    var windLabel = UILabel.init()
    var PMLabel = UILabel.init()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "天气"
        self.bigImageView.frame = UIScreen.mainScreen().bounds
        self.bigImageView.image = UIImage.init(named: "meinv.jpg")
        self.view.addSubview(self.bigImageView)
        
        self.middleImageView.frame = CGRectMake(WIDTH/4, 100, WIDTH/4, WIDTH/4)
        self.middleImageView.image = UIImage.init(named: "meinv.jpg")
        self.view.addSubview(self.middleImageView)
        
        self.temperatureLabel.frame = CGRectMake(WIDTH/2, 100, 100, 30)
        self.temperatureLabel.textColor = UIColor.whiteColor()
        self.temperatureLabel.font = UIFont.systemFontOfSize(25)
        self.temperatureLabel.text = "18/12"
        self.view.addSubview(self.temperatureLabel)
        
        self.cloudLabel.frame = CGRectMake(WIDTH/2, 100, 100, 30)
        self.cloudLabel.textColor = UIColor.whiteColor()
        self.cloudLabel.font = UIFont.systemFontOfSize(12)
        self.cloudLabel.text = "多云"
        self.view.addSubview(self.cloudLabel)
        
        self.windLabel.frame = CGRectMake(WIDTH/2, 100, 100, 30)
        self.windLabel.textColor = UIColor.whiteColor()
        self.windLabel.font = UIFont.systemFontOfSize(12)
        self.windLabel.text = "微风"
        self.view.addSubview(self.windLabel)
        
        self.PMLabel.frame = CGRectMake(WIDTH/2, 100, 100, 30)
        self.PMLabel.textColor = UIColor.whiteColor()
        self.PMLabel.font = UIFont.systemFontOfSize(12)
        self.PMLabel.text = "PM2.5 123"
        self.view.addSubview(self.PMLabel)
        
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController!.setNavigationBarHidden(true, animated: true)
//        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true);
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController!.setNavigationBarHidden(false, animated: true)
//        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true);
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
