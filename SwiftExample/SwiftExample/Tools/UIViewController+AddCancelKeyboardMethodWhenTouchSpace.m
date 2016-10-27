//
//  UIViewController+AddCancelKeyboardMethodWhenTouchSpace.m
//  Lock
//
//  Created by 李云鹏 on 16/3/23.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import "UIViewController+AddCancelKeyboardMethodWhenTouchSpace.h"

@implementation UIViewController (AddCancelKeyboardMethodWhenTouchSpace)
static UIButton *bigButton;
static NSMutableArray *responesViewArr;
static NSMutableArray *buttonArr;
- (void)addCancelKeyboardMethodWhenTouchSpace:(UIView *)responesView
{
    if (responesViewArr == nil) {
        responesViewArr = [NSMutableArray array];
    }
    if (![responesViewArr containsObject:responesView]) {
        [responesViewArr addObject:responesView];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    if (buttonArr == nil) {
        buttonArr = [NSMutableArray array];
    }
    bigButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if (![buttonArr containsObject:bigButton]) {
        [buttonArr addObject:bigButton];
    }
    bigButton.frame = CGRectMake(0, 64, WIDTH, 0);
    [bigButton addTarget:self action:@selector(downKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bigButton];
}

- (void)downKeyboard:(UIButton *)button
{
    for (UIView *tempView in responesViewArr) {
        [tempView resignFirstResponder];
    }
    for (UIButton *tempButton in buttonArr) {
        tempButton.frame = CGRectMake(bigButton.X, bigButton.Y, bigButton.PART_W, 0);
    }
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    for (UIButton *tempButton in buttonArr) {
        tempButton.frame = CGRectMake(bigButton.X, bigButton.Y, bigButton.PART_W, HEIGHT - 64 - kbSize.height);
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    for (UIButton *tempButton in buttonArr) {
        tempButton.frame = CGRectMake(bigButton.X, bigButton.Y, bigButton.PART_W, 0);
    }
}


@end
