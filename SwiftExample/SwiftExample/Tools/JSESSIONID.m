//
//  JSESSIONID.m
//  TeSuFu
//
//  Created by yunPeng on 15/7/14.
//  Copyright (c) 2015年 yunPeng. All rights reserved.
//

#import "JSESSIONID.h"

@implementation JSESSIONID
+ (JSESSIONID *) getJSESSIONID
{
    static JSESSIONID *dbHandler = nil;
    if (dbHandler == nil) {
        dbHandler = [[JSESSIONID alloc] init];
    }
    return dbHandler;
}


@end
