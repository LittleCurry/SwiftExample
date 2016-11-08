//
//  FirstStoreCarViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/17.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstStoreCarViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var videoArr : NSMutableArray = [];
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.grouped);
    let cellName = "qwes21d123ssasdsassasqwe";
    var count = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView();
        self.getData();
    }
    
    func getView() -> Void {
        self.navigationItem.title = "购物车"
        
        self.myTableView.contentInset = UIEdgeInsetsMake(64-35+10, 0, 49+3-20-20, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.register(StoreCarTableViewCell.self, forCellReuseIdentifier: self.cellName)
        self.view.addSubview(self.myTableView);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:StoreCarTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellName, for: indexPath) as! StoreCarTableViewCell
        if (cell.isEqual(nil)) {
            cell = StoreCarTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName)
        }
//        cell.video = self.videoArr[indexPath.item] as?Video;
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    
    func getData() -> Void {
        
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
