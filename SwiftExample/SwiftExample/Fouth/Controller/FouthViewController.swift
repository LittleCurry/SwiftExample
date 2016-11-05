//
//  FouthViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/5.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit
import MediaPlayer

class FouthViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // 这是写属性的地方
    var nameArr = ["📈折线图", "📊柱状图", "○圆形图", "⭕️圆饼图"];
    var myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: UITableViewStyle.plain);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "图表"
        myTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.myTableView.tableFooterView = UIView.init();
        myTableView.delegate = self;
        myTableView.dataSource = self
        view.addSubview(myTableView);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = "qweqweqwe";
        var cell = tableView.dequeueReusableCell(withIdentifier: cellName);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellName)
        }
        cell?.textLabel?.text = nameArr[indexPath.row];
        return cell!;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
