//
//  NetHandler.m
//  TeSuFu
//
//  Created by yunPeng on 15/5/21.
//  Copyright (c) 2015年 yunPeng. All rights reserved.
//

#import "NetHandler.h"

@implementation NetHandler
+ (void)getDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
#pragma mark - 调用此封装时,首先看有没有缓存,需要的话,先把缓存抛出
    NSString *folderPath = [NSString stringWithFormat:@"%@/AFNetworkingCaches", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%ld.aa", folderPath, [[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] hash]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (ifAddCaches) {
            cacheBlock(data);
        }
    }
#pragma mark - 正常的请求
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 通常是添加token
    if (tokenKey.length > 0 && tokenValue.length > 0) {
        [session.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
    }
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];// 设置相应内容类型
    // [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:4];
    [session GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        // nil
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (ifAddCaches) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            // 创建目录
            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
        }
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (error.code != -1003) {
            failureBlock(responseData);
        }
        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        LoginViewController *loginVC = [LoginViewController getLoginVC];
        if (response.statusCode==401 && ![loginVC isVisible]) {
            [self displayLoginViewController];
        }
        if (response.statusCode == 500) {
            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
        }
        if (response.statusCode != 401 && response.statusCode != 500) {
            NSString *message = @"";
            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
            NSRange range;
            range = [message rangeOfString:@":"];
            if (range.location != NSNotFound) {
                message = [message substringFromIndex:range.location+1];
            }
            if (message.length>0) {
                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
            }
            if (message.length == 0) {
                message = (NSString *)error.userInfo[@"NSLocalizedDescription"];
                if (message.length>0 && error.code != -1003) {
                    [StateBarMsgView getStateBarMsgView].message = message;
                }
                if (error.code == -1003) {
                    // 找不到指定域名的主机, 通常为域名解析错误
                    NSString *ipUrl = [urlStr stringByReplacingOccurrencesOfString:HEADHOST withString:IPHOST];
                    AFHTTPSessionManager *ipSession = [AFHTTPSessionManager manager];
                    ipSession.requestSerializer = [AFJSONRequestSerializer serializer];
                    ipSession.responseSerializer = [AFHTTPResponseSerializer serializer];
                    if (tokenKey.length > 0 && tokenValue.length > 0) {
                        [ipSession.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
                    }
                    [ipSession GET:ipUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if (ifAddCaches) {
                            NSFileManager *fileManager = [NSFileManager defaultManager];
                            // 创建目录
                            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
                            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
                        }
                        successBlock(responseObject);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                        failureBlock(responseData);
                        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                        LoginViewController *loginVC = [LoginViewController getLoginVC];
                        if (response.statusCode==401 && ![loginVC isVisible]) {
                            [self displayLoginViewController];
                        }
                        if (response.statusCode == 500) {
                            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
                        }
                        if (response.statusCode != 401 && response.statusCode != 500) {
                            NSString *message = @"";
                            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
                            NSRange range;
                            range = [message rangeOfString:@":"];
                            if (range.location != NSNotFound) {
                                message = [message substringFromIndex:range.location+1];
                            }
                            if (message.length>0) {
                                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
                            }
                        }
                    }];
                }
            }
        }
    }];
}

+ (void)postDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
#pragma mark - 调用此封装时,首先看有没有缓存,需要的话,先把缓存抛出
    NSString *folderPath = [NSString stringWithFormat:@"%@/AFNetworkingCaches", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%ld.aa", folderPath, [[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] hash]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (ifAddCaches) {
            cacheBlock(data);
        }
    }
#pragma mark - 正常的请求
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 通常是添加token
    if (tokenKey.length > 0 && tokenValue.length > 0) {
        [session.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
    }
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];// 设置相应内容类型
    // [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:4];
    [session POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        // nil
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (ifAddCaches) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            // 创建目录
            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
        }
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (error.code != -1003) {
            failureBlock(responseData);
        }
        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        LoginViewController *loginVC = [LoginViewController getLoginVC];
        if (response.statusCode==401 && ![loginVC isVisible]) {
            [self displayLoginViewController];
        }
        if (response.statusCode == 500) {
            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
        }
        if (response.statusCode != 401 && response.statusCode != 500) {
            NSString *message = @"";
            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
            NSRange range;
            range = [message rangeOfString:@":"];
            if (range.location != NSNotFound) {
                message = [message substringFromIndex:range.location+1];
            }
            if (message.length>0) {
                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
            }
            if (message.length == 0) {
                message = (NSString *)error.userInfo[@"NSLocalizedDescription"];
                if (message.length>0 && error.code != -1003) {
                    [StateBarMsgView getStateBarMsgView].message = message;
                }
                if (error.code == -1003) {
                    // 找不到指定域名的主机, 通常为域名解析错误
                    NSString *ipUrl = [urlStr stringByReplacingOccurrencesOfString:HEADHOST withString:IPHOST];
                    AFHTTPSessionManager *ipSession = [AFHTTPSessionManager manager];
                    ipSession.requestSerializer = [AFJSONRequestSerializer serializer];
                    ipSession.responseSerializer = [AFHTTPResponseSerializer serializer];
                    if (tokenKey.length > 0 && tokenValue.length > 0) {
                        [ipSession.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
                    }
                    [ipSession POST:ipUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if (ifAddCaches) {
                            NSFileManager *fileManager = [NSFileManager defaultManager];
                            // 创建目录
                            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
                            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
                        }
                        successBlock(responseObject);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                        failureBlock(responseData);
                        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                        LoginViewController *loginVC = [LoginViewController getLoginVC];
                        if (response.statusCode==401 && ![loginVC isVisible]) {
                            [self displayLoginViewController];
                        }
                        if (response.statusCode == 500) {
                            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
                        }
                        if (response.statusCode != 401 && response.statusCode != 500) {
                            NSString *message = @"";
                            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
                            NSRange range;
                            range = [message rangeOfString:@":"];
                            if (range.location != NSNotFound) {
                                message = [message substringFromIndex:range.location+1];
                            }
                            if (message.length>0) {
                                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
                            }
                        }
                    }];
                }
            }
        }
    }];
}

+ (void)putDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
#pragma mark - 调用此封装时,首先看有没有缓存,需要的话,先把缓存抛出
    NSString *folderPath = [NSString stringWithFormat:@"%@/AFNetworkingCaches", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%ld.aa", folderPath, [[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] hash]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (ifAddCaches) {
            cacheBlock(data);
        }
    }
#pragma mark - 正常的请求
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 通常是添加token
    if (tokenKey.length > 0 && tokenValue.length > 0) {
        [session.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
    }
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];// 设置相应内容类型
    // [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:4];
    [session PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (ifAddCaches) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            // 创建目录
            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
        }
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (error.code != -1003) {
            failureBlock(responseData);
        }
        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        LoginViewController *loginVC = [LoginViewController getLoginVC];
        if (response.statusCode==401 && ![loginVC isVisible]) {
            [self displayLoginViewController];
        }
        if (response.statusCode == 500) {
            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
        }
        if (response.statusCode != 401 && response.statusCode != 500) {
            NSString *message = @"";
            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
            NSRange range;
            range = [message rangeOfString:@":"];
            if (range.location != NSNotFound) {
                message = [message substringFromIndex:range.location+1];
            }
            if (message.length>0) {
                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
            }
            if (message.length == 0) {
                message = (NSString *)error.userInfo[@"NSLocalizedDescription"];
                if (message.length>0 && error.code != -1003) {
                    [StateBarMsgView getStateBarMsgView].message = message;
                }
                if (error.code == -1003) {
                    // 找不到指定域名的主机, 通常为域名解析错误
                    NSString *ipUrl = [urlStr stringByReplacingOccurrencesOfString:HEADHOST withString:IPHOST];
                    AFHTTPSessionManager *ipSession = [AFHTTPSessionManager manager];
                    ipSession.requestSerializer = [AFJSONRequestSerializer serializer];
                    ipSession.responseSerializer = [AFHTTPResponseSerializer serializer];
                    if (tokenKey.length > 0 && tokenValue.length > 0) {
                        [ipSession.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
                    }
                    [ipSession PUT:ipUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if (ifAddCaches) {
                            NSFileManager *fileManager = [NSFileManager defaultManager];
                            // 创建目录
                            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
                            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
                        }
                        successBlock(responseObject);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                        failureBlock(responseData);
                        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                        LoginViewController *loginVC = [LoginViewController getLoginVC];
                        if (response.statusCode==401 && ![loginVC isVisible]) {
                            [self displayLoginViewController];
                        }
                        if (response.statusCode == 500) {
                            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
                        }
                        if (response.statusCode != 401 && response.statusCode != 500) {
                            NSString *message = @"";
                            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
                            NSRange range;
                            range = [message rangeOfString:@":"];
                            if (range.location != NSNotFound) {
                                message = [message substringFromIndex:range.location+1];
                            }
                            if (message.length>0) {
                                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
                            }
                        }
                    }];
                }
            }
        }
    }];
}

+ (void)deleteDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
#pragma mark - 调用此封装时,首先看有没有缓存,需要的话,先把缓存抛出
    NSString *folderPath = [NSString stringWithFormat:@"%@/AFNetworkingCaches", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%ld.aa", folderPath, [[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] hash]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (ifAddCaches) {
            cacheBlock(data);
        }
    }
#pragma mark - 正常的请求
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 通常是添加token
    if (tokenKey.length > 0 && tokenValue.length > 0) {
        [session.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
    }
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];// 设置相应内容类型
    // [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:4];
    [session DELETE:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (ifAddCaches) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            // 创建目录
            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
        }
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (error.code != -1003) {
            failureBlock(responseData);
        }
        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        LoginViewController *loginVC = [LoginViewController getLoginVC];
        if (response.statusCode==401 && ![loginVC isVisible]) {
            [self displayLoginViewController];
        }
        if (response.statusCode == 500) {
            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
        }
        if (response.statusCode != 401 && response.statusCode != 500) {
            NSString *message = @"";
            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
            NSRange range;
            range = [message rangeOfString:@":"];
            if (range.location != NSNotFound) {
                message = [message substringFromIndex:range.location+1];
            }
            if (message.length>0) {
                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
            }
            if (message.length == 0) {
                message = (NSString *)error.userInfo[@"NSLocalizedDescription"];
                if (message.length>0 && error.code != -1003) {
                    [StateBarMsgView getStateBarMsgView].message = message;
                }
                if (error.code == -1003) {
                    // 找不到指定域名的主机, 通常为域名解析错误
                    NSString *ipUrl = [urlStr stringByReplacingOccurrencesOfString:HEADHOST withString:IPHOST];
                    AFHTTPSessionManager *ipSession = [AFHTTPSessionManager manager];
                    ipSession.requestSerializer = [AFJSONRequestSerializer serializer];
                    ipSession.responseSerializer = [AFHTTPResponseSerializer serializer];
                    if (tokenKey.length > 0 && tokenValue.length > 0) {
                        [ipSession.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
                    }
                    [ipSession DELETE:ipUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if (ifAddCaches) {
                            NSFileManager *fileManager = [NSFileManager defaultManager];
                            // 创建目录
                            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
                            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
                        }
                        successBlock(responseObject);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                        failureBlock(responseData);
                        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                        LoginViewController *loginVC = [LoginViewController getLoginVC];
                        if (response.statusCode==401 && ![loginVC isVisible]) {
                            [self displayLoginViewController];
                        }
                        if (response.statusCode == 500) {
                            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
                        }
                        if (response.statusCode != 401 && response.statusCode != 500) {
                            NSString *message = @"";
                            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
                            NSRange range;
                            range = [message rangeOfString:@":"];
                            if (range.location != NSNotFound) {
                                message = [message substringFromIndex:range.location+1];
                            }
                            if (message.length>0) {
                                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
                            }
                        }
                    }];
                }
            }
        }
    }];
}

+ (void)patchDataWithUrl:(NSString *)urlStr parameters:(id)parameters tokenKey:(NSString *)tokenKey tokenValue:(NSString *)tokenValue ifCaches:(BOOL)ifAddCaches cachesData:(void (^)(NSData *cachesData))cacheBlock success:(void (^)(NSData *successData))successBlock failure:(void (^)(NSData *failureData))failureBlock
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
#pragma mark - 调用此封装时,首先看有没有缓存,需要的话,先把缓存抛出
    NSString *folderPath = [NSString stringWithFormat:@"%@/AFNetworkingCaches", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%ld.aa", folderPath, [[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] hash]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (ifAddCaches) {
            cacheBlock(data);
        }
    }
#pragma mark - 正常的请求
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 通常是添加token
    if (tokenKey.length > 0 && tokenValue.length > 0) {
        [session.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
    }
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];// 设置相应内容类型
    // [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:4];
    [session PATCH:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (ifAddCaches) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            // 创建目录
            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
        }
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (error.code != -1003) {
            failureBlock(responseData);
        }
        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        LoginViewController *loginVC = [LoginViewController getLoginVC];
        if (response.statusCode==401 && ![loginVC isVisible]) {
            [self displayLoginViewController];
        }
        if (response.statusCode == 500) {
            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
        }
        if (response.statusCode != 401 && response.statusCode != 500) {
            NSString *message = @"";
            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
            NSRange range;
            range = [message rangeOfString:@":"];
            if (range.location != NSNotFound) {
                message = [message substringFromIndex:range.location+1];
            }
            if (message.length>0) {
                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
            }
            if (message.length == 0) {
                message = (NSString *)error.userInfo[@"NSLocalizedDescription"];
                if (message.length>0 && error.code != -1003) {
                    [StateBarMsgView getStateBarMsgView].message = message;
                }
                if (error.code == -1003) {
                    // 找不到指定域名的主机, 通常为域名解析错误
                    NSString *ipUrl = [urlStr stringByReplacingOccurrencesOfString:HEADHOST withString:IPHOST];
                    AFHTTPSessionManager *ipSession = [AFHTTPSessionManager manager];
                    ipSession.requestSerializer = [AFJSONRequestSerializer serializer];
                    ipSession.responseSerializer = [AFHTTPResponseSerializer serializer];
                    if (tokenKey.length > 0 && tokenValue.length > 0) {
                        [ipSession.requestSerializer setValue:tokenValue forHTTPHeaderField:tokenKey];
                    }
                    [ipSession PATCH:ipUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if (ifAddCaches) {
                            NSFileManager *fileManager = [NSFileManager defaultManager];
                            // 创建目录
                            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
                            [fileManager createFileAtPath:filePath contents:responseObject attributes:nil];
                        }
                        successBlock(responseObject);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                        failureBlock(responseData);
                        NSString *responseString = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                        NSHTTPURLResponse *response = (NSHTTPURLResponse *)error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                        LoginViewController *loginVC = [LoginViewController getLoginVC];
                        if (response.statusCode==401 && ![loginVC isVisible]) {
                            [self displayLoginViewController];
                        }
                        if (response.statusCode == 500) {
                            [StateBarMsgView getStateBarMsgView].message = @"服务器遇到错误，无法完成请求";
                        }
                        if (response.statusCode != 401 && response.statusCode != 500) {
                            NSString *message = @"";
                            message = [[responseString stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
                            NSRange range;
                            range = [message rangeOfString:@":"];
                            if (range.location != NSNotFound) {
                                message = [message substringFromIndex:range.location+1];
                            }
                            if (message.length>0) {
                                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:[NSString stringWithFormat:@"%@", message]] showWithBlock:nil];
                            }
                        }
                    }];
                }
            }
        }
    }];
}

static NSDate *lastDate;
+ (void)displayLoginViewController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lastDate = [NSDate dateWithTimeIntervalSince1970:0];
    });
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:lastDate];
    NSLog(@"timeInterval: %f", timeInterval);
    lastDate = date;
    if (timeInterval>5) {
        LoginViewController *loginVC = [LoginViewController getLoginVC];
        void (^block)(NSString *str) = ^(NSString *str)
        {
            //        if ([str isEqualToString:@"1"]) {
            //            [self playLockListData];
            //        }
        };
        loginVC.personBlock = block;
        loginVC.modalPresentationStyle = UIModalPresentationCustom;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginVC animated:YES completion:nil];
    }
    
}

@end
