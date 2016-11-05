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
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.plain);
    let cellName = "qweqws0s0asad123ssasdsassasqwe";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView();
        self.getData();
    }
    
    func getView() -> Void {
        self.navigationItem.title = "我的银行卡"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(FirstBankCardViewController.addCard))
        self.myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self
        self.myTableView.register(BankCardTableViewCell.self, forCellReuseIdentifier: self.cellName)
        self.view.addSubview(self.myTableView);
    }
    
    func addCard() -> Void {
        //
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:BankCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellName, for: indexPath) as! BankCardTableViewCell
        if (cell.isEqual(nil)) {
            cell = BankCardTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: self.cellName)
        }
        cell.bankCard = self.cardArr[indexPath.item] as?BankCard;
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func getData() -> Void {
        
        let dict0 = ["type":"Bank" as AnyObject, "org":"CMB" as AnyObject, "number":"622700064003097550" as AnyObject, "name":"liyunpeng" as AnyObject] as [String : AnyObject]
        let dict1 = ["type":"Bank" as AnyObject, "org":"CEB" as AnyObject, "number":"622700064003094389" as AnyObject, "name":"liyunpeng" as AnyObject] as [String : AnyObject]
        let dict2 = ["type":"Bank" as AnyObject, "org":"ABC" as AnyObject, "number":"622700064003091826" as AnyObject, "name":"liyunpeng" as AnyObject] as [String : AnyObject]
        let dict3 = ["type":"Bank" as AnyObject, "org":"CCB" as AnyObject, "number":"622700064003092658" as AnyObject, "name":"liyunpeng" as AnyObject] as [String : AnyObject]
        
        let card0 = BankCard.objectWithDictionary(dict0)
        let card1 = BankCard.objectWithDictionary(dict1)
        let card2 = BankCard.objectWithDictionary(dict2)
        let card3 = BankCard.objectWithDictionary(dict3)
        self.cardArr.add(card0)
        self.cardArr.add(card1)
        self.cardArr.add(card2)
        self.cardArr.add(card3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
