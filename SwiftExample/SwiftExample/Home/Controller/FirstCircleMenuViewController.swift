//
//  FirstCircleMenuViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/20.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstCircleMenuViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView:UICollectionView!
    var items = []
    var cellId = "cellId";
    var cellId2 = "cellId2";
    var thumbnailCache:NSMutableDictionary?;
    var showingSettings = false;
    var settingsView:UIView?;
    var radiusLabel:UILabel?;
    var radiusSlider:UISlider?;
    var angularSpacingLabel:UILabel?;
    var angularSpacingSlider:UISlider?;
    var xOffsetLabel:UILabel?;
    var xOffsetSlider:UISlider?;
    var exampleSwitch:UISegmentedControl?;
    var dialLayout:AWCollectionViewDialLayout?;
    var type = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.getView()
    }
    
    func getView() -> Void {
        var radius:CGFloat = CGFloat(self.radiusSlider!.value * 1000);
        var angularSpacing:CGFloat = CGFloat(self.angularSpacingSlider!.value * 90);
        var xOffset = self.xOffsetSlider!.value * 320;
        var cell_width = 240.0;
        var cell_height = 100.0;
        self.radiusLabel?.text = String.init(format: "Radius: %i", Int(radius))
        self.angularSpacingLabel?.text = String.init(format: "Angular spacing: %i", Int(angularSpacing))
        self.xOffsetLabel?.text = String.init(format: "X offset: %i", Int(xOffset))
        
        
        
//        self.dialLayout = AWCollectionViewDialLayout.init(radius: radius, andAngularSpacing: angularSpacing, andCellSize: CGSizeMake(240, 100), andAlignment: WheelAlignmeType.WHEELALIGNMENTCENTER, andItemHeight: 100, andXOffset: xOffset)
        
        
        
//        dialLayout = [[AWCollectionViewDialLayout alloc] initWithRadius:radius andAngularSpacing:angularSpacing andCellSize:CGSizeMake(cell_width, cell_height) andAlignment:WHEELALIGNMENTCENTER andItemHeight:cell_height andXOffset:xOffset];
//        
//            
//            [[AWCollectionViewDialLayout alloc] initWithRadius:radius andAngularSpacing:angularSpacing andCellSize:CGSizeMake(cell_width, cell_height) andAlignment:WHEELALIGNMENTCENTER andItemHeight:cell_height andXOffset:xOffset];
        
        
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: self.dialLayout!);
        self.collectionView.backgroundColor = RGBA(239, g: 239, b: 244, a: 1);
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
//        self.collectionView.contentInset = UIEdgeInsetsMake(navigationBar_H(self.navigationController!), 0, tabBar_H(self.tabBarController!), 0);
        self.collectionView.registerClass(PlayCollectionViewCell.self, forCellWithReuseIdentifier: self.cellId);
        
        self.collectionView.registerClass(PlayCollectionViewCell.self, forCellWithReuseIdentifier: self.cellId2);
    }
    
//    {
//    
//    [collectionView registerNib:[UINib nibWithNibName:@"dialCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
//    [collectionView registerNib:[UINib nibWithNibName:@"dialCell2" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId2];
//    
//    
//    NSError *error;
//    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"players" ofType:@"json"];
//    NSLog(@"jsonPath = %@", jsonPath);
//    
//    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
//    NSLog(@"jsonString:%@",jsonString);
//    items = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
//    
//    settingsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-44)];
//    [settingsView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
//    [self.view addSubview:settingsView];
//    [self buildSettings];
//    
//    
//    CGFloat radius = radiusSlider.value * 1000;
//    CGFloat angularSpacing = angularSpacingSlider.value * 90;
//    CGFloat xOffset = xOffsetSlider.value * 320;
//    CGFloat cell_width = 240;
//    CGFloat cell_height = 100;
//    [radiusLabel setText:[NSString stringWithFormat:@"Radius: %i", (int)radius]];
//    [angularSpacingLabel setText:[NSString stringWithFormat:@"Angular spacing: %i", (int)angularSpacing]];
//    [xOffsetLabel setText:[NSString stringWithFormat:@"X offset: %i", (int)xOffset]];
//    
//    
//    
//    dialLayout = [[AWCollectionViewDialLayout alloc] initWithRadius:radius andAngularSpacing:angularSpacing andCellSize:CGSizeMake(cell_width, cell_height) andAlignment:WHEELALIGNMENTCENTER andItemHeight:cell_height andXOffset:xOffset];
//    [collectionView setCollectionViewLayout:dialLayout];
//    
//    
//    
//    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleSettingsView)];
//    self.navigationItem.rightBarButtonItem = editBtnItem;
//    self.editBtnItem = editBtnItem;
//    
//    [self switchExample];
//    
//    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellId, forIndexPath: indexPath) as! MSSCollectionViewCell
        
//        cell.imageView.image = self.selectedPhotoArr[indexPath.row] as? UIImage;
        cell.imageView.tag = indexPath.row + 1000;
        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFill;
        cell.imageView.clipsToBounds = true;
        cell.imageView.userInteractionEnabled = true;
        let longPress = UILongPressGestureRecognizer.init(target: self, action: "deletePhoto:")
        cell.imageView.addGestureRecognizer(longPress)
        return cell
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
