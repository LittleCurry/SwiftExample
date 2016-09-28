//
//  AccountInfo.h
//  Lock
//
//  Created by 李云鹏 on 16/7/28.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountInfo : NSObject
/*!
 * @brief 真实姓名
 */
@property(nonatomic, retain) NSString *name;
/*!
 * @brief 身份证号
 */
@property(nonatomic, retain) NSString *idNumber;
/*!
 * @brief 提现方式
 */
@property(nonatomic, retain) NSArray *channels;

- (instancetype) initWithDictionary:(NSDictionary *)dic;
- (void) setValue:(id)value forUndefinedKey:(NSString *)key;
- (id) valueForUndefinedKey:(NSString *)key;

@end
