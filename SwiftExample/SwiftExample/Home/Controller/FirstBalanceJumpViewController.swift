//
//  FirstBalanceJumpViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/27.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstBalanceJumpViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        
        self.navigationItem.title = "余额"
        self.view.backgroundColor = UIColor.orangeColor()
        
        let waterView = LXHTwoWaterWaveView.init(frame: self.view.bounds)
        self.view.addSubview(waterView)
        
        let tomorrowLabel = UILabel.init(frame: CGRectMake(0, 180, WIDTH, 20))
        tomorrowLabel.textColor = UIColor.whiteColor()
        tomorrowLabel.textAlignment = .Center
        tomorrowLabel.font = UIFont.systemFontOfSize(15)
        tomorrowLabel.text = "昨日收益(元)"
        self.view.addSubview(tomorrowLabel)
        let balanceLabel = UILabel.init(frame: CGRectMake(0, 200, WIDTH, 60))
        balanceLabel.textColor = UIColor.whiteColor()
        balanceLabel.textAlignment = .Center
        balanceLabel.font = UIFont.systemFontOfSize(40)
        balanceLabel.animationFromnum(0, toNum: 8668, duration: 2)
        self.view.addSubview(balanceLabel)
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
