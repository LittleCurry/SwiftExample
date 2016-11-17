//
//  FirstClockViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/11/16.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

extension Date {
    
}

class FirstClockViewController: BaseViewController {
    
    var durationLabel : UILabel!
    var myBedtimeLabel : UILabel!
    var myWakeLabel : UILabel!
    var rangeCircularSlider : RangeCircularSlider!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        
        self.navigationItem.title = "闹钟设置"
        self.view.backgroundColor = UIColor.black
        
        let bedImage = UIImageView.init(frame: CGRect(x:WIDTH/4-50, y:90, width:20, height:20))
        bedImage.image = UIImage(named: "ic_bedtime.png")
        self.view.addSubview(bedImage)
        let bedLabel = UILabel.init(frame: CGRect(x:WIDTH/4-30, y:85, width:80, height:30))
        bedLabel.textColor = RGBA(252, g: 191, b: 47, a: 1)
        bedLabel.text = "BedTime"
        self.view.addSubview(bedLabel)
        let wakeImage = UIImageView.init(frame: CGRect(x:WIDTH*3/4-50, y:90, width:20, height:20))
        wakeImage.image = UIImage(named: "ic_wake.png")
        self.view.addSubview(wakeImage)
        let wakeLabel = UILabel.init(frame: CGRect(x:WIDTH*3/4-30, y:85, width:80, height:30))
        wakeLabel.textColor = UIColor.yellow
        wakeLabel.text = "WkeTime"
        self.view.addSubview(wakeLabel)
        
        
        
        self.myBedtimeLabel = UILabel.init(frame: CGRect(x:0, y:120, width:WIDTH/2, height:30))
        self.myBedtimeLabel.textAlignment = .center
        self.myBedtimeLabel.textColor = UIColor.white
        self.myBedtimeLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.myBedtimeLabel)
        self.myWakeLabel = UILabel.init(frame: CGRect(x:WIDTH/2, y:120, width:WIDTH/2, height:30))
        self.myWakeLabel.textAlignment = .center
        self.myWakeLabel.textColor = UIColor.white
        self.myWakeLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.myWakeLabel)
        
        self.rangeCircularSlider = RangeCircularSlider.init(frame: CGRect(x:20, y:150, width:WIDTH-40, height:WIDTH-40))
        self.rangeCircularSlider.addTarget(self, action: #selector(updateTexts(_:)), for: .valueChanged)
        self.view.addSubview(self.rangeCircularSlider)
        self.durationLabel = UILabel.init(frame: CGRect(x:0, y:PART_H(self.rangeCircularSlider)/2-20, width:PART_W(self.rangeCircularSlider), height:40))
        self.durationLabel.textAlignment = .center
        self.durationLabel.textColor = UIColor.white
        self.durationLabel.font = UIFont.systemFont(ofSize: 25)
        self.rangeCircularSlider.addSubview(self.durationLabel)
        
        rangeCircularSlider.trackFillColor = RGBA(252, g: 191, b: 47, a: 1)
        rangeCircularSlider.diskColor = UIColor.black
        rangeCircularSlider.diskFillColor = UIColor.black
        rangeCircularSlider.trackColor = UIColor.darkGray
        rangeCircularSlider.contentMode = .scaleToFill
        rangeCircularSlider.lineWidth = 40
        rangeCircularSlider.startThumbImage = UIImage(named: "bedtime.png")?.scale(to: CGSize(width:40, height: 40)).circleImage(withParam: 0)
        rangeCircularSlider.endThumbImage = UIImage(named: "wake.png")?.scale(to: CGSize(width:40, height: 40)).circleImage(withParam: 0)
        rangeCircularSlider.maximumValue = CGFloat(24 * 60 * 60)
        rangeCircularSlider.startPointValue = CGFloat(1 * 60 * 60)
        rangeCircularSlider.endPointValue = CGFloat(8 * 60 * 60)
        updateTexts(rangeCircularSlider)
    }
    
    func updateTexts(_ sender: AnyObject) {
        let bedtime = TimeInterval(rangeCircularSlider.startPointValue)
        let bedtimeDate = Date(timeIntervalSinceReferenceDate: bedtime)
        myBedtimeLabel.text = dateFormatter.string(from: bedtimeDate)
        
        let wake = TimeInterval(rangeCircularSlider.endPointValue)
        let wakeDate = Date(timeIntervalSinceReferenceDate: wake)
        myWakeLabel.text = dateFormatter.string(from: wakeDate)
        
        let duration = wake - bedtime
        let durationDate = Date(timeIntervalSinceReferenceDate: duration)
        dateFormatter.dateFormat = "HH:mm"
        durationLabel.text = dateFormatter.string(from: durationDate)
        dateFormatter.dateFormat = "hh:mm a"
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
