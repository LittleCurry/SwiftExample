//
//  FirstBarrageViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/13.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit
import MediaPlayer

class FirstBarrageViewController: BaseViewController {
    
    var mvPlay : MPMoviePlayerController?
    var renderer = BarrageRenderer.init()
    var timer = Timer.init()
    var infoLabel = UILabel.init(frame: CGRect(x:0, y:HEIGHT-30, width:200, height: 30))
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "弹幕"
        
        self.mvPlay = MPMoviePlayerController.init()
        self.mvPlay?.contentURL = URL.init(string: "http://flv2.bn.netease.com/tvmrepo/2016/11/5/H/EC4TDFU5H/SD/EC4TDFU5H-mobile.mp4")
        self.mvPlay?.view.frame = UIScreen.main.bounds
        self.mvPlay?.scalingMode = .aspectFill
        //        self.mvPlay?.view.contentMode = .topLeft
                self.mvPlay?.isFullscreen = true
        //        self.mvPlay?.shouldAutoplay = true
        self.view.addSubview((self.mvPlay?.view)!)
        self.mvPlay?.play()
        
        
        
        self.view.addSubview(renderer.view)
        //        self.renderer.canvasMargin = UIEdgeInsetsMake(10, 10, 10, 10);
        // 若想为弹幕增加点击功能, 请添加此句话, 并在Descriptor中注入行为
        self.renderer.view.isUserInteractionEnabled = false
        //        self.view.sendSubview(toBack: self.renderer.view)
        self.infoLabel.textColor = PLACEHOLODERCOLOR
        self.infoLabel.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(self.infoLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let safeObj = NSSafeObject.init(object: self, with: #selector(autoSendBarrage))
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: safeObj, selector: #selector(NSSafeObject.excute), userInfo: nil, repeats: true)
        self.renderer.start()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.mvPlay?.pause()
    }
    
    func autoSendBarrage() {
        
        let spriteNumber = self.renderer.spritesNumber(withName: nil)
        self.infoLabel.text = String.init(format: "当前屏幕弹幕数量: %ld", spriteNumber)
        
        if spriteNumber <= 500 {
            
            
            // BarrageWalkDirectionR2L                   BarrageWalkSideLeft
            self.renderer.receive(self.walkTextSpriteDescriptorWithDirection(direction: 1, side: 2))
            self.renderer.receive(self.walkTextSpriteDescriptorWithDirection(direction: 2, side: 0))
            self.renderer.receive(self.walkTextSpriteDescriptorWithDirection(direction: 2, side: 2))
            self.renderer.receive(self.walkTextSpriteDescriptorWithDirection(direction: 4, side: 1))
            
            
            // BarrageFloatDirectionB2T                  BarrageFloatSideCenter
            self.renderer.receive(self.floatTextSpriteDescriptorWithDirection(direction: 2, side:0))
            self.renderer.receive(self.floatTextSpriteDescriptorWithDirection(direction: 1, side:2))
            self.renderer.receive(self.floatTextSpriteDescriptorWithDirection(direction: 1, side:1))
            
            
            // BarrageWalkDirectionL2R
            self.renderer.receive(self.walkImageSpriteDescriptorWithDirection(direction: 1))
            self.renderer.receive(self.walkImageSpriteDescriptorWithDirection(direction: 2))
            // BarrageFloatDirectionT2B
            self.renderer.receive(self.floatImageSpriteDescriptorWithDirection(direction: 1))
        }
        
    }
    
    /// 过场文字弹幕
    func walkTextSpriteDescriptorWithDirection(direction:NSInteger, side:NSInteger) -> BarrageDescriptor {
        
        let descriptor = BarrageDescriptor.init()
        descriptor.spriteName = NSStringFromClass(BarrageWalkTextSprite.self);
        self.index += 1
        descriptor.params["text"] = String.init(format: "过场文字弹幕:%ld", self.index)
        descriptor.params["textColor"] = UIColor.white
        descriptor.params["speed"] = 100*(CGFloat(arc4random())/CGFloat(RAND_MAX))+50
        descriptor.params["direction"] = direction
        descriptor.params["side"] = side
        
        descriptor.params["clickAction"] = { () in
            print("弹幕被点击")
            } as Any?
        //        void(^BarrageClickAction)(void);
        return descriptor
    }
    
    /// 浮动文字弹幕
    func floatTextSpriteDescriptorWithDirection(direction:NSInteger, side:NSInteger) -> BarrageDescriptor {
        let descriptor = BarrageDescriptor.init()
        descriptor.spriteName = NSStringFromClass(BarrageFloatTextSprite.self);
        self.index += 1
        descriptor.params["text"] = String.init(format: "悬浮文字弹幕:%ld", self.index)
        descriptor.params["textColor"] = UIColor.red
        descriptor.params["duration"] = 3
        descriptor.params["fadeInTime"] = 1
        descriptor.params["fadeOutTime"] = 1
        descriptor.params["direction"] = direction
        descriptor.params["side"] = side
        return descriptor
    }
    
    /// 过场图片弹幕
    func walkImageSpriteDescriptorWithDirection(direction:NSInteger) -> BarrageDescriptor {
        let descriptor = BarrageDescriptor.init()
        descriptor.spriteName = NSStringFromClass(BarrageWalkImageSprite.self);
        descriptor.params["image"] = UIImage.init(named: "car.png")?.scale(to: CGSize(width:20, height:20))
        descriptor.params["speed"] = 100*(CGFloat(arc4random())/CGFloat(RAND_MAX))+50
        descriptor.params["direction"] = direction
        descriptor.params["trackNumber"] = 5; // 轨道数量
        return descriptor
    }
    
    /// 浮动图片弹幕
    func floatImageSpriteDescriptorWithDirection(direction:NSInteger) -> BarrageDescriptor {
        let descriptor = BarrageDescriptor.init()
        descriptor.spriteName = NSStringFromClass(BarrageFloatImageSprite.self);
        descriptor.params["image"] = UIImage.init(named: "car.png")?.scale(to: CGSize(width:40, height:15))
        descriptor.params["duration"] = 3
        descriptor.params["direction"] = direction
        return descriptor
    }
    
    deinit {
        self.renderer.stop()
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
