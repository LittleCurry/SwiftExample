//
//  FirstFoldCardViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/26.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstFoldCardViewController: BaseViewController, JCFlipPageViewDataSource {
    
    var flipPage = JCFlipPageView.init(frame: UIScreen.mainScreen().bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        self.navigationItem.title = "折卡效果"
        self.flipPage = JCFlipPageView.init(frame: self.view.bounds)
        self.flipPage.dataSource = self;
        self.view.addSubview(self.flipPage)
        self.flipPage.reloadData()
    }
    
    // JCFlipPageViewDataSource
    func numberOfPagesInFlipPageView(flipPageView: JCFlipPageView!) -> UInt {
        return 20
    }
    
    func flipPageView(flipPageView: JCFlipPageView!, pageAtIndex index: UInt) -> JCFlipPage! {
        let kPageID = "numberPageID"
        var page = flipPageView.dequeueReusablePageWithReuseIdentifier(kPageID)
        
        if ((page == nil)) {
            page = JCFlipPage.init(frame: flipPageView.bounds, reuseIdentifier: kPageID)
        }else{
            
        }
        
        if (index%3 == 0) {
            page.backgroundColor = UIColor.blueColor()
        }
        else if (index%3 == 1) {
            page.backgroundColor = UIColor.greenColor()
        }
        else if (index%3 == 2) {
            page.backgroundColor = UIColor.redColor()
        }else{
        
        }
        page.tempContentLabel.text = String.init(format: "%d", index)
        return page;
    }
    
    func showPage(pageNum:NSNumber) {
        self.flipPage.flipToPageAtIndex(UInt(pageNum), animation: true)
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
