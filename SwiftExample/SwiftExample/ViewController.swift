//
//  ViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/9/28.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var nameArr = ["zhangsan", "abc", "nihao", "yidadui", "aasd", "qwe", "asd", "eqw", "eeasqad", "zzz", "mdzz"];
    var myTableView = UITableView.init();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

