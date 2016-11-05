//
//  FirstWeatherViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/9.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstWeatherViewController: BaseViewController {
    
    let myTitleButton = UIButton.init(type: UIButtonType.system)
    var myTitleLabel = UILabel.init()
    let locationImage = UIImageView.init()
    var bigImageView = UIImageView.init()
    var middleImageView = UIImageView.init()
    var temperatureLabel = UILabel.init()
    var cloudLabel = UILabel.init()
    var windLabel = UILabel.init()
    var PMLabel = UILabel.init()
    var weatherArr : NSMutableArray = [];
    var weatherView1 = WeatherView.init(frame: CGRect(x: 0, y: HEIGHT-200, width: WIDTH/3, height: 200))
    var weatherView2 = WeatherView.init(frame: CGRect(x: WIDTH/3, y: HEIGHT-200, width: WIDTH/3, height: 200))
    var weatherView3 = WeatherView.init(frame: CGRect(x: WIDTH*2/3, y: HEIGHT-200, width: WIDTH/3, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
        self.getData("上海|上海")
    }
    
    func getView() -> Void {
        
        self.myTitleButton.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        self.myTitleButton.addTarget(self, action: #selector(FirstWeatherViewController.choseCity), for: UIControlEvents.touchUpInside)
        self.navigationItem.titleView = self.myTitleButton;
        self.myTitleLabel.frame = CGRect(x: 0, y: 0, width: 160, height: 44);
        self.myTitleLabel.textAlignment = NSTextAlignment.center
        self.myTitleButton.addSubview(self.myTitleLabel)
        self.changeTitle("上海")
        self.locationImage.image = UIImage.init(named: "location.png")?.change(with: UIColor.white)
        self.myTitleButton.addSubview(self.locationImage)
    
        self.bigImageView.frame = UIScreen.main.bounds
        self.bigImageView.sd_setImage(withURL: "http://img1.cache.netease.com/m/newsapp/weather/TianQi1008/DuoYun.jpg")
        self.view.addSubview(self.bigImageView)
        self.middleImageView.frame = CGRect(x: WIDTH/2-100, y: HEIGHT/2-135, width: 100, height: 135)
        print(self.middleImageView.center)
        self.middleImageView.image = UIImage.init(named: "sunandcloud")
        self.view.addSubview(self.middleImageView)
        
        self.temperatureLabel.frame = CGRect(x: WIDTH/2, y: HEIGHT/2-135, width: 160, height: 30)
        self.temperatureLabel.textColor = UIColor.white
        self.temperatureLabel.font = UIFont.systemFont(ofSize: 25)
        self.temperatureLabel.text = "20℃/10℃"
        self.view.addSubview(self.temperatureLabel)
        
        self.cloudLabel.frame = CGRect(x: WIDTH/2, y: HEIGHT/2-105, width: 100, height: 20)
        self.cloudLabel.textColor = UIColor.white
        self.cloudLabel.font = UIFont.systemFont(ofSize: 12)
        self.cloudLabel.text = "多云"
        self.view.addSubview(self.cloudLabel)
        
        self.windLabel.frame = CGRect(x: WIDTH/2, y: HEIGHT/2-85, width: 100, height: 20)
        self.windLabel.textColor = UIColor.white
        self.windLabel.font = UIFont.systemFont(ofSize: 12)
        self.windLabel.text = "微风"
        self.view.addSubview(self.windLabel)
        
        self.PMLabel.frame = CGRect(x: WIDTH/2, y: HEIGHT/2-65, width: 100, height: 20)
        self.PMLabel.textColor = UIColor.white
        self.PMLabel.font = UIFont.systemFont(ofSize: 12)
        self.PMLabel.text = "PM2.5 0"
        self.view.addSubview(self.PMLabel)
        
        let blur = UIBlurEffect.init(style: UIBlurEffectStyle.dark)
        let effectview = UIVisualEffectView.init(effect: blur)
        effectview.frame = CGRect(x: 0, y: HEIGHT - 230, width: WIDTH, height: 230);
        effectview.alpha = 0.3;
        self.view.addSubview(effectview)
        self.view.addSubview(self.weatherView1)
        self.view.addSubview(self.weatherView2)
        self.view.addSubview(self.weatherView3)
    }
    
    func choseCity() -> Void {
        let cityVC = FirstProvinceCityViewController.init()
        //将当前someFunctionThatTakesAClosure函数指针传到第二个界面，第二个界面的闭包拿到该函数指针后会进行回调该函
        cityVC.initWithClosure(someFunctionThatTakesAClosure)
        cityVC.myCurrentCity = oneCity
        self.navigationController!.pushViewController(cityVC,animated:true)
    }
    
    var oneCity = "上海"
    func someFunctionThatTakesAClosure(_ group:ProvinceCities) -> Void {
        self.changeTitle(group.city)
        self.getData(group.province+"|"+group.city)
        oneCity = group.city
    }
    
    func changeTitle(_ oneTitle:String) -> Void {
        self.myTitleLabel.text = oneTitle
        self.myTitleLabel.sizeToFit()
        self.myTitleLabel.frame = CGRect(x: PART_W(self.myTitleButton)/2-PART_W(self.myTitleLabel)/2-15, y: PART_H(self.myTitleLabel)/2, width: PART_W(self.myTitleLabel), height: PART_H(self.myTitleLabel))
        locationImage.frame = CGRect(x: X(self.myTitleLabel)+PART_W(self.myTitleLabel)+3, y: 10, width: 24, height: 24)
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
    
    func getData(_ location:String) -> Void {
        let urlStr = "http://c.3g.163.com/nc/weather/"+location+".html"
        NetHandler.getDataWithUrl(urlStr, parameters: nil, tokenKey: "", tokenValue: "", ifCaches: false, cachesData: { (cacheData) in
            //
            }, success: { (successData) in
                let dict = try! JSONSerialization.jsonObject(with: successData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                print(dict)
                let today = dict["pm2d5"] as! NSDictionary;
                self.bigImageView.sd_setImage(withURL: today["nbg2"] as! String)
                if((today["pm2_5"]) != nil){
                    self.PMLabel.text = "PM2.5 " + (today["pm2_5"] as! String)
                }
                let dataArr = dict[location] as! NSMutableArray;
                print(dataArr)
                self.weatherArr.removeAllObjects()
                for oneDic in dataArr {
                    let weather = Weather.objectWithDictionary(oneDic as! [String : AnyObject]) as? Weather
                    self.weatherArr.add(weather!);
                }
                
                if(self.weatherArr.count >= 4){
                    
                    let weather0 = self.weatherArr[0] as! Weather;
                    let weather1 = self.weatherArr[1] as! Weather;
                    let weather2 = self.weatherArr[2] as! Weather;
                    let weather3 = self.weatherArr[3] as! Weather;
                    
                    self.middleImageView.image = UIImage.init(named: self.weatherImage(weather0.climate))
                    UIView.animate(withDuration: 1, animations: {
                        self.middleImageView.transform =
                            CGAffineTransform(scaleX: 0.6, y: 0.6);
                        }, completion: { (isFinish) in
                            UIView.animate(withDuration: 1, animations: {
                                self.middleImageView.transform =
                                    CGAffineTransform(scaleX: 1.0, y: 1.0);
                            })
                    })
                    self.temperatureLabel.text = weather0.temperature
                    self.cloudLabel.text = weather0.climate
                    self.windLabel.text = weather0.wind
                    
                    self.weatherView1.weekLabel?.text = weather1.week
                    self.weatherView1.weatherImage?.image = UIImage.init(named: self.weatherImage(weather1.climate))
                    self.weatherView1.temperatureLabel?.text = weather1.temperature.replacingOccurrences(of: "C", with: "", options: NSString.CompareOptions.literal, range: nil)
                    self.weatherView1.cloudLabel?.text = weather1.climate
                    self.weatherView1.windLabel?.text = weather1.wind
                    self.weatherView2.weekLabel?.text = weather2.week
                    self.weatherView2.weatherImage?.image = UIImage.init(named: self.weatherImage(weather2.climate))
                    self.weatherView2.temperatureLabel?.text = weather2.temperature.replacingOccurrences(of: "C", with: "", options: NSString.CompareOptions.literal, range: nil)
                    self.weatherView2.cloudLabel?.text = weather2.climate
                    self.weatherView2.windLabel?.text = weather2.wind
                    self.weatherView3.weekLabel?.text = weather3.week
                    self.weatherView3.weatherImage?.image = UIImage.init(named: self.weatherImage(weather3.climate))
                    self.weatherView3.temperatureLabel?.text = weather3.temperature.replacingOccurrences(of: "C", with: "", options: NSString.CompareOptions.literal, range: nil)
                    self.weatherView3.cloudLabel?.text = weather3.climate
                    self.weatherView3.windLabel?.text = weather3.wind
                }
            }, failure: { (failData) in
        })
    }
    
    func weatherImage(_ wearherStr:String) -> String {
        if (wearherStr == "雷阵雨") {
            return "thunder"
        }else if(wearherStr == "晴"){
            return "sun"
        }else if(wearherStr == "多云"){
            return "sunandcloud"
        }else if(wearherStr == "阴"){
            return "cloud"
        }else if(wearherStr.hasSuffix("雨")){
            return "rain"
        }else if(wearherStr.hasSuffix("雪")){
            return "snow"
        }else{
            return "sandfloat";
        }
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
