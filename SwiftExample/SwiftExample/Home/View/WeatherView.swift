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
        self.weekLabel = UILabel.init(frame: CGRectMake(0, 0, frame.size.width, frame.size.height/8));
        self.weatherImage = UIImageView.init();
        if (frame.size.width > frame.size.height/2) {
            self.weatherImage?.frame = CGRectMake(frame.size.width/2-frame.size.height/4, frame.size.height/8, frame.size.height/2, frame.size.height/2)
        }
        if (frame.size.width <= frame.size.height/2) {
            self.weatherImage?.frame = CGRectMake(frame.size.width/2 - frame.size.width/2, frame.size.height/8, frame.size.width, frame.size.width)
        }
        
        self.temperatureLabel = UILabel.init(frame: CGRectMake(0, Y(self.weatherImage!)+PART_H(self.weatherImage!), frame.size.width, 30));
        self.cloudLabel = UILabel.init(frame: CGRectMake(0, Y(self.temperatureLabel!)+PART_H(self.temperatureLabel!), frame.size.width, 14));
        self.windLabel = UILabel.init(frame: CGRectMake(0, Y(self.cloudLabel!)+PART_H(self.cloudLabel!), frame.size.width, 14));
        
        self.weekLabel?.textAlignment = NSTextAlignment.Center
        self.weekLabel?.textColor = UIColor.whiteColor()
        self.weekLabel?.font = UIFont.systemFontOfSize(14)
        
        self.temperatureLabel?.textAlignment = NSTextAlignment.Center
        self.temperatureLabel?.textColor = UIColor.whiteColor()
        self.temperatureLabel?.font = UIFont.systemFontOfSize(22)
        
        self.cloudLabel?.textAlignment = NSTextAlignment.Center
        self.cloudLabel?.textColor = UIColor.whiteColor()
        self.cloudLabel?.font = UIFont.systemFontOfSize(12)
        
        self.windLabel?.textAlignment = NSTextAlignment.Center
        self.windLabel?.textColor = UIColor.whiteColor()
        self.windLabel?.font = UIFont.systemFontOfSize(12)
        
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
