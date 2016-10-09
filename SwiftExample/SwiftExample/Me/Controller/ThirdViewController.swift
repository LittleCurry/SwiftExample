//
//  ThirdViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/8.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class ThirdViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // 这是写属性的地方
    var nameArr = [];
    var myTableView = UITableView.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Grouped);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "视频"
        myTableView.contentInset = UIEdgeInsetsMake(64-35, 0, 49-20-20, 0);
        self.myTableView.tableFooterView = UIView.init();
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        myTableView.delegate = self;
        myTableView.dataSource = self
        view.addSubview(myTableView);
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count+10;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRectMake(0, 0, WIDTH
            , WIDTH/4))
        var imageTypeArr = ["design.png", "pet.png", "circleGirl.png", "furniture.png"]
        var textTypeArr = ["奇葩", "萌宠", "美女", "精品"]
        
        for i in 0...3 {
            let aView = UIView.init(frame: CGRectMake(CGFloat(i)*WIDTH/4.0, 0, (WIDTH-3)/4, WIDTH/4))
            aView.backgroundColor = UIColor.whiteColor()
            headerView.addSubview(aView)
            let aImageView = UIImageView.init(frame: CGRectMake(WIDTH/16, 10, WIDTH/8, WIDTH/8))
            aImageView.image = UIImage.init(named: imageTypeArr[i])
            aView.addSubview(aImageView)
            let aLabel = UILabel.init(frame: CGRectMake(0, WIDTH/4-25, WIDTH/4, 20))
            aLabel.textAlignment = NSTextAlignment.Center
            aLabel.text = textTypeArr[i]
            aView.addSubview(aLabel)
        }
        return headerView;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return WIDTH/4+10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellName = "qweqwsaeqwe";
        var cell = tableView.dequeueReusableCellWithIdentifier(cellName);
        if cell == nil {
            cell = MovieTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellName)
        }
        cell?.separatorInset
//        cell?.textLabel?.text = nameArr[indexPath.row];
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let firstInfoVC = FirstInfoViewController.init();
            firstInfoVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(firstInfoVC, animated: true);
            break;
        case 1:
            let keyboardVC = FirstKeyboardViewController.init();
            keyboardVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(keyboardVC, animated: true);
            break;
        case 2:
            let gaussVC = FirstGaussViewController.init();
            gaussVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(gaussVC, animated: true);
            break;
        case 3:
            let shareVC = FirstShareViewController.init();
            shareVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(shareVC, animated: true);
            break;
        case 4:
            let mapVC = FirstMapViewController.init();
            mapVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(mapVC, animated: true);
            break;
        case 5:
            break;
        case 6:
            let playerVC = FirstPlayerViewController.init();
            playerVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(playerVC, animated: true);
            break;
        case 6:
            let testBlockVC = FirstOriginBlockViewcontroller.init();
            testBlockVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(testBlockVC, animated: true);
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
