//
//  StoreHomeTableViewCell2.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/19.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class StoreHomeTableViewCell2: UITableViewCell {
    
    var scrollView : UIScrollView?;
    var label1 : UILabel?
    var label2 : UILabel?
    var label3 : UILabel?
    var label4 : UILabel?
    var label5 : UILabel?
    var label6 : UILabel?
    var label7 : UILabel?
    var label8 : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.label1 = UILabel.init()
        self.label2 = UILabel.init()
        self.label3 = UILabel.init()
        self.label4 = UILabel.init()
        self.label5 = UILabel.init()
        self.label6 = UILabel.init()
        self.label7 = UILabel.init()
        self.label8 = UILabel.init()
        self.scrollView = UIScrollView.init();
        for i in 0...9 {
            let aImage = UIImageView.init(frame: CGRectMake(10+CGFloat(i)*130, 0, 100, 100))
            aImage.image = UIImage.init(named: String.init(format: "goods%ld.jpg", arc4random()%120+1))
            self.scrollView?.addSubview(aImage)
            let aLabel = UILabel.init(frame: CGRectMake(80+CGFloat(i)*130, 90, 40, 20))
            aLabel.clipsToBounds = true
            aLabel.layer.cornerRadius = 10
            aLabel.backgroundColor = DARKRED
            aLabel.textColor = UIColor.whiteColor()
            aLabel.font = UIFont.systemFontOfSize(12)
            aLabel.textAlignment = NSTextAlignment.Center
            aLabel.text = String.init(format: "%.1f折", CGFloat(arc4random()%90+10)/10.0)
            self.scrollView?.addSubview(aLabel)
            let lineView = UIView.init(frame: CGRectMake(130+CGFloat(i)*130, 0, 0.5, 100))
            lineView.backgroundColor = PLACEHOLODERCOLOR
            self.scrollView?.addSubview(lineView)
            let bLabel = UILabel.init(frame: CGRectMake(CGFloat(i)*130, 100, 100, 20))
            bLabel.textColor = UIColor.blackColor()
            bLabel.font = UIFont.systemFontOfSize(14)
            bLabel.textAlignment = NSTextAlignment.Center
            bLabel.text = String.init(format: "¥ %.1f", CGFloat(arc4random()%5000)/10.0)
            self.scrollView?.addSubview(bLabel)
        }
        
        self.label1?.font = UIFont.systemFontOfSize(20)
        self.label1?.textColor = UIColor.redColor()
        self.label1!.text = "秒杀"
        self.label2?.font = UIFont.systemFontOfSize(14)
        self.label2?.textAlignment = NSTextAlignment.Center
        self.label2!.text = "·18点场"
        self.label3?.font = UIFont.systemFontOfSize(14)
        self.label3!.layer.masksToBounds = true;
        self.label3!.layer.borderWidth = 1;
        self.label3!.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.label3?.textAlignment = NSTextAlignment.Center
        self.label3!.text = "02"
        self.label4?.font = UIFont.systemFontOfSize(14)
        self.label4?.textAlignment = NSTextAlignment.Center
        self.label4!.text = ":"
        self.label5?.font = UIFont.systemFontOfSize(14)
        self.label5!.layer.masksToBounds = true;
        self.label5!.layer.borderWidth = 1;
        self.label5!.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.label5?.textAlignment = NSTextAlignment.Center
        self.label5!.text = "30"
        self.label6?.font = UIFont.systemFontOfSize(14)
        self.label6?.textAlignment = NSTextAlignment.Center
        self.label6!.text = ":"
        self.label7?.font = UIFont.systemFontOfSize(14)
        self.label7!.layer.masksToBounds = true;
        self.label7!.layer.borderWidth = 1;
        self.label7!.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.label7?.textAlignment = NSTextAlignment.Center
        self.label7!.text = "29"
        self.label8?.font = UIFont.systemFontOfSize(17)
        self.label8?.textAlignment = NSTextAlignment.Right
        self.label8?.textColor = PLACEHOLODERCOLOR
        self.label8!.text = "全场9.9元起＞"
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.contentSize = CGSizeMake(130*10, 0)
        
        self.contentView.addSubview(self.label1!)
        self.contentView.addSubview(self.label2!)
        self.contentView.addSubview(self.label3!)
        self.contentView.addSubview(self.label4!)
        self.contentView.addSubview(self.label5!)
        self.contentView.addSubview(self.label6!)
        self.contentView.addSubview(self.label7!)
        self.contentView.addSubview(self.label8!)
        self.contentView.addSubview(self.scrollView!)
        self.countdown()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.label1?.frame = CGRectMake(10, 10, 40, 20)
        self.label2?.frame = CGRectMake(50, 10, 55, 20)
        self.label3?.frame = CGRectMake(110, 8.5, 23, 23)
        self.label4?.frame = CGRectMake(133, 10, 10, 20)
        self.label5?.frame = CGRectMake(143, 8.5, 23, 23)
        self.label6?.frame = CGRectMake(166, 10, 10, 20)
        self.label7?.frame = CGRectMake(176, 8.5, 23, 23)
        self.label8?.frame = CGRectMake(WIDTH-120, 10, 110, 20)
        self.scrollView?.frame = CGRectMake(0, 50, WIDTH, PART_H(self.contentView)-50)
    }
    
    func countdown() -> Void {
        var timeout: Int = 60*60*2 + 13*60 + 19
        let queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let timer: dispatch_source_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, dispatch_walltime(nil, 0), 1 * NSEC_PER_SEC, 0)//每秒执行
        dispatch_source_set_event_handler(timer) { () -> Void in
            if(timeout<=0){
                dispatch_source_cancel(timer);
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    // 如需更新UI 代码请写在这里
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    // 如需更新UI 代码请写在这里
                    self.label3?.text = String.init(format: "%.2d", timeout/3600)
                    self.label5?.text = String.init(format: "%.2d", (timeout%3600)/60)
                    self.label7?.text = String.init(format: "%.2d", timeout%60)
                })
                timeout--
            }
        }
        dispatch_resume(timer)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
