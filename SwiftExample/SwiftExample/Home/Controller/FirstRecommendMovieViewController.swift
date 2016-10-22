//
//  FirstRecommendMovieViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/21.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstRecommendMovieViewController: BaseViewController {
    
    var labelArr = ["吃惊威龙","摧残人僧","赏金杀手","疯狂原始人","神偷奶爸","致命黑兰","冥界警局","狂鲨之灾","北海巨妖","海扁王2","变形金刚3","史前一亿年","大片","双煞","百万爱情宝贝","金太郎的幸福生活","别跟我谈高富帅","致我们将死得清楚","一路狂奔","甜蜜十八岁","艳遇","后宫:帝王之妾","金钱的味道","痛症","宝贝和我","夺宝联盟","危险关系","甜心巧克力","101次求婚","今天","恐怖故事","富春山居图","嘻哈四重奏之陈可","爱爱囧事","盲探","小时代","嘻哈四重奏至台北","肖申克的救赎","特种部队2:全面反击"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "推荐影片"
        self.view.backgroundColor = UIColor.darkTextColor()
        let cv=CloudView.init(frame: CGRectMake(20, 80, WIDTH-40, WIDTH-40))
        cv.reloadData(self.labelArr)
//        cv.layer.borderColor = UIColor.yellowColor().CGColor;
//        cv.layer.borderWidth = 2;
        self.view.addSubview(cv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
