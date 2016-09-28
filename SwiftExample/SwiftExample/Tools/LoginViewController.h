//
//  LoginViewController.h
//  TeSuFu
//
//  Created by yunPeng on 15/7/23.
//  Copyright (c) 2015年 yunPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property(nonatomic, copy)void(^personBlock)(NSString *str);
+ (LoginViewController *) getLoginVC;
+ (void)getMeLoginWithToken:(void (^)(BOOL result))resultBlock;// 测试token是否失效
+ (void) accountPasswordLogin:(void (^)(BOOL result))resultBlock;// 若token失效,测试用户名密码是否正确
-(BOOL)isVisible;

@end
