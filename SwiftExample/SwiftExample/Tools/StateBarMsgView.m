//
//  StateBarMsgView.m
//  Lock
//
//  Created by 李云鹏 on 16/8/18.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import "StateBarMsgView.h"

@implementation StateBarMsgView
static UILabel *msgLabel;
+ (StateBarMsgView *) getStateBarMsgView
{
    static StateBarMsgView *msgView = nil;
    if (msgView == nil) {
        msgView = [[StateBarMsgView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
        msgLabel = [[UILabel alloc] initWithFrame:msgView.bounds];
        msgLabel.backgroundColor = [UIColor blackColor];
        msgLabel.textAlignment = 1;
        msgLabel.textColor = [UIColor whiteColor];
        msgLabel.font = [UIFont systemFontOfSize:12];
        [msgView addSubview:msgLabel];
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        window.windowLevel = UIWindowLevelStatusBar+1.0f;
        [window addSubview:msgView];
    }
    return msgView;
}

- (void)setMessage:(NSString *)message
{
    msgLabel.text = message;
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, WIDTH, 20);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            self.alpha = 0.1;
            self.frame = CGRectMake(0, -20, WIDTH, 20);
        }];
    });
}

@end
