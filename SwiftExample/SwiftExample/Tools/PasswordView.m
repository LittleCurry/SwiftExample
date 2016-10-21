//
//  PasswordView.m
//  Lock
//
//  Created by 李云鹏 on 16/8/2.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import "PasswordView.h"

@implementation PasswordView
- (id)initWithTitle:(NSString *)title detail:(NSString *)detail
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:0.8];
        self.blackCircleArr = [NSMutableArray array];
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT/2-150, WIDTH, 1000)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:CGRectMake(0, 0, 40, 40)];
        [closeButton setTitle:@"╳" forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:closeButton];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, WIDTH-80, 40)];
        titleLabel.font = WORDFONT;
        titleLabel.textAlignment = 1;
        titleLabel.text = title;
        [whiteView addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, 0.5)];
        lineView.backgroundColor = PLACEHOLODERCOLOR;
        [whiteView addSubview:lineView];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, WIDTH, 20)];
        detailLabel.font = [UIFont systemFontOfSize:12];
        detailLabel.textAlignment = 1;
        detailLabel.text = detail;
        [whiteView addSubview:detailLabel];
        //??????????方格??????????
        UIView *passwordWhiteView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/2-150, 100, 300, 50)];
        passwordWhiteView.backgroundColor = [UIColor whiteColor];
        [whiteView addSubview:passwordWhiteView];
        UIView *longLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, passwordWhiteView.PART_W, 0.5)];
        longLine1.backgroundColor = PLACEHOLODERCOLOR;
        [passwordWhiteView addSubview:longLine1];
        UIView *longLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, passwordWhiteView.PART_H-0.5, passwordWhiteView.PART_W, 0.5)];
        longLine2.backgroundColor = PLACEHOLODERCOLOR;
        [passwordWhiteView addSubview:longLine2];
        for (NSInteger i=0; i<7; i++) {
            UIView *shortLine = [[UIView alloc] initWithFrame:CGRectMake(i*passwordWhiteView.PART_H, 0, 0.5, passwordWhiteView.PART_H)];
            shortLine.backgroundColor = PLACEHOLODERCOLOR;
            [passwordWhiteView addSubview:shortLine];
            if (i!=6) {
                UIView *blackCircle = [[UIView alloc] initWithFrame:CGRectMake(passwordWhiteView.PART_H/2-5+i*passwordWhiteView.PART_H, passwordWhiteView.PART_H/2-5, 10, 10)];
                blackCircle.hidden = YES;
                blackCircle.clipsToBounds = YES;
                blackCircle.layer.cornerRadius = 5.5;
                blackCircle.backgroundColor = [UIColor blackColor];
                [passwordWhiteView addSubview:blackCircle];
                [self.blackCircleArr addObject:blackCircle];
            }
        }
        self.myPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, passwordWhiteView.PART_W, passwordWhiteView.PART_H)];
        self.myPasswordTextField.font = WORDFONT;
        self.myPasswordTextField.secureTextEntry = YES;
        self.myPasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.myPasswordTextField.textColor = [UIColor clearColor];
        self.myPasswordTextField.tintColor = [UIColor clearColor];
        [self.myPasswordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [passwordWhiteView addSubview:self.myPasswordTextField];
        //???????????????????????????????
    }
    return self;
}

- (void)show
{
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self.myPasswordTextField becomeFirstResponder];
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.alpha = 1.0;
    } completion:nil];
}


- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        [self.myPasswordTextField resignFirstResponder];
        self.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
    for (NSInteger i=0; i<self.blackCircleArr.count; i++) {
        UIView *blackCircle = self.blackCircleArr[i];
        blackCircle.hidden = YES;
        if (i<textField.text.length) {
            blackCircle.hidden = NO;
        }
    }
    if (textField.text.length == 6) {
        if (_completeHandle) {
            _completeHandle(textField.text);
        }
    }
}

- (void)checkPassword:(void (^)(BOOL isRight))resultBlock
{
    if (!self) {
        resultBlock(NO);
        return;
    }
    __weak typeof(self) weakSelf = self;
    // 此处验证密码
    NSString *str = [NSString stringWithFormat:@"%@/me", HEADHOST];
    [NetHandler getDataWithUrl:str parameters:nil tokenKey:@"Authorization" tokenValue:[JSESSIONID getJSESSIONID].token ifCaches:NO cachesData:nil success:^(NSData *successData) {
        // 验证密码成功
        resultBlock(YES);
    } failure:^(NSData *failureData) {
        // 验证密码失败
        resultBlock(NO);
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
