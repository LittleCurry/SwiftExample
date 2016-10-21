//
//  NewsView.m
//  SIP
//
//  Created by  on 12-4-5.
//  Copyright (c) 2012年 Vin. All rights reserved.
//

#import "NewsView.h"

@implementation NewsView
@synthesize titleLabel;
@synthesize descriptionLabel;
@synthesize newsButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setBackgroundColor:[UIColor grayColor]];
        titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 2, frame.size.width, 21)];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.font=[UIFont boldSystemFontOfSize:13.0];
//        titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
        titleLabel.numberOfLines = 1;
        [self addSubview:titleLabel];
        descriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 17, frame.size.width, 15)];
        descriptionLabel.textColor=[UIColor blackColor];
        descriptionLabel.backgroundColor=[UIColor clearColor];
        descriptionLabel.font=[UIFont systemFontOfSize:11.0];
        descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
        descriptionLabel.numberOfLines = 1;
//        [self addSubview:descriptionLabel];
        newsButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [newsButton setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:newsButton];
    }
    return self;
}

-(void)dealloc{
//    [titleLabel release];
//    [descriptionLabel release];
//    [super dealloc];
}

-(void)setViewWithTitle:(NSString *)title description:(NSString *)description{
    [titleLabel setText:title];
    [descriptionLabel setText:description];
}

@end
