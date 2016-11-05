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
            let aImage = UIImageView.init(frame: CGRect(x: 10+CGFloat(i)*130, y: 0, width: 100, height: 100))
            aImage.image = UIImage.init(named: String.init(format: "goods%ld.jpg", arc4random()%120+1))
            self.scrollView?.addSubview(aImage)
            let aLabel = UILabel.init(frame: CGRect(x: 80+CGFloat(i)*130, y: 90, width: 40, height: 20))
            aLabel.clipsToBounds = true
            aLabel.layer.cornerRadius = 10
            aLabel.backgroundColor = DARKRED
            aLabel.textColor = UIColor.white
            aLabel.font = UIFont.systemFont(ofSize: 12)
            aLabel.textAlignment = NSTextAlignment.center
            aLabel.text = String.init(format: "%.1f折", CGFloat(arc4random()%90+10)/10.0)
            self.scrollView?.addSubview(aLabel)
            let lineView = UIView.init(frame: CGRect(x: 130+CGFloat(i)*130, y: 0, width: 0.5, height: 100))
            lineView.backgroundColor = PLACEHOLODERCOLOR
            self.scrollView?.addSubview(lineView)
            let bLabel = UILabel.init(frame: CGRect(x: CGFloat(i)*130, y: 100, width: 100, height: 20))
            bLabel.textColor = UIColor.black
            bLabel.font = UIFont.systemFont(ofSize: 14)
            bLabel.textAlignment = NSTextAlignment.center
            bLabel.text = String.init(format: "¥ %.1f", CGFloat(arc4random()%5000)/10.0)
            self.scrollView?.addSubview(bLabel)
        }
        
        self.label1?.font = UIFont.systemFont(ofSize: 20)
        self.label1?.textColor = UIColor.red
        self.label1!.text = "秒杀"
        self.label2?.font = UIFont.systemFont(ofSize: 14)
        self.label2?.textAlignment = NSTextAlignment.center
        self.label2!.text = "·18点场"
        self.label3?.font = UIFont.systemFont(ofSize: 14)
        self.label3!.layer.masksToBounds = true;
        self.label3!.layer.borderWidth = 1;
        self.label3!.layer.borderColor = UIColor.lightGray.cgColor;
        self.label3?.textAlignment = NSTextAlignment.center
        self.label3!.text = "02"
        self.label4?.font = UIFont.systemFont(ofSize: 14)
        self.label4?.textAlignment = NSTextAlignment.center
        self.label4!.text = ":"
        self.label5?.font = UIFont.systemFont(ofSize: 14)
        self.label5!.layer.masksToBounds = true;
        self.label5!.layer.borderWidth = 1;
        self.label5!.layer.borderColor = UIColor.lightGray.cgColor;
        self.label5?.textAlignment = NSTextAlignment.center
        self.label5!.text = "30"
        self.label6?.font = UIFont.systemFont(ofSize: 14)
        self.label6?.textAlignment = NSTextAlignment.center
        self.label6!.text = ":"
        self.label7?.font = UIFont.systemFont(ofSize: 14)
        self.label7!.layer.masksToBounds = true;
        self.label7!.layer.borderWidth = 1;
        self.label7!.layer.borderColor = UIColor.lightGray.cgColor;
        self.label7?.textAlignment = NSTextAlignment.center
        self.label7!.text = "29"
        self.label8?.font = UIFont.systemFont(ofSize: 17)
        self.label8?.textAlignment = NSTextAlignment.right
        self.label8?.textColor = PLACEHOLODERCOLOR
        self.label8!.text = "全场9.9元起＞"
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.contentSize = CGSize(width: 130*10, height: 0)
        
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
        self.label1?.frame = CGRect(x: 10, y: 10, width: 40, height: 20)
        self.label2?.frame = CGRect(x: 50, y: 10, width: 55, height: 20)
        self.label3?.frame = CGRect(x: 110, y: 8.5, width: 23, height: 23)
        self.label4?.frame = CGRect(x: 133, y: 10, width: 10, height: 20)
        self.label5?.frame = CGRect(x: 143, y: 8.5, width: 23, height: 23)
        self.label6?.frame = CGRect(x: 166, y: 10, width: 10, height: 20)
        self.label7?.frame = CGRect(x: 176, y: 8.5, width: 23, height: 23)
        self.label8?.frame = CGRect(x: WIDTH-120, y: 10, width: 110, height: 20)
        self.scrollView?.frame = CGRect(x: 0, y: 50, width: WIDTH, height: PART_H(self.contentView)-50)
    }
    
    func countdown() -> Void {
        var timeout: Int = 60*60*2 + 13*60 + 19
        let queue: DispatchQueue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
        let timer: DispatchSource = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0), queue: queue) as! DispatchSource
        timer.scheduleRepeating(deadline: DispatchTime.init(uptimeNanoseconds: UInt64(100000)), interval: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.seconds(0))//每秒执行
//        timer.setTimer(start: DispatchWallTime(time: nil), interval: 1 * NSEC_PER_SEC, leeway: 0)//每秒执行
        timer.setEventHandler { () -> Void in
            if(timeout<=0){
                timer.cancel();
                DispatchQueue.main.async(execute: { () -> Void in
                    // 如需更新UI 代码请写在这里
                })
            }else{
                DispatchQueue.main.async(execute: { () -> Void in
                    // 如需更新UI 代码请写在这里
                    self.label3?.text = String.init(format: "%.2d", timeout/3600)
                    self.label5?.text = String.init(format: "%.2d", (timeout%3600)/60)
                    self.label7?.text = String.init(format: "%.2d", timeout%60)
                })
                timeout -= 1
            }
        }
        timer.resume()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
