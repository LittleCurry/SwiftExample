//
//  FirstBankCardViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/11.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstBankCardViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // 这是写属性的地方
    var cardArr:NSMutableArray = [];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Plain);
    let cellName = "qweqws0s0asad123ssasdsassasqwe";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView();
        self.getData();
    }
    
    func getView() -> Void {
        self.navigationItem.title = "我的银行卡"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addCard")
        self.myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.registerClass(BankCardTableViewCell.self, forCellReuseIdentifier: self.cellName)
        self.view.addSubview(self.myTableView);
    }
    
    func addCard() -> Void {
        //
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:BankCardTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellName, forIndexPath: indexPath) as! BankCardTableViewCell
        if (cell.isEqual(nil)) {
            cell = BankCardTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellName)
        }
        cell.bankCard = self.cardArr[indexPath.item] as?BankCard;
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func getData() -> Void {
        
        let dict0 = ["type":"Bank", "org":"CMB", "number":"622700064003097550", "name":"liyunpeng"] as [String : AnyObject]
        let dict1 = ["type":"Bank", "org":"CEB", "number":"622700064003094389", "name":"liyunpeng"] as [String : AnyObject]
        let dict2 = ["type":"Bank", "org":"ABC", "number":"622700064003091826", "name":"liyunpeng"] as [String : AnyObject]
        let dict3 = ["type":"Bank", "org":"CCB", "number":"622700064003092658", "name":"liyunpeng"] as [String : AnyObject]
        
        let card0 = BankCard.objectWithDictionary(dict0)
        let card1 = BankCard.objectWithDictionary(dict1)
        let card2 = BankCard.objectWithDictionary(dict2)
        let card3 = BankCard.objectWithDictionary(dict3)
        self.cardArr.addObject(card0)
        self.cardArr.addObject(card1)
        self.cardArr.addObject(card2)
        self.cardArr.addObject(card3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
