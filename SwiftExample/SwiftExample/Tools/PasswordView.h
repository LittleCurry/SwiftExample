//
//  PasswordView.h
//  Lock
//
//  Created by 李云鹏 on 16/8/2.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordView : UIView
/*!
 * @brief 提现密码
 */
@property(nonatomic, retain) UITextField *myPasswordTextField;
/*!
 * @brief 黑点数组
 */
@property(nonatomic, retain) NSMutableArray *blackCircleArr;
/*!
 * @brief 6位密码输入完成
 */
@property (nonatomic,copy) void (^completeHandle)(NSString *inputPwd);

- (id)initWithTitle:(NSString *)title detail:(NSString *)detail;
/*!
 * @brief 展示
 */
- (void)show;
/*!
 * @brief 消失
 */
- (void)dismiss;
/*!
 * @brief 验证提现密码
 */
- (void)checkPassword:(void (^)(BOOL isRight))resultBlock;

@end
