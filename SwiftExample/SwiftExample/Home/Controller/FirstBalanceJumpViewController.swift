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
        self.view.backgroundColor = UIColor.orange
//        let waterView = LXHTwoWaterWaveView.init(frame: self.view.bounds)
//        self.view.addSubview(waterView)
        let tomorrowLabel = UILabel.init(frame: CGRect(x: 0, y: 140, width: WIDTH, height: 20))
        tomorrowLabel.textColor = UIColor.white
        tomorrowLabel.textAlignment = .center
        tomorrowLabel.font = UIFont.systemFont(ofSize: 15)
        tomorrowLabel.text = "昨日收益(元)"
        self.view.addSubview(tomorrowLabel)
        let balanceLabel = UILabel.init(frame: CGRect(x: 0, y: 160, width: WIDTH, height: 60))
        balanceLabel.textColor = UIColor.white
        balanceLabel.textAlignment = .center
        balanceLabel.font = UIFont.systemFont(ofSize: 40)
        balanceLabel.animationFromnum(0, toNum: 8668, duration: 2)
        self.view.addSubview(balanceLabel)
        
        let waveView = JSWave.init(frame: CGRect(x: 0, y: 260, width: WIDTH, height: 20))
        self.view.addSubview(waveView)
        waveView.waveBlock = { (currentY) in
            // print(currentY)
        }
        waveView.startAnimation()
        
        let subView = UIView.init(frame: CGRect(x: 0, y: 280, width: WIDTH, height: HEIGHT-280))
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
