//
//  FirstApeOpenViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/27.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstApeOpenViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        self.navigationItem.title = "Ape展开"
        
        let apeLabel = UILabel.init(frame: CGRectMake(0, 0, 40, 40))
        apeLabel.text = "Tap"
        apeLabel.textColor = UIColor.whiteColor()
        apeLabel.textAlignment = NSTextAlignment.Center;
        apeLabel.layer.cornerRadius = apeLabel.frame.size.height / 2;
        apeLabel.backgroundColor = UIColor.lightGrayColor();
        apeLabel.clipsToBounds = true;
        let downMenuButton = DWBubbleMenuButton.init(frame: CGRectMake(100, 100, apeLabel.frame.size.width, apeLabel.frame.size.height), expansionDirection:ExpansionDirection.DirectionDown)
        downMenuButton.homeButtonView = apeLabel;
        downMenuButton.addButtons(self.createDemoButtonArray() as [AnyObject])
        self.view.addSubview(downMenuButton)
    }
    
    func createDemoButtonArray() -> NSArray {
        let buttonsMutable : NSMutableArray = []
        var i = 0
        for title in ["A", "B", "C", "D", "E", "F"] {
            let button = UIButton.init(type: .System)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.setTitle(title, forState: .Normal)
            button.frame = CGRectMake(0, 0, 30, 30)
            button.layer.cornerRadius = PART_H(button)/2
            button.backgroundColor = UIColor.lightGrayColor()
            button.clipsToBounds = true
            button.tag = i++
            button.addTarget(self, action: "test:", forControlEvents: UIControlEvents.TouchUpInside)
            buttonsMutable.addObject(button)
        }
        return buttonsMutable.copy() as! NSArray
    }
    
    func test(button:UIButton) -> Void {
        NSLog("Button tapped, tag: %ld", button.tag)
    }
    
    func createButtonWithName(imageName:NSString) -> UIButton {
        let button = UIButton.init(type: UIButtonType.System)
        button.setImage(UIImage.init(named: imageName as String), forState: UIControlState.Normal)
        button.sizeToFit()
        button.addTarget(self, action: "test:", forControlEvents: .TouchUpInside)
        return button
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
