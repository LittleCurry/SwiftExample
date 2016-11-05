//
//  FirstCycleScrollViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/11.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstCycleScrollViewController: BaseViewController, SDCycleScrollViewDelegate {
    
    var adUrlArr:NSMutableArray = []
    var wordArr:NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        
        self.navigationItem.title = "CycleScroll"
        self.adUrlArr.add(URL.init(string: "http://imgstore.cdn.sogou.com/app/a/11220002/21215_pc.jpg")!)
        self.adUrlArr.add(URL.init(string: "http://pic28.nipic.com/20130423/2786001_225855729000_2.jpg")!)
        self.adUrlArr.add(URL.init(string: "http://www.xiaoxiongbizhi.com/wallpapers/1152_864_85/4/f/4fm0jn1cf.jpg")!)
        self.adUrlArr.add(URL.init(string: "http://img.yangsheng.com/upload/picture/2014/07-02/TYCoJq.jpg")!)
        self.adUrlArr.add(URL.init(string: "http://wwwbig5.hinews.cn/pic/0/16/73/77/16737795_372261.jpg")!)
        self.wordArr.add("Iverson主题高清桌面 壁纸 - 壁纸")
        self.wordArr.add("夕阳大海 沙滩 摄影图__自然风景")
        self.wordArr.add("麦迪 麦蒂 劲爆体育")
        self.wordArr.add("叉烧的营养价值及食疗作用")
        self.wordArr.add("有著半人半神之称的卡特")
        
        let cycleScrollView = SDCycleScrollView.init(frame: CGRect(x: 0, y: 64, width: WIDTH, height: 200), imageURLsGroup: self.adUrlArr as [AnyObject])
        cycleScrollView?.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView?.delegate = self;
        cycleScrollView?.titlesGroup = self.wordArr as [AnyObject];
        cycleScrollView?.autoScrollTimeInterval = 3.5;
        cycleScrollView?.dotColor = UIColor.white; // 自定义分页控件小圆标颜色
        cycleScrollView?.pageControlDotSize = CGSize(width: 4, height: 4);// 分页控件小圆大小
        cycleScrollView?.titleLabelBackgroundColor = RGBA(121, g: 121, b: 121, a: 0.2); // 标题栏颜色
        cycleScrollView?.titleLabelTextColor = UIColor.yellow; // 标题栏字体颜色
        self.view.addSubview(cycleScrollView!)
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        NSLog("---点击了第%ld张图片", index);
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
