//
//  MSSCollectionViewCell.m
//  MSSBrowse
//
//  Created by 于威 on 15/12/6.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "MSSCollectionViewCell.h"

@implementation MSSCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    _imageView.backgroundColor = GRAY121COLOR;
    [_imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _imageView.contentMode =  UIViewContentModeScaleAspectFill;
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _imageView.clipsToBounds  = YES;
    [self.contentView addSubview:_imageView];
}

@end
