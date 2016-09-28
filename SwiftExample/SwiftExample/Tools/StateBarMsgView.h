//
//  StateBarMsgView.h
//  Lock
//
//  Created by 李云鹏 on 16/8/18.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateBarMsgView : UIView
/*!
 * @brief message
 */
@property(nonatomic, retain) NSString *message;

+ (StateBarMsgView *) getStateBarMsgView;

@end
