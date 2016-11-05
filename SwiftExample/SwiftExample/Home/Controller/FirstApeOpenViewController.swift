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
        
        let apeLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        apeLabel.text = "Tap"
        apeLabel.textColor = UIColor.white
        apeLabel.textAlignment = NSTextAlignment.center;
        apeLabel.layer.cornerRadius = apeLabel.frame.size.height / 2;
        apeLabel.backgroundColor = UIColor.lightGray;
        apeLabel.clipsToBounds = true;
        let downMenuButton = DWBubbleMenuButton.init(frame: CGRect(x: 100, y: 100, width: apeLabel.frame.size.width, height: apeLabel.frame.size.height), expansionDirection:ExpansionDirection.DirectionDown)
        downMenuButton?.homeButtonView = apeLabel;
        downMenuButton?.addButtons(self.createDemoButtonArray() as [AnyObject])
        self.view.addSubview(downMenuButton!)
    }
    
    func createDemoButtonArray() -> NSArray {
        let buttonsMutable : NSMutableArray = []
        var i = 0
        for title in ["A", "B", "C", "D", "E", "F"] {
            let button = UIButton.init(type: .system)
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.setTitle(title, for: UIControlState())
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.layer.cornerRadius = PART_H(button)/2
            button.backgroundColor = UIColor.lightGray
            button.clipsToBounds = true
            i+=1
            button.tag = i
            button.addTarget(self, action: #selector(FirstApeOpenViewController.test(_:)), for: UIControlEvents.touchUpInside)
            buttonsMutable.add(button)
        }
        return buttonsMutable.copy() as! NSArray
    }
    
    func test(_ button:UIButton) -> Void {
        NSLog("Button tapped, tag: %ld", button.tag)
    }
    
    func createButtonWithName(_ imageName:NSString) -> UIButton {
        let button = UIButton.init(type: UIButtonType.system)
        button.setImage(UIImage.init(named: imageName as String), for: UIControlState())
        button.sizeToFit()
        button.addTarget(self, action: #selector(FirstApeOpenViewController.test(_:)), for: .touchUpInside)
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
