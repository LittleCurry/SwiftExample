//
//  FirstBarrageViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/13.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstBarrageViewController: BaseViewController {
    
    var renderer = BarrageRenderer.init()
    var timer = Timer.init()
    var infoLabel = UILabel.init(frame: CGRect(x:0, y:HEIGHT-30, width:150, height: 30))
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "弹幕"
        self.view.addSubview(renderer.view)
        self.renderer.canvasMargin = UIEdgeInsetsMake(10, 10, 10, 10);
        // 若想为弹幕增加点击功能, 请添加此句话, 并在Descriptor中注入行为
        self.renderer.view.isUserInteractionEnabled = true
        self.view.sendSubview(toBack: self.renderer.view)
        self.view.addSubview(self.infoLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let safeObj = NSSafeObject.init(object: self, with: #selector(autoSendBarrage))
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: safeObj, selector: #selector(NSSafeObject.excute), userInfo: nil, repeats: true)
        self.renderer.start()
        
    }
    
    func autoSendBarrage() {
        
        let spriteNumber = self.renderer.spritesNumber(withName: nil)
        self.infoLabel.text = String.init(format: "当前屏幕弹幕数量: %ld", spriteNumber)
        
        if spriteNumber <= 500 {
            self.renderer.receive(self.walkTextSpriteDescriptorWithDirection(direction: BarrageWalkDirection.R2L, side: BarrageWalkSide.left))
        }
        
        
//        if (spriteNumber <= 500) { // 用来演示如何限制屏幕上的弹幕量
//            [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionR2L side:BarrageWalkSideLeft]];
//            [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionR2L side:BarrageWalkSideDefault]];
//            
//            [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideLeft]];
//            [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideRight]];
//            
//            [_renderer receive:[self floatTextSpriteDescriptorWithDirection:BarrageFloatDirectionB2T side:BarrageFloatSideCenter]];
//            [_renderer receive:[self floatTextSpriteDescriptorWithDirection:BarrageFloatDirectionT2B side:BarrageFloatSideLeft]];
//            [_renderer receive:[self floatTextSpriteDescriptorWithDirection:BarrageFloatDirectionT2B side:BarrageFloatSideRight]];
//            
//            [_renderer receive:[self walkImageSpriteDescriptorWithDirection:BarrageWalkDirectionL2R]];
//            [_renderer receive:[self walkImageSpriteDescriptorWithDirection:BarrageWalkDirectionL2R]];
//            [_renderer receive:[self floatImageSpriteDescriptorWithDirection:BarrageFloatDirectionT2B]];
//        }
    }
    
    /// 生成精灵描述 - 过场文字弹幕
    func walkTextSpriteDescriptorWithDirection(direction:BarrageWalkDirection, side:BarrageWalkSide) -> BarrageDescriptor {
        let descriptor = BarrageDescriptor.init()
        var newdirection = BarrageWalkDirection.init(rawValue: 2)
//        newdirection = direction
        var newSide = BarrageWalkSide.init(rawValue: 2)
//        newSide = side
        
        
        
        descriptor.spriteName = NSStringFromClass(BarrageWalkTextSprite.self);
        self.index += 1
        descriptor.params["text"] = String.init(format: "过场文字弹幕:%ld", self.index)
        descriptor.params["textColor"] = UIColor.blue
        descriptor.params["speed"] = 3
        descriptor.params["direction"] = newdirection
        descriptor.params["side"] = newSide
        return descriptor
    }
    
    
//    - (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(BarrageWalkDirection)direction side:(BarrageWalkSide)side
//    {
//    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
//    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
//    descriptor.params[@"text"] = [NSString stringWithFormat:@"过场文字弹幕:%ld",(long)_index++];
//    descriptor.params[@"textColor"] = [UIColor blueColor];
//    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
//    descriptor.params[@"direction"] = @(direction);
//    descriptor.params[@"side"] = @(side);
//    descriptor.params[@"clickAction"] = ^{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"弹幕被点击" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//    [alertView show];
//    };
//    return descriptor;
//    }


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
