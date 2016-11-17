//
//  FirstTimeRecordViewController.swift
//  HGCircularSlider
//
//  Created by Hamza Ghazouani on 08/11/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import AVFoundation


/*
 KVO context used to differentiate KVO callbacks for this class versus other
 classes in its class hierarchy.
 */
private var playerViewControllerKVOContext = 0


class FirstTimeRecordViewController: BaseViewController {

    var circularSlider: CircularSlider!
    var timerLabel: UILabel!
    var playerSegmentedControl: UISegmentedControl!
    
    let audioPlayer = AVPlayer()
    
    // date formatter user for timer label
    let dateComponentsFormatter: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
            formatter.zeroFormattingBehavior = .pad
            formatter.allowedUnits = [.minute, .second]
            return formatter
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getView()
    }
    
    func getView() {
        
        self.navigationItem.title = "音乐播放"
        self.view.backgroundColor = RGBA(126, g: 37, b: 164, a: 1)
        
        self.circularSlider = CircularSlider.init(frame: CGRect(x:30, y:120, width:WIDTH-60, height:WIDTH-60))
        // 方形区域bgc
        self.circularSlider.backgroundColor = UIColor.clear
        // 未走线bgc
        self.circularSlider.trackColor = RGBA(255, g: 255, b: 255, a: 0.1)
        // 走过的线bgc
        self.circularSlider.trackFillColor = RGBA(54, g: 214, b: 251, a: 1)
        // 拇指未点击小圆bgc
        self.circularSlider.endThumbStrokeColor = RGBA(54, g: 214, b: 251, a: 1)
        // 拇指小圆高亮bgc
        self.circularSlider.endThumbStrokeHighlightedColor = RGBA(203, g: 148, b: 223, a: 1)
        // 圆盘bgc
        self.circularSlider.diskColor = UIColor.clear
        // 走过的扇形区域bgc
        self.circularSlider.diskFillColor = RGBA(54, g: 214, b: 251, a: 0.1)
        self.circularSlider.lineWidth = 2
        self.circularSlider.thumbRadius = 2
        self.circularSlider.addTarget(self, action: #selector(pause), for: .editingDidBegin)
        self.circularSlider.addTarget(self, action: #selector(play), for: .editingDidEnd)
        self.circularSlider.addTarget(self, action: #selector(updateTimer), for: .valueChanged)
        self.view.addSubview(self.circularSlider)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(_:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: self.audioPlayer.currentItem)
        
        self.timerLabel = UILabel.init(frame: CGRect(x:0, y:PART_H(self.circularSlider)/2-20, width:PART_W(self.circularSlider), height:40))
        self.timerLabel.font = UIFont.systemFont(ofSize: 25)
        self.timerLabel.textColor = UIColor.white
        self.timerLabel.textAlignment = .center
        self.circularSlider.addSubview(self.timerLabel)
        self.playerSegmentedControl = UISegmentedControl.init(items: ["Play", "Pause"])
        self.playerSegmentedControl.frame = CGRect(x:30, y:490, width:WIDTH-60, height:30)
        self.playerSegmentedControl.selectedSegmentIndex = 0
        self.playerSegmentedControl.tintColor = RGBA(54, g: 214, b: 251, a: 1)
        self.playerSegmentedControl.addTarget(self, action: #selector(togglePlayer), for: .valueChanged)
        self.view.addSubview(self.playerSegmentedControl)
        setupAudioPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func togglePlayer(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            let currentTime = Float64(self.circularSlider.endPointValue)
            let newTime = CMTimeMakeWithSeconds(currentTime, 600)
            self.audioPlayer.seek(to: newTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
            self.audioPlayer.play()
        default:
            self.audioPlayer.pause()
        }
    }
    
    func play() {
        self.playerSegmentedControl.selectedSegmentIndex = 0
        togglePlayer(playerSegmentedControl)
    }
    
    func pause() {
        self.playerSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        togglePlayer(playerSegmentedControl)
    }

    
    /**
     setup and play the sound of the local mp3 file
     */
    func setupAudioPlayer() {
        // TODO: load the audio file asynchronously and observe player status
        guard let audioFileURL = Bundle.main.url(forResource: "StrangeZero", withExtension: "mp3") else { return }
        let asset = AVURLAsset(url: audioFileURL, options: nil)
        let playerItem = AVPlayerItem(asset: asset)
        self.audioPlayer.replaceCurrentItem(with: playerItem)
        self.audioPlayer.actionAtItemEnd = .pause
        
        let durationInSeconds = CMTimeGetSeconds(asset.duration)
        self.circularSlider.maximumValue = CGFloat(durationInSeconds)
        let interval = CMTimeMake(1, 4)
        self.audioPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) {
            [weak self] time in
            let seconds = CMTimeGetSeconds(time)
            self?.updatePlayerUI(withCurrentTime: CGFloat(seconds))
        }
        self.audioPlayer.play()
    }
    
    
    // update the slider position and the timer text
    func updatePlayerUI(withCurrentTime currentTime: CGFloat) {
        self.circularSlider.endPointValue = currentTime
        var components = DateComponents()
        components.second = Int(currentTime)
        timerLabel.text = dateComponentsFormatter.string(from: components)
    }
    
    func updateTimer() {
        var components = DateComponents()
        components.second = Int(self.circularSlider.endPointValue)
        timerLabel.text = dateComponentsFormatter.string(from: components)
    }
    
    // MARK: - Notification 
    
    func playerItemDidReachEnd(_ notification: Notification) {
        if let playerItem: AVPlayerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: kCMTimeZero)
            playerSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        }
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
