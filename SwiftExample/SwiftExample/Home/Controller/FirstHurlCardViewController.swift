//
//  FirstHurlCardViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/24.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstHurlCardViewController: BaseViewController, SSStackedViewDelegate {
    
    var stackView = SSStackedPageView.init(frame: CGRectMake(20, 100, WIDTH-40, HEIGHT-100))
    var views:NSMutableArray = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "抽卡效果"
        self.stackView.delegate = self;
        self.stackView.pagesHaveShadows = true;
        self.view.addSubview(self.stackView)
        for i in 0...4 {
            let thisView = UIImageView.init(frame: CGRectMake(0, 0, 200, 100))
            thisView.userInteractionEnabled = true
            thisView.image = UIImage.init(named: String.init(format: "bankcard%ld.jpg", i+1))
            self.views.addObject(thisView)
        }
    }
    
    // SSStackedViewDelegate
    // 设置当前页的序号
    func stackView(stackView: SSStackedPageView!, pageForIndex index: Int) -> UIView! {
        var thisView = stackView.dequeueReusablePage()
        if (thisView == nil) {
            thisView = self.views.objectAtIndex(index) as! UIView
            thisView.backgroundColor = UIColor.getRandomColor()
            thisView.layer.cornerRadius = 5;
            thisView.layer.masksToBounds = true
        }
        return thisView
    }
    
    // 总页数
    func numberOfPagesForStackView(stackView: SSStackedPageView!) -> Int {
        return self.views.count
    }
    
    // 点击页面
    func stackView(stackView: SSStackedPageView!, selectedPageAtIndex index: Int) {
        NSLog("selected page: %i",Int(index))
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
