//
//  DownEditView.h
//  Lock
//
//  Created by 李云鹏 on 16/6/16.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownEditView : UIView
@property(nonatomic, retain) UIView *blackView;
- (instancetype)initWithArr:(NSArray *)arr;
- (void)removeDownEditView;

@end
