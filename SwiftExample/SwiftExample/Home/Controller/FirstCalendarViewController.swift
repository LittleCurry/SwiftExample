//
//  FirstCalendarViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/17.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstCalendarViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var seletedArr:NSMutableArray = [];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Plain);
    var calendarView:LDCalendarView?
    var showStr = "已选择日期: "

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "日历"
        myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        myTableView.delegate = self;
        myTableView.dataSource = self
        self.view.addSubview(myTableView);
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let str = "adsaeag7wqe58st4w3";
        var cell = tableView.dequeueReusableCellWithIdentifier(str)
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: str)
        }
        
        self.seletedArr.sortUsingComparator { (obj1, obj2) -> NSComparisonResult in
            return NSNumber.init(double: obj1.doubleValue).compare(NSNumber.init(double: obj2.doubleValue))
        }
        
        let textStr = NSMutableAttributedString.init(string: "已选择日期:  ")
        textStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(13), range: NSMakeRange(0, 6))
        for interval in self.seletedArr {
            let subStr = NSMutableAttributedString.init(string: NSDate.stringWithTimestamp(interval.doubleValue, format: "MM.dd")+" ")
            subStr.addAttribute(NSForegroundColorAttributeName, value: RGBA(CGFloat(arc4random()%255), g: CGFloat(arc4random()%255), b: CGFloat(arc4random()%255), a: 1), range: NSMakeRange(0, 5))
            textStr.appendAttributedString(subStr)
        }
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.font = UIFont.systemFontOfSize(20)
        cell?.textLabel?.textColor = UIColor.lightGrayColor()
        cell?.textLabel?.attributedText = textStr
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if (self.calendarView == nil) {
            self.calendarView = LDCalendarView.init(frame: UIScreen.mainScreen().bounds)
            self.view.addSubview(self.calendarView!)
            
            // swift中调用oc的block属性
            self.calendarView?.complete = { (result)  in
                self.seletedArr = NSMutableArray(array: result)
                print(self.seletedArr)
                self.myTableView.reloadData()
            }
//            _calendarView.complete = ^(NSArray *result) {
//                if (result) {
//                    weakSelf.seletedDays = result.mutableCopy;
//                    [weakSelf.tableView reloadData];
//                }
//            };
        }
        self.calendarView!.defaultDays = self.seletedArr as [AnyObject];
        self.calendarView!.show()
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
