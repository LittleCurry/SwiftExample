//
//  FirstCircleMenuViewController.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/20.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class FirstCircleMenuViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var editBtnItem = UIBarButtonItem.init()
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
        self.getView()
    }
    
    func getView() -> Void {
        self.navigationItem.title = "圆形菜单"
        
        self.type = 0;
        self.showingSettings = false;
        var error : NSError?
        let jsonPath = NSBundle.mainBundle().pathForResource("players", ofType: "json")
        let jsonString = try! NSString.init(contentsOfFile: jsonPath!, encoding: NSUTF8StringEncoding)
        self.items = try! NSJSONSerialization.JSONObjectWithData(jsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        self.settingsView = UIView.init(frame: CGRectMake(0, HEIGHT, WIDTH, HEIGHT-44))
        self.settingsView?.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.settingsView!)
        self.buildSettings()
        
        
        
        
        
        var radius:CGFloat = CGFloat(self.radiusSlider!.value * 1000);
        var angularSpacing:CGFloat = CGFloat(self.angularSpacingSlider!.value * 90);
        var xOffset = self.xOffsetSlider!.value * 320;
        var cell_width = 240.0;
        var cell_height = 100.0;
        self.radiusLabel?.text = String.init(format: "Radius: %i", Int(radius))
        self.angularSpacingLabel?.text = String.init(format: "Angular spacing: %i", Int(angularSpacing))
        self.xOffsetLabel?.text = String.init(format: "X offset: %i", Int(xOffset))
        
        
        self.dialLayout = AWCollectionViewDialLayout.init(radius: radius, andAngularSpacing: angularSpacing, andCellSize: CGSizeMake(240, 100), andAlignment:.WHEELALIGNMENTCENTER, andItemHeight: 100, andXOffset: CGFloat(xOffset))
        self.collectionView = UICollectionView.init(frame: CGRectMake(0, 100, WIDTH, WIDTH), collectionViewLayout: self.dialLayout!);
        self.collectionView.backgroundColor = RGBA(239, g: 239, b: 244, a: 1);
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;

        self.collectionView.registerNib(UINib.init(nibName: "dialCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: cellId)
        self.collectionView.registerNib(UINib.init(nibName: "dialCell2", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: cellId2)
        self.view.addSubview(self.collectionView)
        
        let editBtnItem = UIBarButtonItem.init(title: "edit", style: UIBarButtonItemStyle.Plain, target: self, action: "toggleSettingsView")
        self.navigationItem.rightBarButtonItem = editBtnItem;
        self.editBtnItem = editBtnItem;
        self.switchExample()
    }
    
    func buildSettings() {
        let viewArr = NSBundle.mainBundle().loadNibNamed("iphone_settings_view", owner: self, options: nil)
        var innerView = viewArr[0] as! UIView
        var frame = innerView.frame
        frame.origin.y = (HEIGHT/2 - frame.size.height/2)/2;
        innerView.frame = frame;
        self.settingsView!.addSubview(innerView)
        self.radiusLabel = innerView.viewWithTag(100) as? UILabel
        self.radiusSlider = innerView.viewWithTag(200) as? UISlider
        self.radiusSlider?.addTarget(self, action: "updateDialSettings", forControlEvents: UIControlEvents.ValueChanged)
        self.angularSpacingLabel = innerView.viewWithTag(101) as? UILabel
        self.angularSpacingSlider = innerView.viewWithTag(201) as? UISlider
        self.angularSpacingSlider?.addTarget(self, action: "updateDialSettings", forControlEvents: UIControlEvents.ValueChanged)
        self.xOffsetLabel = innerView.viewWithTag(102) as? UILabel
        self.xOffsetSlider = innerView.viewWithTag(202) as? UISlider
        self.xOffsetSlider?.addTarget(self, action: "updateDialSettings", forControlEvents: .ValueChanged)
        self.exampleSwitch = innerView.viewWithTag(203) as? UISegmentedControl
        self.exampleSwitch?.addTarget(self, action: "switchExample", forControlEvents: .ValueChanged)
    }
    
    func switchExample() {
        self.type = (self.exampleSwitch?.selectedSegmentIndex)!
        var radius = 0.0
        var angularSpacing = 0.0
        var xOffset = 0.0
        if(type == 0){
            self.dialLayout?.cellSize = CGSizeMake(240, 100)
//            self.dialLayout?.wheelType = .WHEELALIGNMENTLEFT
            radius = 300;
            angularSpacing = 18;
            xOffset = 70;
        }else if(type == 1){
            self.dialLayout?.cellSize = CGSizeMake(260, 50)
            // self.dialLayout?.wheelType = .WHEELALIGNMENTCENTER
            radius = 320;
            angularSpacing = 5;
            xOffset = 124;
        }
        
        self.radiusLabel?.text = String.init(format: "Radius: %i", Int(radius))
        self.radiusSlider!.value = Float(radius/1000)
        self.dialLayout?.dialRadius = CGFloat(radius)
        self.angularSpacingLabel?.text = String.init(format: "Angular spacing: %i", Int(angularSpacing))
        self.angularSpacingSlider!.value = Float(angularSpacing / 90)
        self.dialLayout?.AngularSpacing = CGFloat(angularSpacing)
        self.xOffsetLabel?.text = String.init(format: "X offset: %i", Int(xOffset))
        self.xOffsetSlider!.value = Float(xOffset/320)
        self.dialLayout?.offset = CGFloat(xOffset)
        self.collectionView.reloadData()
    }
    
//    -(void)switchExample{
//    type = (int)exampleSwitch.selectedSegmentIndex;
//    CGFloat radius = 0 ,angularSpacing  = 0, xOffset = 0;
//    
//    if(type == 0){
//    [dialLayout setCellSize:CGSizeMake(240, 100)];
//    [dialLayout setWheelType:WHEELALIGNMENTLEFT];
//    
//    radius = 300;
//    angularSpacing = 18;
//    xOffset = 70;
//    }else if(type == 1){
//    [dialLayout setCellSize:CGSizeMake(260, 50)];
//    [dialLayout setWheelType:WHEELALIGNMENTCENTER];
//    
//    radius = 320;
//    angularSpacing = 5;
//    xOffset = 124;
//    }
//    
//    [radiusLabel setText:[NSString stringWithFormat:@"Radius: %i", (int)radius]];
//    radiusSlider.value = radius/1000;
//    [dialLayout setDialRadius:radius];
//    
//    [angularSpacingLabel setText:[NSString stringWithFormat:@"Angular spacing: %i", (int)angularSpacing]];
//    angularSpacingSlider.value = angularSpacing / 90;
//    [dialLayout setAngularSpacing:angularSpacing];
//    
//    [xOffsetLabel setText:[NSString stringWithFormat:@"X offset: %i", (int)xOffset]];
//    xOffsetSlider.value = xOffset/320;
//    [dialLayout setXOffset:xOffset];
//    
//    
//    [collectionView reloadData];
//    
//    }
    
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
        
        var cell : UICollectionViewCell?
        if(self.type == 0){
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellId, forIndexPath: indexPath)
        }else{
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellId2, forIndexPath: indexPath)
        }
        var aItem : NSDictionary = self.items[indexPath.item] as! NSDictionary
        print(aItem)
        var playerName = aItem["name"] as! String
        var nameLabel = cell?.viewWithTag(101) as! UILabel
        nameLabel.text = playerName
        var hexColor = aItem["team-color"] as! String
        
        if(self.type == 0){
            var borderView = cell?.viewWithTag(102)
            borderView!.layer.borderWidth = 1;
            borderView!.layer.borderColor = UIColor.redColor().CGColor
            var imgURL = aItem["picture"] as! String
            print(imgURL)
            var imgView = cell?.viewWithTag(100) as! UIImageView
            imgView.image = UIImage.init(named: imgURL)
        }
        return cell!
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
