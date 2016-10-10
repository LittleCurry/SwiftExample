//
//  FirstPlayerViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/8.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit
import MediaPlayer

class FirstPlayerViewController: BaseViewController {
    
    var mvPlay : MPMoviePlayerController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "视频播放"
        self.mvPlay = MPMoviePlayerController.init()
        self.mvPlay?.contentURL = NSURL.init(string: "http://flv2.bn.netease.com/videolib3/1610/09/PIlhF8201/SD/PIlhF8201-mobile.mp4")
        self.mvPlay?.view.frame = CGRectMake(0, 64, WIDTH, 300)
        self.view.addSubview((self.mvPlay?.view)!)
        self.mvPlay?.play()
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
