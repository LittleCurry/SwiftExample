//
//  FirstDataChoseViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/11.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstDateChoseViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var provinceCitiesArr:NSMutableArray = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "日期选择"
        let datePick = UIDatePicker.init(frame: CGRectMake(0, 80, WIDTH, 216))
        datePick.datePickerMode = UIDatePickerMode.Date
//        pick.addTarget(self, action: "pickAction:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(datePick)
        
        let pickerView = UIPickerView.init(frame: CGRectMake(0, 296, WIDTH, 216))
        pickerView.delegate = self;
        pickerView.dataSource = self;
        self.view.addSubview(pickerView)
        
        let dictArray = NSMutableArray.init(contentsOfFile: NSBundle.mainBundle().pathForResource("city.plist", ofType: nil)!)
        for dict in dictArray! {
            let group = ProvinceCities.objectWithDictionary(dict as! [String : AnyObject])
            self.provinceCitiesArr.addObject(group)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let group = self.provinceCitiesArr[pickerView.selectedRowInComponent(0)] as! ProvinceCities
        if component == 0 {
            return self.provinceCitiesArr.count
        }
        return group.cities.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let group = self.provinceCitiesArr[pickerView.selectedRowInComponent(0)] as! ProvinceCities
        if component == 0 {
            let group = self.provinceCitiesArr[row] as! ProvinceCities
            return group.state
        }
        return group.cities[row] as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadAllComponents()
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
