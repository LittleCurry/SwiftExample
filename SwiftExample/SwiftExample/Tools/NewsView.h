//
//  NewsView.h
//  SIP
//
//  Created by  on 12-4-5.
//  Copyright (c) 2012年 Vin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsView : UIView
@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UILabel *descriptionLabel;
@property (retain, nonatomic) UIButton *newsButton;

-(void)setViewWithTitle:(NSString *)title description:(NSString *)description;
@end
