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
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.plain);
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let str = "adsaeag7wqe58st4w3";
        var cell = tableView.dequeueReusableCell(withIdentifier: str)
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: str)
        }
        
        self.seletedArr.sort (comparator: { (obj1, obj2) -> ComparisonResult in
            return NSNumber.init(value: (obj1 as AnyObject).doubleValue as Double).compare(NSNumber.init(value: (obj2 as AnyObject).doubleValue as Double))
        })
        
        let textStr = NSMutableAttributedString.init(string: "已选择日期:  ")
        textStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 13), range: NSMakeRange(0, 6))
        for interval in self.seletedArr {
            let subStr = NSMutableAttributedString.init(string: NSDate.string(withTimestamp: (interval as AnyObject).doubleValue, format: "MM.dd")+" ")
            subStr.addAttribute(NSForegroundColorAttributeName, value: RGBA(CGFloat(arc4random()%255), g: CGFloat(arc4random()%255), b: CGFloat(arc4random()%255), a: 1), range: NSMakeRange(0, 5))
            textStr.append(subStr)
        }
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell?.textLabel?.textColor = UIColor.lightGray
        cell?.textLabel?.attributedText = textStr
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (self.calendarView == nil) {
            self.calendarView = LDCalendarView.init(frame: UIScreen.main.bounds)
            self.view.addSubview(self.calendarView!)
            
            // swift中调用oc的block属性, 使用闭包替换
            self.calendarView?.complete = { (result)  in
                self.seletedArr = NSMutableArray(array: result!)
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
