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
    var addPictureButton = UIButton.init(type: UIButtonType.system)
    let nowTextField = UITextField.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getView()
    }
    
    func getView() -> Void {
        
        self.navigationItem.title = "相册选择"
        self.nowTextField.frame = CGRect(x: 20, y: 70, width: WIDTH-40, height: 40)
        nowTextField.placeholder = "这一刻的想法..."
        self.view.addSubview(nowTextField)
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        flowLayout.itemSize = CGSize(width: (WIDTH-70)/4, height: (WIDTH-70)/4);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        self.collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 200, width: WIDTH, height: WIDTH), collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.isScrollEnabled = false;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.register(MSSCollectionViewCell.self, forCellWithReuseIdentifier: MSSReuseIdentifier)
        self.view.addSubview(self.collectionView)
        
        self.addPictureButton.frame = CGRect(x: 20, y: 200, width: (WIDTH-70)/4, height: (WIDTH-70)/4);
        self.addPictureButton.setBackgroundImage(UIImage.init(named: "squareAdd.png"), for: UIControlState())
        self.addPictureButton.addTarget(self, action: #selector(FirstPhotoChoseViewController.addPicture), for: UIControlEvents.touchUpInside)
        self.view.addSubview(self.addPictureButton)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedPhotoArr.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MSSReuseIdentifier, for: indexPath) as! MSSCollectionViewCell
        
        cell.imageView.image = self.selectedPhotoArr[indexPath.row] as? UIImage;
        cell.imageView.tag = indexPath.row + 1000;
        cell.imageView.contentMode = UIViewContentMode.scaleAspectFill;
        cell.imageView.clipsToBounds = true;
        cell.imageView.isUserInteractionEnabled = true;
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(FirstPhotoChoseViewController.deletePhoto(_:)))
        cell.imageView.addGestureRecognizer(longPress)
        return cell
    }
    
    func deletePhoto(_ longPress:UILongPressGestureRecognizer) -> Void {
        if longPress.state == UIGestureRecognizerState.began {
            self.selectedPhotoArr.remove(self.selectedPhotoArr[longPress.view!.tag - 1000])
            self.changeCollectionAddButtonAndReloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        let browser = MJPhotoBrowser.init()
        let photos:NSMutableArray = []
        for i in 0...self.selectedPhotoArr.count-1 {
            let currentPhoto = MJPhoto.init()
            currentPhoto.image = self.selectedPhotoArr[i] as! UIImage
            photos.add(currentPhoto)
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.nowTextField.resignFirstResponder()
    }
    
    // 选完照片
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, infos: [[AnyHashable: Any]]!) {
        //
        self.selectedPhotoArr.addObjects(from: photos)
        self.changeCollectionAddButtonAndReloadData()
        
    }
    
    // 拍完照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.pickerController.dismiss(animated: true) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage;
            self.selectedPhotoArr.add(image)
            self.changeCollectionAddButtonAndReloadData()
        }
        
    }
    
    // 添加图片
    func addPicture() -> Void {
        let imagePickerVC = TZImagePickerController.init(maxImagesCount: 9-self.selectedPhotoArr.count, delegate: self)
        imagePickerVC?.allowPickingVideo = false
        self.present(imagePickerVC!, animated: true, completion: nil)
    }
    
    // 调整[+]位置
    func changeCollectionAddButtonAndReloadData() -> Void {
        
        if self.selectedPhotoArr.count<=8 {
            self.addPictureButton.frame = CGRect(x: CGFloat(self.selectedPhotoArr.count%4)*(10+(WIDTH-70)/4)+20, y: CGFloat(self.selectedPhotoArr.count/4)*(10+(WIDTH-70)/4)+200, width: PART_W(self.addPictureButton), height: PART_H(self.addPictureButton))
        }else{
            self.addPictureButton.frame = CGRect(x: WIDTH, y: HEIGHT, width: PART_W(self.addPictureButton), height: PART_H(self.addPictureButton))
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
