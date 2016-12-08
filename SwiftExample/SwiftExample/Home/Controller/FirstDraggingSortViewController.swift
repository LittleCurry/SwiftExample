//
//  FirstDraggingSortViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/12/6.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstDraggingSortViewController: BaseViewController, UICollectionViewDataSource,UIGestureRecognizerDelegate,UICollectionViewDelegate,MovingDelegate {
    
    var layout:UICollectionViewFlowLayout?
    var heightArr : NSMutableArray = [];
    var indexPath : IndexPath!
    var nextIndexPath : IndexPath!
    var originalCell : MovingCell!
    var snapshotView : UIView!
    var myCollectionView : UICollectionView!
    var dragReuseIdentifier = "MovingCell";
    var dragArr : NSMutableArray = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 0...29 {
            let movingItem = MovingItem.init()
            movingItem.title = String.init(format: "第%ld个", i)
            movingItem.itemWidth = CGFloat(arc4random()%50)+60.0;
            movingItem.backGroundColor = RGBA(CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), a: 1);
            self.dragArr.add(movingItem)
        }
        self.getView();
    }
    func getView() -> Void {
        
        self.navigationItem.title = "切换"
        self.layout = DraggingCollectionViewLayout.init(itemsWidthBlock: { (indexPath) -> CGFloat in
            let myitem = self.dragArr[(indexPath?.item)!] as! MovingItem
            return myitem.itemWidth
        })
        self.layout?.sectionInset = UIEdgeInsetsMake(100, 0, 10, 0);
        
        self.myCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: self.layout!);
        self.myCollectionView.backgroundColor = RGBA(239, g: 239, b: 244, a: 1);
        self.myCollectionView.dataSource = self;
        self.myCollectionView.delegate = self;
        self.myCollectionView.contentInset = UIEdgeInsetsMake(navigationBar_H(self.navigationController!)+20, 0, tabBar_H(self.tabBarController!), 0);
        self.myCollectionView.register(MovingCell.self, forCellWithReuseIdentifier: dragReuseIdentifier);
        self.view.addSubview(self.myCollectionView);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dragArr.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dragReuseIdentifier, for: indexPath) as! MovingCell
//        cell.delegate = self;
        let longPressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(longPress))
        longPressGesture.delegate = self;
        cell.addGestureRecognizer(longPressGesture)
        cell.movingItem = self.dragArr[indexPath.item] as? MovingItem;
        return cell
    }
    
//    #pragma mark - MovingDelegate
    func longPress(longPress:UILongPressGestureRecognizer) {
        
        //记录上一次手势的位置
        var startPoint = CGPoint(x:0, y:0)
        //触发长按手势的cell
        let cell = longPress.view as! MovingCell
        //开始长按
        if (longPress.state == UIGestureRecognizerState.began) {
            self.shakeAllCell()
            //获取cell的截图
            self.snapshotView  = cell.snapshotView(afterScreenUpdates: true)
            self.snapshotView.center = cell.center;
            self.myCollectionView.addSubview(self.snapshotView)
            self.indexPath = self.myCollectionView.indexPath(for: cell)
            self.originalCell = cell
            self.originalCell.isHidden = true
            startPoint = longPress.location(in: self.myCollectionView)
            //移动
        }else if (longPress.state == UIGestureRecognizerState.changed){
            
            let tranX = longPress.location(ofTouch: 0, in: self.myCollectionView).x - startPoint.x
            let tranY = longPress.location(ofTouch: 0, in: self.myCollectionView).y - startPoint.y
            //设置截图视图位置
            self.snapshotView.center = __CGPointApplyAffineTransform(self.snapshotView.center, CGAffineTransform(translationX: tranX, y: tranY))
            
            startPoint = longPress.location(ofTouch: 0, in: self.myCollectionView)
            //计算截图视图和哪个cell相交
            for cell:UICollectionViewCell in self.myCollectionView.visibleCells {
                if self.myCollectionView.indexPath(for: cell) == self.indexPath {
                    continue
                }
                let space = CGFloat(sqrtf(Float(pow(Double(self.snapshotView.center.x - cell.center.x), 2)) + powf(Float(self.snapshotView.center.y - cell.center.y), 2)))
                //如果相交一半且两个视图Y的绝对值小于高度的一半就移动
                if (space <= self.snapshotView.bounds.size.width * 0.5 && (fabs(self.snapshotView.center.y - cell.center.y) <= self.snapshotView.bounds.size.height * 0.5)) {
                    self.nextIndexPath = self.myCollectionView.indexPath(for: cell)
                        
                    if (self.nextIndexPath.item > self.indexPath.item) {
                        for i in self.indexPath.item...self.nextIndexPath.item-1 {
                            self.dragArr.exchangeObject(at: i, withObjectAt: i+1)
                        }
                    }else{
                        for i in self.indexPath.item...self.nextIndexPath.item+1 {
                            self.dragArr.exchangeObject(at: i, withObjectAt: i-1)
                        }
                    }
                    //移动
                    self.myCollectionView.moveItem(at: self.indexPath, to: self.nextIndexPath)
                    //设置移动后的起始indexPath
                    self.indexPath = self.nextIndexPath;
                    break;
                }
            }
            //停止
        }else if(longPress.state == UIGestureRecognizerState.ended){
            self.stopShake()
            self.snapshotView.removeFromSuperview()
            self.originalCell.isHidden = false
        }
    }
            
    
    
    // 开始/停止 抖动动画
    func shakeAllCell() {
        let anim = CAKeyframeAnimation.init()
        anim.keyPath = "transform.rotation";
        anim.values = [-2/180.0*M_PI,2/180.0*M_PI,-2/180.0*M_PI];
        anim.repeatCount = MAXFLOAT;
        anim.duration = 0.25;
        
        let cells = self.myCollectionView.visibleCells
        for cell:UICollectionViewCell in cells {
            /**如果加了shake动画就不用再加了*/
            if (cell.layer.animation(forKey: "shake")==nil) {
                cell.layer.add(anim, forKey: "shake")
            }
        }
    }
    
    func stopShake() {
        let cells = self.myCollectionView.visibleCells
        for cell:UICollectionViewCell in cells {
            cell.layer.removeAllAnimations()
        }
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
