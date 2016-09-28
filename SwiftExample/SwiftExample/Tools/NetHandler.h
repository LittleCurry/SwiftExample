//
//  NetHandler.h
//  TeSuFu
//
//  Created by yunPeng on 15/5/21.
//  Copyright (c) 2015年 yunPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetHandler : NSObject
+ (void)getDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock;

+ (void)postDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock;

+ (void)putDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock;

+ (void)deleteDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock;

+ (void)patchDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock;

@end
