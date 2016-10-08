//
//  DownEditView.m
//  Lock
//
//  Created by 李云鹏 on 16/6/16.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import "DownEditView.h"

@implementation DownEditView

- (instancetype)initWithArr:(NSArray *)arr
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120, 78, 115, arr.count*45)];
        self.blackView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.blackView];
        
        for (NSInteger i=0; i<arr.count; i++) {
            NSDictionary *dic = arr[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, i*45+13.5, 18, 18)];
            imageView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
            [self.blackView addSubview:imageView];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i+888;
            button.titleLabel.font = WORDFONT;
            [button setTitle:[dic objectForKey:@"title"] forState:0];
            button.frame = CGRectMake(26, i*45, 89, 45);
            [self.blackView addSubview:button];
            if (i!=arr.count-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, (i+1)*45, 95, 0.5)];
                lineView.backgroundColor = GRAY121COLOR;
                [self.blackView addSubview:lineView];
            }
        }
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self removeFromSuperview];
}

- (void)removeDownEditView
{
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor clearColor] set];
    UIRectFill(rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, [UIScreen mainScreen].bounds.size.width-25, 68);//设置起点
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width-30, 78);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width-20, 78);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[UIColor blackColor] setFill];
    //设置填充色
    [[UIColor blackColor] setStroke];
    //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
