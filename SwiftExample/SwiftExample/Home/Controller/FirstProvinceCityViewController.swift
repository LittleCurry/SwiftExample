//
//  FirstProvinceCityViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/10.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

//类似于OC中的typedef
typealias sendValueClosure2=(group:ProvinceCities)->Void

class FirstProvinceCityViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var myCurrentCity = ""
    var provinceCitiesArr:NSMutableArray = [];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Plain);
    //声明一个闭包
    var myClosure:sendValueClosure2?
    //下面这个方法需要传入上个界面的someFunctionThatTakesAClosure函数指针
    func initWithClosure(closure:sendValueClosure2?){
        //将函数指针赋值给myClosure闭包，该闭包中涵盖了someFunctionThatTakesAClosure函数中的局部变量等的引用
        myClosure = closure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView();
    }
    
    func getView() -> Void {
        
        let tempArr:NSMutableArray = []
        let dictArray = NSArray.init(contentsOfFile: NSBundle.mainBundle().pathForResource("city.plist", ofType: nil)!)
        for dict in dictArray! {
            let group = ProvinceCities.objectWithDictionary(dict as! [String : AnyObject])
            tempArr.addObject(group)
        }
        self.provinceCitiesArr = tempArr
        
        self.navigationItem.title = "当前城市-"+self.myCurrentCity
        myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        myTableView.delegate = self;
        myTableView.dataSource = self
        self.view.addSubview(myTableView);
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return provinceCitiesArr.count;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRectMake(0, 0, WIDTH, 30))
        headerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        let label = UILabel.init(frame: CGRectMake(15, 0, WIDTH-15, 30))
        label.textColor = UIColor.lightGrayColor()
        let group = self.provinceCitiesArr[section] as! ProvinceCities
        label.text = group.state
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = self.provinceCitiesArr[section] as! ProvinceCities
        return group.cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellName = "qweqweqwe";
        var cell = tableView.dequeueReusableCellWithIdentifier(cellName);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellName)
        }
        let group = provinceCitiesArr[indexPath.section] as! ProvinceCities
        cell?.textLabel?.text = group.cities[indexPath.row] as? String
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if ((myClosure) != nil){
            //闭包隐式调用someFunctionThatTakesAClosure函数：回调。
            let group = self.provinceCitiesArr[indexPath.section] as! ProvinceCities
            group.city = group.cities[indexPath.row] as! String
            group.province = group.state == "热门城市" ? group.city : group.state
            myClosure!(group: group)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
