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
//        let waterView = LXHTwoWaterWaveView.init(frame: self.view.bounds)
//        self.view.addSubview(waterView)
        let tomorrowLabel = UILabel.init(frame: CGRectMake(0, 140, WIDTH, 20))
        tomorrowLabel.textColor = UIColor.whiteColor()
        tomorrowLabel.textAlignment = .Center
        tomorrowLabel.font = UIFont.systemFontOfSize(15)
        tomorrowLabel.text = "昨日收益(元)"
        self.view.addSubview(tomorrowLabel)
        let balanceLabel = UILabel.init(frame: CGRectMake(0, 160, WIDTH, 60))
        balanceLabel.textColor = UIColor.whiteColor()
        balanceLabel.textAlignment = .Center
        balanceLabel.font = UIFont.systemFontOfSize(40)
        balanceLabel.animationFromnum(0, toNum: 8668, duration: 2)
        self.view.addSubview(balanceLabel)
        
        let waveView = JSWave.init(frame: CGRectMake(0, 260, WIDTH, 20))
        self.view.addSubview(waveView)
        waveView.waveBlock = { (currentY) in
            // print(currentY)
        }
        waveView.startWaveAnimation()
        
        let subView = UIView.init(frame: CGRectMake(0, 280, WIDTH, HEIGHT-280))
        subView.backgroundColor = RGBA(29, g: 173, b: 238, a: 1)
        self.view.addSubview(subView)
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
