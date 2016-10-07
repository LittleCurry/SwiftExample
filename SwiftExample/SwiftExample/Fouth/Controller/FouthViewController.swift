//
//  FouthViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/5.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FouthViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // 这是写属性的地方
    var nameArr = ["📈折线图", "📊柱状图", "○圆形图", "⭕️圆饼图"];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Plain);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "图表"
        myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        myTableView.delegate = self;
        myTableView.dataSource = self
        view.addSubview(myTableView);
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellName = "qweqweqwe";
        var cell = tableView.dequeueReusableCellWithIdentifier(cellName);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellName)
        }
        cell?.textLabel?.text = nameArr[indexPath.row];
        return cell!;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let fouthLineVC = FouthLineViewController.init();
            fouthLineVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(fouthLineVC, animated: true);
            break;
        case 1:
            let fouthColumnVC = FouthColumnViewController.init();
            fouthColumnVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(fouthColumnVC, animated: true);
            break;
        case 2:
            let fouthCircleVC = FouthCircleViewController.init();
            fouthCircleVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(fouthCircleVC, animated: true);
            break;
        case 3:
            let fouthPieVC = FouthPieViewController.init();
            fouthPieVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(fouthPieVC, animated: true);
            break;
        default:
            break;
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
