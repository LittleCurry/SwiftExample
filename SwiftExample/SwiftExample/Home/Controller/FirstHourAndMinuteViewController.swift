//
//  FirstHourAndMinuteViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/11/16.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstHourAndMinuteViewController: BaseViewController {
    
    var minutesCircularSlider: CircularSlider!
    var hoursCircularSlider: CircularSlider!
    var hoursLabel: UILabel!
    var minutesLabel: UILabel!
    var AMPMLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        self.navigationItem.title = "时分"
        self.view.backgroundColor = RGBA(32, g: 37, b: 54, a: 1)
        
        let seg = UISegmentedControl.init(items: ["AM", "PM"])
        seg.frame = CGRect(x:WIDTH/2-60, y:80,width:120, height:30)
        seg.tintColor = RGBA(187, g: 173, b: 70, a: 1)
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(switchBetweenAMAndPM), for: .valueChanged)
        self.view.addSubview(seg)
        
        let bigImage = UIImageView.init(frame: CGRect(x:40, y:130,width:WIDTH-80, height:WIDTH-80))
        bigImage.image = UIImage.init(named: "time_indicators.png")
//        self.view.addSubview(bigImage)
        
        // minutes
        self.minutesCircularSlider = CircularSlider.init(frame: CGRect(x:40, y:140,width:WIDTH-80, height:WIDTH-80))
        self.minutesCircularSlider.backgroundColor = UIColor.clear
        self.minutesCircularSlider.diskColor = UIColor.clear
        self.minutesCircularSlider.trackColor = RGBA(255, g: 255, b: 255, a: 0.1)
        self.minutesCircularSlider.trackFillColor = RGBA(187, g: 173, b: 70, a: 1)
        self.minutesCircularSlider.endThumbStrokeColor = UIColor.white
        self.minutesCircularSlider.endThumbStrokeHighlightedColor = RGBA(187, g: 173, b: 70, a: 1)
        self.minutesCircularSlider.lineWidth = 2
        self.minutesCircularSlider.thumbRadius = 2
        self.minutesCircularSlider.minimumValue = 0
        self.minutesCircularSlider.maximumValue = 60
        self.minutesCircularSlider.endPointValue = 35
        self.minutesCircularSlider.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        self.minutesCircularSlider.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        self.view.addSubview(self.minutesCircularSlider)
        
        // hours
        self.hoursCircularSlider = CircularSlider.init(frame: CGRect(x:60, y:160,width:WIDTH-120, height:WIDTH-120))
        self.hoursCircularSlider.backgroundColor = UIColor.clear
        self.hoursCircularSlider.diskColor = UIColor.clear
        self.hoursCircularSlider.trackColor = RGBA(255, g: 255, b: 255, a: 0.1)
        self.hoursCircularSlider.trackFillColor = RGBA(187, g: 173, b: 70, a: 1)
        self.hoursCircularSlider.endThumbStrokeColor = UIColor.white
        self.hoursCircularSlider.endThumbStrokeHighlightedColor = RGBA(187, g: 173, b: 70, a: 1)
        self.hoursCircularSlider.lineWidth = 4
        self.hoursCircularSlider.thumbRadius = 4
        self.hoursCircularSlider.minimumValue = 0
        self.hoursCircularSlider.maximumValue = 12
        self.hoursCircularSlider.endPointValue = 6
        self.hoursCircularSlider.addTarget(self, action: #selector(updateHours), for: .valueChanged)
        self.hoursCircularSlider.addTarget(self, action: #selector(adjustHours), for: .editingDidEnd)
        self.view.addSubview(self.hoursCircularSlider)
        
        self.AMPMLabel = UILabel.init(frame: CGRect(x:PART_W(self.minutesCircularSlider)/2-40, y:PART_H(self.minutesCircularSlider)/2-55,width:80, height:30))
        self.AMPMLabel.textColor = RGBA(187, g: 173, b: 70, a: 1)
        self.AMPMLabel.textAlignment = .center
        self.AMPMLabel.font = UIFont.systemFont(ofSize: 16)
        self.AMPMLabel.text = "AM"
        self.minutesCircularSlider.addSubview(self.AMPMLabel)
        
        self.hoursLabel = UILabel.init(frame: CGRect(x:PART_W(self.minutesCircularSlider)/2-85, y:PART_H(self.minutesCircularSlider)/2-25,width:80, height:50))
        self.hoursLabel.textAlignment = .center
        self.hoursLabel.font = UIFont.systemFont(ofSize: 44)
        self.hoursLabel.textColor = RGBA(187, g: 173, b: 70, a: 1)
        self.hoursLabel.text = "06"
        self.minutesCircularSlider.addSubview(self.hoursLabel)
        let dianLabel = UILabel.init(frame: CGRect(x:PART_W(self.minutesCircularSlider)/2-5, y:PART_H(self.minutesCircularSlider)/2-25, width:10, height:50))
        dianLabel.textAlignment = .center
        dianLabel.textColor = RGBA(187, g: 173, b: 70, a: 1)
        dianLabel.font = UIFont.boldSystemFont(ofSize: 44)
        dianLabel.text = ":"
        self.minutesCircularSlider.addSubview(dianLabel)
        self.minutesLabel = UILabel.init(frame: CGRect(x:PART_W(self.minutesCircularSlider)/2+5, y:PART_H(self.minutesCircularSlider)/2-25,width:80, height:50))
        self.minutesLabel.textAlignment = .center
        self.minutesLabel.font = UIFont.systemFont(ofSize: 44)
        self.minutesLabel.textColor = RGBA(187, g: 173, b: 70, a: 1)
        self.minutesLabel.text = "35"
        self.minutesCircularSlider.addSubview(self.minutesLabel)
        
        let weekLabel = UILabel.init(frame: CGRect(x:PART_W(self.minutesCircularSlider)/2-40, y:PART_H(self.minutesCircularSlider)/2+25, width:80, height:30))
        weekLabel.textAlignment = .center
        weekLabel.textColor = RGBA(187, g: 173, b: 70, a: 1)
        weekLabel.font = UIFont.systemFont(ofSize: 16)
        weekLabel.text = "MONDAY"
        self.minutesCircularSlider.addSubview(weekLabel)
    }
    
    // MARK: user interaction methods
    func updateHours() {
        var selectedHour = Int(self.hoursCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedHour = (selectedHour == 0 ? 12 : selectedHour)
        self.hoursLabel.text = String(format: "%02d", selectedHour)
    }
    
    func adjustHours() {
        let selectedHour = round(self.hoursCircularSlider.endPointValue)
        self.hoursCircularSlider.endPointValue = selectedHour
        updateHours()
    }
    
    func updateMinutes() {
        var selectedMinute = Int(self.minutesCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedMinute = (selectedMinute == 60 ? 0 : selectedMinute)
        self.minutesLabel.text = String(format: "%02d", selectedMinute)
    }
    
    func adjustMinutes() {
        let selectedMinute = round(self.minutesCircularSlider.endPointValue)
        self.minutesCircularSlider.endPointValue = selectedMinute
        updateMinutes()
    }
    
    func switchBetweenAMAndPM(_ sender: UISegmentedControl) {
        self.AMPMLabel.text = sender.selectedSegmentIndex == 0 ? "AM" : "PM"
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
