//
//  FouthCircleViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/6.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FouthCircleViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // 这是写属性的地方
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.plain);
    let cellName = "qweqweasdasassasdsassasqwe";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "圆形图"
        self.myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.register(SCCircleCell.self, forCellReuseIdentifier: cellName)
        view.addSubview(self.myTableView);
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:SCCircleCell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! SCCircleCell
        if cell.isEqual(nil) {
            cell = SCCircleCell(style: UITableViewCellStyle.default, reuseIdentifier: cellName)
        }
        cell.configUI(indexPath)
        return cell;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
