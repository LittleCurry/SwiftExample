//
//  FirstPhotoChoseViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/11.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstPhotoChoseViewController: BaseViewController, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate,  UICollectionViewDelegate,UICollectionViewDataSource {
    
    var MSSReuseIdentifier = "MSSCollectionViewCell";
    var selectedPhotoArr:NSMutableArray = [];
    var pickerController = UIImagePickerController.init();
    var collectionView : UICollectionView!
    var addPictureButton = UIButton.init(type: UIButtonType.System)
    let nowTextField = UITextField.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        
        self.navigationItem.title = "相册选择"
        self.nowTextField.frame = CGRectMake(20, 70, WIDTH-40, 40)
        nowTextField.placeholder = "这一刻的想法..."
        self.view.addSubview(nowTextField)
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        flowLayout.itemSize = CGSizeMake((WIDTH-70)/4, (WIDTH-70)/4);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        self.collectionView = UICollectionView.init(frame: CGRectMake(0, 200, WIDTH, WIDTH), collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.scrollEnabled = false;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.registerClass(MSSCollectionViewCell.self, forCellWithReuseIdentifier: MSSReuseIdentifier)
        self.view.addSubview(self.collectionView)
        
        self.addPictureButton.frame = CGRectMake(20, 200, (WIDTH-70)/4, (WIDTH-70)/4);
        self.addPictureButton.setBackgroundImage(UIImage.init(named: "squareAdd.png"), forState: UIControlState.Normal)
        self.addPictureButton.addTarget(self, action: "addPicture", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.addPictureButton)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedPhotoArr.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MSSReuseIdentifier, forIndexPath: indexPath) as! MSSCollectionViewCell
        
        cell.imageView.image = self.selectedPhotoArr[indexPath.row] as? UIImage;
        cell.imageView.tag = indexPath.row + 1000;
        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFill;
        cell.imageView.clipsToBounds = true;
        cell.imageView.userInteractionEnabled = true;
        let longPress = UILongPressGestureRecognizer.init(target: self, action: "deletePhoto:")
        cell.imageView.addGestureRecognizer(longPress)
        return cell
    }
    
    func deletePhoto(longPress:UILongPressGestureRecognizer) -> Void {
        if longPress.state == UIGestureRecognizerState.Began {
            self.selectedPhotoArr.removeObject(self.selectedPhotoArr[longPress.view!.tag - 1000])
            self.changeCollectionAddButtonAndReloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
        let browser = MJPhotoBrowser.init()
        let photos:NSMutableArray = []
        for i in 0...self.selectedPhotoArr.count-1 {
            let currentPhoto = MJPhoto.init()
            currentPhoto.image = self.selectedPhotoArr[i] as! UIImage
            photos.addObject(currentPhoto)
        }
        browser.photos = photos as [AnyObject]
        browser.currentPhotoIndex = UInt(indexPath.row)
        browser.show()
    }
    
    
//    MMPopupItemHandler block = ^(NSInteger index){
//    switch (index) {
//    case 0:
//    [self.selectedPhotoArr removeObject:self.selectedPhotoArr[longPress.view.tag - 1000]];
//    [self changeCollectionAddButtonAndReloadData];
//    default:
//    break;
//    }
//    };
//    NSArray *items = @[MMItemMake(@"删除", MMItemTypeNormal, block)];
//    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"" items:items];
//    [sheetView show];
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.nowTextField.resignFirstResponder()
    }
    
    // 选完照片
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, infos: [[NSObject : AnyObject]]!) {
        //
        self.selectedPhotoArr.addObjectsFromArray(photos)
        self.changeCollectionAddButtonAndReloadData()
        
    }
    
    // 拍完照片
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.pickerController.dismissViewControllerAnimated(true) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage;
            self.selectedPhotoArr.addObject(image)
            self.changeCollectionAddButtonAndReloadData()
        }
        
    }
    
    // 添加图片
    func addPicture() -> Void {
        let imagePickerVC = TZImagePickerController.init(maxImagesCount: 9-self.selectedPhotoArr.count, delegate: self)
        imagePickerVC.allowPickingVideo = false
        self.presentViewController(imagePickerVC, animated: true, completion: nil)
    }
    
    // 调整[+]位置
    func changeCollectionAddButtonAndReloadData() -> Void {
        
        if self.selectedPhotoArr.count<=8 {
            self.addPictureButton.frame = CGRectMake(CGFloat(self.selectedPhotoArr.count%4)*(10+(WIDTH-70)/4)+20, CGFloat(self.selectedPhotoArr.count/4)*(10+(WIDTH-70)/4)+200, PART_W(self.addPictureButton), PART_H(self.addPictureButton))
        }else{
            self.addPictureButton.frame = CGRectMake(WIDTH, HEIGHT, PART_W(self.addPictureButton), PART_H(self.addPictureButton))
        }
        self.collectionView.reloadData()
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
