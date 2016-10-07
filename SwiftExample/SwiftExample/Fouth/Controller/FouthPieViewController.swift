//
//  FouthPieViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/6.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FouthPieViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // 这是写属性的地方
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Plain);
    let cellName = "qweqweasdasasdsaddsasdassasqwe";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "圆饼图"
        myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        myTableView.delegate = self;
        myTableView.dataSource = self
        myTableView.registerClass(SCPieCell.self, forCellReuseIdentifier: cellName)
        view.addSubview(myTableView);
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:SCPieCell = tableView.dequeueReusableCellWithIdentifier(cellName, forIndexPath: indexPath) as! SCPieCell
        if cell.isEqual(nil) {
            cell = SCPieCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellName)
        }
        cell.configUI(indexPath)
        return cell;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
