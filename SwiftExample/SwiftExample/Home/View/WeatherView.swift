//
//  WeatherView.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/10.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    var weekLabel:UILabel?;
    var weatherImage:UIImageView?;
    var temperatureLabel:UILabel?;
    var cloudLabel:UILabel?;
    var windLabel:UILabel?;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.weekLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height/8));
        self.weatherImage = UIImageView.init(frame: CGRect(x: frame.size.width/2-30, y: frame.size.height/8, width: 60, height: 81))
        self.temperatureLabel = UILabel.init(frame: CGRect(x: 0, y: Y(self.weatherImage!)+PART_H(self.weatherImage!), width: frame.size.width, height: 30));
        self.cloudLabel = UILabel.init(frame: CGRect(x: 0, y: Y(self.temperatureLabel!)+PART_H(self.temperatureLabel!), width: frame.size.width, height: 14));
        self.windLabel = UILabel.init(frame: CGRect(x: 0, y: Y(self.cloudLabel!)+PART_H(self.cloudLabel!), width: frame.size.width, height: 14));
        
        self.weekLabel?.textAlignment = NSTextAlignment.center
        self.weekLabel?.textColor = UIColor.white
        self.weekLabel?.font = UIFont.systemFont(ofSize: 14)
        
        self.temperatureLabel?.textAlignment = NSTextAlignment.center
        self.temperatureLabel?.textColor = UIColor.white
        self.temperatureLabel?.font = UIFont.systemFont(ofSize: 22)
        
        self.cloudLabel?.textAlignment = NSTextAlignment.center
        self.cloudLabel?.textColor = UIColor.white
        self.cloudLabel?.font = UIFont.systemFont(ofSize: 12)
        
        self.windLabel?.textAlignment = NSTextAlignment.center
        self.windLabel?.textColor = UIColor.white
        self.windLabel?.font = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(self.weekLabel!);
        self.addSubview(self.weatherImage!);
        self.addSubview(self.temperatureLabel!);
        self.addSubview(self.cloudLabel!);
        self.addSubview(self.windLabel!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
