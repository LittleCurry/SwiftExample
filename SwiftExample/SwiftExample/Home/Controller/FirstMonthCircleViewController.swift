//
//  FirstMonthCircleViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/11/16.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

extension CALayer {
    
    func borderUIColor() -> UIColor? {
        return borderColor != nil ? UIColor(cgColor: borderColor!) : nil
    }
    
    func setBorderUIColor(_ color: UIColor) {
        borderColor = color.cgColor
    }
}

class FirstMonthCircleViewController: BaseViewController {
    
    var midCircle : MidPointCircularSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        self.navigationItem.title = "某月的日期"
        self.view.backgroundColor = RGBA(97, g: 87, b: 110, a: 1)
        
        self.midCircle = MidPointCircularSlider.init(frame: CGRect(x:30, y:120, width:WIDTH-60, height:WIDTH-60))
        self.midCircle.lineWidth = 15
        self.midCircle.thumbRadius = 10
        self.midCircle.distance = 0.15
        // 方形bgc
        self.midCircle.backgroundColor = UIColor.clear
        // 未走线bgc
        self.midCircle.trackColor = RGBA(54, g: 214, b: 251, a: 1)
        // 走过的线bgc
        self.midCircle.trackFillColor = RGBA(232, g: 51, b: 99, a: 1)
        // 拇指未点击小圆bgc
        self.midCircle.midThumbStrokeColor = RGBA(54, g: 214, b: 251, a: 1)
        // 拇指小圆高亮bgc
        self.midCircle.midThumbStrokeHighlightedColor = RGBA(232, g: 51, b: 99, a: 1)
        // 圆盘bgc
        self.midCircle.diskColor = UIColor.clear
        // 走过的扇形区域bgc
        self.midCircle.diskFillColor = RGBA(54, g: 214, b: 251, a: 0.1)
        self.view.addSubview(self.midCircle)
        
        let midLabel = UILabel.init(frame: CGRect(x:PART_W(self.midCircle)/8, y:PART_H(self.midCircle)/8, width:PART_W(self.midCircle)*3/4, height:PART_H(self.midCircle)*3/4))
        midLabel.layer.masksToBounds = true;
        midLabel.layer.cornerRadius = PART_W(midLabel)/2;
        midLabel.layer.borderWidth = 1;//设置边界的宽度
        midLabel.layer.borderColor = UIColor.white.cgColor;
        midLabel.font = UIFont.systemFont(ofSize: 25)
        midLabel.textColor = UIColor.white
        midLabel.textAlignment = .center
        midLabel.text = "April"
        self.midCircle.addSubview(midLabel)
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
