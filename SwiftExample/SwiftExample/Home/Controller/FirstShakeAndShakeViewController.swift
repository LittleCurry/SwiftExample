//
//  FirstShakeAndShakeViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/27.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstShakeAndShakeViewController: BaseViewController {
    
    var bg = UIImageView.init(frame: UIScreen.main.bounds)
    var up = UIImageView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT/2))
    var down = UIImageView.init(frame: CGRect(x: 0, y: HEIGHT/2, width: WIDTH, height: HEIGHT/2))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() {
        self.navigationItem.title = "摇一摇"
        self.bg.image = UIImage.init(named: "bg_shaking")
        self.view.addSubview(self.bg)
        self.up.image = UIImage.init(named: "bg_yaoyao_above")
        self.bg.addSubview(self.up)
        self.down.image = UIImage.init(named: "bg_yaoyao_under")
        self.bg.addSubview(self.down)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.resignFirstResponder()
        super.viewWillDisappear(animated)
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    /** 开始摇一摇 */
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        NSLog("motionBegan");
        UIView.animate(withDuration: 0.4, animations: {
            self.up.frame.origin.y -= HEIGHT/2
            self.down.frame.origin.y += HEIGHT/2
        }) 
        LZAudioTool.playMusic("dance.mp3")
    }
    
    /** 摇一摇结束 */
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (motion != UIEventSubtype.motionShake){
            return;
        }
        NSLog("motionEnded");
        UIView.animate(withDuration: 0.4, animations: {
            self.up.frame.origin.y += HEIGHT/2
            self.down.frame.origin.y -= HEIGHT/2
        }) 
    }
    /** 摇一摇取消 */
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        NSLog("motionCancelled");
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
