//
//  YFCard.h
//  Jigsaw
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef  struct{  
//    int X;
//    int Y;
//};
//typedef struct Position position;
//
//
//CG_INLINE Position
//PointMake(CGFloat x, CGFloat y) {
//    CGPoint p;
//    p.x = x;
//    p.y = y;
//    return p;
//}

struct CardPosition{
    int myX;
    int myY;
};
typedef struct CardPosition Position;

CG_INLINE Position
PositionMake(int myX, int myY)
{
    Position position;
    position.myX = myX;
    position.myY = myY;
    return position;
}


@interface YFCard : UIImageView

- (void)moveToTarget:(id)target action:(SEL)action;

- (void)setDefaultFrame;


// 原始位置
@property (nonatomic, assign) Position originPosition;

// 当前位置
@property (nonatomic, assign) Position position;

@end
