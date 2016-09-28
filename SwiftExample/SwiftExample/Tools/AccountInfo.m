//
//  AccountInfo.m
//  Lock
//
//  Created by 李云鹏 on 16/7/28.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import "AccountInfo.h"

@implementation AccountInfo
- (instancetype) initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id) valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
