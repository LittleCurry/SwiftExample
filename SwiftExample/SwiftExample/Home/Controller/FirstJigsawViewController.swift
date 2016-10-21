//
//  FirstJigsawViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/20.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstJigsawViewController: BaseViewController {
    
    var boardView:YFChessBoardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        let boardView = YFChessBoardView.init(frame: CGRectMake(0, 0, 280, 280))
        boardView.center = self.view.center;
        boardView.backgroundImage = UIImage.init(named: "img1.jpg")
        self.view.addSubview(boardView)
        self.boardView = boardView;
        
        let breakBtn = UIButton.init(type: UIButtonType.System)
        breakBtn.frame = CGRectMake(30, CGRectGetMaxY(boardView.frame) + 20, 100, 44);
        breakBtn.setTitle("打 乱", forState: UIControlState.Normal)
        breakBtn.addTarget(self, action: "breakBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(breakBtn)
        self.breakBtnClick(breakBtn)
    }
    
    func breakBtnClick(button:UIButton) -> Void {
        self.boardView!.randomBreak()
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
