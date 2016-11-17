//
//  FirstHourAndMinuteViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/11/16.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstHourAndMinuteViewController: BaseViewController {
    
    var midCircle : MidPointCircularSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        self.navigationItem.title = "时分"
        self.midCircle = MidPointCircularSlider.init(frame: CGRect(x:30, y:120, width:WIDTH-60, height:WIDTH-60))
        self.view.addSubview(self.midCircle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
