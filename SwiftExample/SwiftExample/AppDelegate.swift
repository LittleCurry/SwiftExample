//
//  AppDelegate.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/9/28.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var allowRotate = 0
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //热更新加载, swift 用法和oc有一定区别, 主要是在runtime上的,如何在下载完成之后刷新工程.添加截图,testP,加一个circleSlider, 测试git contribution again
        JSPatch.start(withAppKey: "a75345057bbd6e47")
        JSPatch.sync()
//        sleep(5)
        /*
         设置在线参数请求完成的回调
         */
//        JSPatch.setupUpdatedConfigCallback { (<#[NSObject : AnyObject]!#>, <#NSError!#>) in
        
//        }
        // 出现一个问题, 在提交到github上时,SwiftTableView/SwiftTableView内容没提交上
        
        window = UIWindow.init(frame: UIScreen.main.bounds);
        window?.backgroundColor = UIColor.white;
        window?.makeKeyAndVisible();
//        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        let firstVC = FirstViewController.init();
        let firstNVC = UINavigationController.init(rootViewController: firstVC);
        firstNVC.tabBarItem.image = UIImage.init(named: "first.png");
        firstNVC.tabBarItem.selectedImage = UIImage.init(named: "firsting.png");
        firstNVC.title = "主页"
        
        let secondVC = SecondViewController.init();
        let secondNVC = UINavigationController.init(rootViewController: secondVC);
        secondNVC.tabBarItem.image = UIImage.init(named: "second.png");
        secondNVC.tabBarItem.selectedImage = UIImage.init(named: "seconding.png");
        secondNVC.title = "second"
        
        let thirdVC = ThirdViewController.init();
        let thirdNVC = UINavigationController.init(rootViewController: thirdVC);
        thirdNVC.tabBarItem.image = UIImage.init(named: "third.png");
        thirdNVC.tabBarItem.selectedImage = UIImage.init(named: "thirding.png");
        thirdNVC.title = "third"
        
        let fouthVC = FouthViewController.init();
        let fouthNVC = UINavigationController.init(rootViewController: fouthVC);
        fouthNVC.tabBarItem.image = UIImage.init(named: "fouth.png");
        fouthNVC.tabBarItem.selectedImage = UIImage.init(named: "fouthing.png");
        fouthNVC.title = "fouth"
        
        let tab = UITabBarController.init();
        tab.tabBar.tintColor = mainColor;
        tab.viewControllers = [firstNVC, secondNVC, thirdNVC, fouthNVC];
        window?.rootViewController = tab;
        //友盟
        UMSocialData.setAppKey(UmengAppkey)
//        UMSocialWechatHandler.setWXAppId("wx635dd5eee50cb305", appSecret: "ff931b6f29d2726a60e723ab8c12eb4e", url: "https://www.iguiyu.com")
//        UMSocialQQHandler.setQQWithAppId("1105492186", appKey: "u1aiQcJbJhiEssP1", url: "https://www.iguiyu.com")
//        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("2219048349", secret: "5576c211ddd3b84e353d7f8e22728378", redirectURL: "http://sns.whalecloud.com/sina2/callback");
        //高德
        MAMapServices.shared().apiKey = "84a84deb380d2b0fd87f73e8261f4d8b"
        AMapSearchServices.shared().apiKey = "84a84deb380d2b0fd87f73e8261f4d8b"
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.shared.applicationIconBadgeNumber = 0;
        UMSocialSnsService.applicationDidBecomeActive();
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    //此方法会在设备横竖屏变化的时候调用
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        // NSLog("方向  =============   %ld", self.allowRotate);
        if (self.allowRotate == 1) {
            return UIInterfaceOrientationMask.all
        }else{
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    // 返回是否支持设备自动旋转
    func shouldAutorotate() -> Bool {
        if (self.allowRotate == 1) {
            return true
        }
        return false
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "yunPeng.SwiftTableView" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "SwiftTableView", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
}

