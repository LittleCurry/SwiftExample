//
//  ThreepinView.m
//  TestLock2
//
//  Created by 李云鹏 on 16/5/27.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import "ThreepinView.h"

@implementation ThreepinView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] set];
    UIRectFill(rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, 0, 0);//设置起点
    CGContextAddLineToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width-5, rect.size.height/2);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[UIColor colorWithRed:0 green:207/255.0 blue:13/255.0 alpha:1] setFill];
    //设置填充色
    [[UIColor colorWithRed:0 green:207/255.0 blue:13/255.0 alpha:1] setStroke];
    //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
