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
        
        self.navigationItem.title = "拼图"
        let originView = UIImageView.init(frame: CGRectMake(WIDTH/2-160, 74, 100, 100))
        originView.image = UIImage.init(named: "jigsaw.jpg")
        self.view.addSubview(originView)
        let boardView = YFChessBoardView.init(frame: CGRectMake(WIDTH/2-160, 184, 320, 320))
        boardView.backgroundImage = UIImage.init(named: "jigsaw.jpg")?.scaleToSize(CGSizeMake(PART_W(boardView), PART_H(boardView)));
        self.view.addSubview(boardView)
        self.boardView = boardView;
        
        let breakBtn = UIButton.init(type: UIButtonType.Custom)
        breakBtn.frame = CGRectMake(WIDTH/2-160, Y(boardView)+PART_H(boardView)+10, 100, 44);
        breakBtn.backgroundColor = DARKRED
        breakBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        breakBtn.setTitle("打 乱", forState: UIControlState.Normal)
        breakBtn.addTarget(self, action: "breakBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(breakBtn)
        self.breakBtnClick()
    }
    
    func breakBtnClick() -> Void {
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
