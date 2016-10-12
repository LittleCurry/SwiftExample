//
//  FirstPhotoChoseViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/11.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstPhotoChoseViewController: BaseViewController, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate,  UICollectionViewDelegate,UICollectionViewDataSource {
    
    var selectedPhotoArr:NSMutableArray = [];
    var pickerController = UIImagePickerController.init();
    var collectionView = UICollectionView.init()
    var addPictureButton = UIButton.init(type: UIButtonType.System)
    var addLabel = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "相册选择"
        let button = UIButton.init(type: UIButtonType.System)
        button.frame = CGRectMake(30, 100, 50, 30)
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        var flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake((WIDTH-70)/4, (WIDTH-70)/4);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        self.collectionView = UICollectionView.init(frame: CGRectMake(0, 200, WIDTH, WIDTH), collectionViewLayout: flowLayout)
        self.collectionView.scrollEnabled = false;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.registerClass(MSSCollectionViewCell.self, forCellWithReuseIdentifier: "MSSCollectionViewCell")
        self.view.addSubview(self.collectionView)
        
        
        
        
        
//        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.textView.X, self.textView.Y + self.textView.PART_H, WIDTH-40, [self collectionCount:self.selectedPhotoArr.count]*(((WIDTH-70)/4)+10)-10) collectionViewLayout:flowLayout];
//        self.collectionView.collectionViewLayout = flowLayout;
//        self.collectionView.backgroundColor = [UIColor clearColor];
        //???????
        
//        self.addPictureButton.frame = CGRectMake(X(self.collectionView) + (((WIDTH-70)/4)+10)*(self.selectedPhotoArr.count%4), Y(self.collectionView) + (self.selectedPhotoArr.count/4)*(((WIDTH-70)/4)+10), (WIDTH-70)/4, (WIDTH-70)/4);
        self.addPictureButton.setBackgroundImage(UIImage.init(named: "add.png"), forState: UIControlState.Normal)
        self.addPictureButton.addTarget(self, action: "addPicture", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.addPictureButton)
        
        self.addLabel.frame = CGRectMake(X(self.addPictureButton), Y(self.addPictureButton) + PART_H(self.addPictureButton), PART_W(self.addPictureButton), 13)
        self.addLabel.font = UIFont.systemFontOfSize(12);
        self.addLabel.textAlignment = NSTextAlignment.Center;
        self.addLabel.textColor = UIColor.lightGrayColor();
        self.addLabel.text = "添加图片";
        self.view.addSubview(self.addLabel)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedPhotoArr.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("MSSCollectionViewCell", forIndexPath: indexPath) as! MSSCollectionViewCell
//        if (cell != nil) {
        cell.imageView.image = self.selectedPhotoArr[indexPath.row] as! UIImage;
        cell.imageView.tag = indexPath.row + 1000;
        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFill;
        cell.imageView.clipsToBounds = true;
        cell.imageView.userInteractionEnabled = true;
        let longPress = UILongPressGestureRecognizer.init(target: self, action: "deletePhoto")
        cell.imageView.addGestureRecognizer(longPress)
        return cell
        
//        }
        
    }
    
    
//    - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//    MSSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSCollectionViewCell" forIndexPath:indexPath];
//    if (cell){
//    cell.imageView.image = self.selectedPhotoArr[indexPath.row];
//    cell.imageView.tag = indexPath.row + 1000;
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    cell.imageView.clipsToBounds = YES;
//    cell.imageView.userInteractionEnabled = YES;
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deletePhoto:)];
//    [cell.imageView addGestureRecognizer:longPress];
//    
//    }
//    return cell;
//    }
    
//    - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//    NSMutableArray *photos = [NSMutableArray array];
//    for (NSInteger i = 0; i < self.selectedPhotoArr.count; i++) {
//    MJPhoto *currentPhoto = [[MJPhoto alloc] init];
//    currentPhoto.image = self.selectedPhotoArr[i];
//    [photos addObject:currentPhoto];
//    }
//    browser.photos = photos;
//    browser.currentPhotoIndex = indexPath.row;
//    [browser show];
//    }
    
    
    
    func buttonAction() -> Void {
        let imagePickerVC = TZImagePickerController.init(maxImagesCount: 9, delegate: self)
        imagePickerVC.allowPickingVideo = false
        self.presentViewController(imagePickerVC, animated: true, completion: nil)
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
    
    func addPicture() -> Void {
        //
    }
    
    func changeCollectionAddButtonAndReloadData() -> Void {
//        self.collectionView.frame = CGRectMake(self.textView.X, self.textView.Y + self.textView.PART_H, WIDTH-40, [self collectionCount:self.selectedPhotoArr.count]*(((WIDTH-70)/4)+10)-10);
//        self.addPictureButton.frame = CGRectMake(self.collectionView.X + (((WIDTH-70)/4)+10)*(self.selectedPhotoArr.count%4), self.collectionView.Y + (self.selectedPhotoArr.count/4)*(((WIDTH-70)/4)+10), (WIDTH-70)/4, (WIDTH-70)/4);
//        self.addLabel.frame = CGRectMake(self.addPictureButton.X, self.addPictureButton.Y + self.addPictureButton.PART_H, self.addPictureButton.PART_W, 13);
//        self.collectionView.reloadData()
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
