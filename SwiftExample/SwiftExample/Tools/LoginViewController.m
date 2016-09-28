//
//  LoginViewController.m
//  TeSuFu
//
//  Created by yunPeng on 15/7/23.
//  Copyright (c) 2015年 yunPeng. All rights reserved.
//

#import "LoginViewController.h"
#import "UMSocial.h"

@interface LoginViewController ()<UITextFieldDelegate, NSURLConnectionDataDelegate, UMSocialUIDelegate>
/*!
 * @brief 登陆的手机号
 */
@property(nonatomic, retain) UITextField *phoneTextField;
/*!
 * @brief 登陆的密码
 */
@property(nonatomic, retain) UITextField *keyTextField;
/*!
 * @brief 注册的昵称
 */
@property(nonatomic, retain) UITextField *registerNameTextField;
/*!
 * @brief 提示昵称信息
 */
@property(nonatomic, retain) UILabel *warnNameLabel;
/*!
 * @brief 注册的手机号
 */
@property(nonatomic, retain) UITextField *registerPhoneTextField;
/*!
 * @brief 提示手机号信息
 */
@property(nonatomic, retain) UILabel *warnPhoneLabel;
/*!
 * @brief 注册的密码
 */
@property(nonatomic, retain) UITextField *registerKeyTextField;
/*!
 * @brief 提示密码信息
 */
@property(nonatomic, retain) UILabel *warnPasswordLabel;
/*!
 * @brief 提示验证码信息
 */
@property(nonatomic, retain) UILabel *warnTestLabel;
/*!
 * @brief 注册的验证码
 */
@property(nonatomic, retain) UITextField *registerTestTextField;
/*!
 * @brief 忘记的手机号
 */
@property(nonatomic, retain) UITextField *forgetPhoneTextField;
/*!
 * @brief 忘记的密码
 */
@property(nonatomic, retain) UITextField *forgetKeyTextField;
/*!
 * @brief 忘记的验证码
 */
@property(nonatomic, retain) UITextField *forgetTestTextField;
@property(nonatomic, retain) UIImageView *logoImage;
@property(nonatomic, retain) UIImageView *logoImage2;
@property(nonatomic, retain) UIImageView *logoImage3;
@property(nonatomic, retain) UIView *loginView;
@property(nonatomic, retain) UIView *getKeyView;
@property(nonatomic, retain) UIView *forgetView;
@property(nonatomic, retain) UIButton *getTestButton;
@property(nonatomic, retain) UIButton *forgetTestButton;
/*!
 * @brief 点击登陆, 判断密码是否正确
 */
@property(nonatomic, retain) HyLoglnButton *loginButton;
/*!
 * @brief 获取到验证码后, 点击注册时才进行请求
 */
@property(nonatomic, assign) BOOL getTestCode;
/*!
 * @brief 忘记密码获取到验证码后, 点击注册时才进行请求
 */
@property(nonatomic, assign) BOOL forgetTestCode;
/*!
 * @brief 是否已经登陆过
 */
@property(nonatomic ,assign) BOOL haveSuccessdeLogin;

@end

@implementation LoginViewController

-(BOOL)isVisible
{
    return (self.isViewLoaded && self.view.window);
}

+ (LoginViewController *) getLoginVC
{
    static LoginViewController *loginVC = nil;
    if (loginVC == nil) {
        loginVC = [[LoginViewController alloc] init];
    }
    return loginVC;
}

#pragma mark - 测试token是否存在或过期
+ (void)getMeLoginWithToken:(void (^)(BOOL result))resultBlock
{
    NSString *token = [NSString stringWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject] stringByAppendingPathComponent:@"aa2.txt"] encoding:NSUTF8StringEncoding error:nil];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    //GET me
    NSString *str = [NSString stringWithFormat:@"%@/me", HEADHOST];
    [session GET:str parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        // nil
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // token登录成功
        [JSESSIONID getJSESSIONID].token = token;
        resultBlock(YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // token失效
        if (error.code != -1003) {
            resultBlock(NO);
        }
        if (error.code == -1003) {
            NSString *ipUrl = [str stringByReplacingOccurrencesOfString:HEADHOST withString:IPHOST];
            AFHTTPSessionManager *ipSession = [AFHTTPSessionManager manager];
            ipSession.requestSerializer = [AFJSONRequestSerializer serializer];
            ipSession.responseSerializer = [AFHTTPResponseSerializer serializer];
            [ipSession.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
            [ipSession GET:ipUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                // token登录成功
                [JSESSIONID getJSESSIONID].token = token;
                resultBlock(YES);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                resultBlock(NO);
            }];
        }
    }];
    
//    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"%@/me", HEADHOST] parameters:nil tokenKey:@"Authorization" tokenValue:token ifCaches:NO cachesData:nil success:^(AFHTTPRequestOperation *operation) {
//        // token登录成功
//        [JSESSIONID getJSESSIONID].token = token;
//        resultBlock(YES);
//    } failure:^(AFHTTPRequestOperation *operation) {
//        // token失效
//        resultBlock(NO);
//    }];
}

#pragma mark - 若token过期,则从本地读取账号密码登录,并存新的token
+ (void) accountPasswordLogin:(void (^)(BOOL result))resultBlock
{
    NSString *str = [NSString stringWithFormat:@"%@/login", HEADHOST];
    NSString *accountPassword = [NSString stringWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject] stringByAppendingPathComponent:@"aa.txt"] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *parameters = nil;
    if (accountPassword.length > 11) {
    NSString *account = [accountPassword substringToIndex:11];
    NSString *password = [accountPassword substringFromIndex:11];
        parameters = @{@"mobile":account, @"password":password};
    }
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session POST:str parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultBlock(YES);
        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [JSESSIONID getJSESSIONID].token = [NSString stringWithFormat:@"%@ %@", [dict objectForKey:@"token_type"], [dict objectForKey:@"access_token"]];
        [[JSESSIONID getJSESSIONID].token writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject] stringByAppendingPathComponent:@"aa2.txt"] atomically:NO encoding:NSUTF8StringEncoding error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(NO);
    }];
    
    
//    [NetHandler postDataWithUrl:str parameters:parameters tokenKey:@"" tokenValue:@"" ifCaches:NO cachesData:nil success:^(AFHTTPRequestOperation *operation) {
//        resultBlock(YES);
//        id dict = [NSJSONSerialization JSONObjectWithData:operation.responseObject options:NSJSONReadingMutableContainers error:nil];
//        [JSESSIONID getJSESSIONID].token = [NSString stringWithFormat:@"%@ %@", [dict objectForKey:@"token_type"], [dict objectForKey:@"access_token"]];
//        [[JSESSIONID getJSESSIONID].token writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject] stringByAppendingPathComponent:@"aa2.txt"] atomically:NO encoding:NSUTF8StringEncoding error:nil];
//    } failure:^(AFHTTPRequestOperation *operation) {
//        resultBlock(NO);
//    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 注册
    [self getKey];
    // 忘记密码
//    [self forget];
    // 登陆
    [self login];
}

#pragma mark - 注册
- (void)getKey
{
    self.getTestCode = YES;
    [self.phoneTextField resignFirstResponder];
    [self.keyTextField resignFirstResponder];
    self.getKeyView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.getKeyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.getKeyView];
    
    self.logoImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH / 2.5, HEIGHT / 8, WIDTH / 5, WIDTH / 5)];
    self.logoImage2.layer.cornerRadius = 10;
    self.logoImage2.clipsToBounds = YES;
    self.logoImage2.image = [UIImage imageNamed:@"logo.png"];
//    [self.getKeyView addSubview:self.logoImage2];
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logoImage2.PART_H + self.logoImage2.Y + 8, WIDTH, 30)];
    logoLabel.text = CURRENTVERSION;
    logoLabel.textColor = [UIColor lightGrayColor];
    logoLabel.textAlignment = NSTextAlignmentCenter;
//    [self.getKeyView addSubview:logoLabel];
    ///////////////////////////////////////////////////////////////
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT/8, 48 , 30)];
    nameLabel.text = @"昵称:";
    nameLabel.textColor = [UIColor lightGrayColor];
    [self.getKeyView addSubview:nameLabel];
    self.registerNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameLabel.X + nameLabel.PART_W, nameLabel.Y, WIDTH - nameLabel.X - nameLabel.PART_W - 10, 30)];
    self.registerNameTextField.placeholder = @"必填";
    self.registerNameTextField.delegate = self;
    [self.getKeyView addSubview:self.registerNameTextField];
    self.warnNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, nameLabel.Y + nameLabel.PART_H, WIDTH - 20, 10)];
    self.warnNameLabel.textColor = [UIColor redColor];
    self.warnNameLabel.textAlignment = NSTextAlignmentLeft;
    self.warnNameLabel.font = [UIFont systemFontOfSize:8];
    [self.getKeyView addSubview:self.warnNameLabel];
    UIView *nameLineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.warnNameLabel.Y + self.warnNameLabel.PART_H, WIDTH - 20, 1)];
    nameLineView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self.getKeyView addSubview:nameLineView];
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, nameLineView.Y + nameLineView.PART_H + 25, 48 , 30)];
    if (HEIGHT<500) {
        phoneLabel.frame = CGRectMake(phoneLabel.X, nameLineView.Y + nameLineView.PART_H + 5, phoneLabel.PART_W , phoneLabel.PART_H);
    }
    phoneLabel.text = @"手机:";
    phoneLabel.textColor = [UIColor lightGrayColor];
    [self.getKeyView addSubview:phoneLabel];
    self.registerPhoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.X + phoneLabel.PART_W, phoneLabel.Y, WIDTH - phoneLabel.X - phoneLabel.PART_W - 10, 30)];
    self.registerPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.registerPhoneTextField.delegate = self;
    [self.getKeyView addSubview:self.registerPhoneTextField];
    [self.registerPhoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.warnPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, phoneLabel.Y + phoneLabel.PART_H, WIDTH - 20, 10)];
    self.warnPhoneLabel.textColor = [UIColor redColor];
    self.warnPhoneLabel.textAlignment = NSTextAlignmentLeft;
    self.warnPhoneLabel.font = [UIFont systemFontOfSize:8];
    [self.getKeyView addSubview:self.warnPhoneLabel];
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(10, self.warnPhoneLabel.Y + self.warnPhoneLabel.PART_H, WIDTH - 20, 1)];
    aView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self.getKeyView addSubview:aView];
    
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, aView.Y + aView.PART_H + 25, 48 , 30)];
    if (HEIGHT<500) {
        keyLabel.frame = CGRectMake(keyLabel.X, aView.Y + aView.PART_H + 5, keyLabel.PART_W , keyLabel.PART_H);
    }
    keyLabel.text = @"密码:";
    //    keyLabel.backgroundColor = [UIColor orangeColor];
    keyLabel.textColor = [UIColor lightGrayColor];
    [self.getKeyView addSubview:keyLabel];
    self.registerKeyTextField = [[UITextField alloc] initWithFrame:CGRectMake(keyLabel.X + keyLabel.PART_W, keyLabel.Y, WIDTH - keyLabel.X - keyLabel.PART_W - 10, 30)];
    self.registerKeyTextField.secureTextEntry = YES;
    self.registerKeyTextField.placeholder = @"6至16位数字或字母";
    self.registerKeyTextField.delegate = self;
    self.registerKeyTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.getKeyView addSubview:self.registerKeyTextField];
    UIButton *eyeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    eyeButton.frame = CGRectMake(WIDTH - 60, self.registerKeyTextField.center.y-15, 30, 30);
    [eyeButton setBackgroundImage:[UIImage imageNamed:@"eye.png"] forState:0];
    eyeButton.tag = 1080;
    [eyeButton addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.getKeyView addSubview:eyeButton];
    
    self.warnPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, keyLabel.Y + keyLabel.PART_H, WIDTH - 20, 10)];
    self.warnPasswordLabel.textColor = [UIColor redColor];
    self.warnPasswordLabel.textAlignment = NSTextAlignmentLeft;
    self.warnPasswordLabel.font = [UIFont systemFontOfSize:8];
    [self.getKeyView addSubview:self.warnPasswordLabel];
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(10, self.warnPasswordLabel.Y + self.warnPasswordLabel.PART_H, WIDTH - 20, 1)];
    bView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self.getKeyView addSubview:bView];
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, bView.Y + bView.PART_H + 25, 58, 30)];
    if (HEIGHT<500) {
        testLabel.frame = CGRectMake(testLabel.X, bView.Y + bView.PART_H + 15, testLabel.PART_W, testLabel.PART_H);
    }
    testLabel.text = @"验证码:";
    testLabel.textColor = [UIColor lightGrayColor];
#pragma mark - 过两天打开
//    [self.getKeyView addSubview:testLabel];
    self.registerTestTextField = [[UITextField alloc] initWithFrame:CGRectMake(testLabel.X + testLabel.PART_W, testLabel.Y, WIDTH - testLabel.X - testLabel.PART_W - 10 - 100, 30)];
    self.registerTestTextField.delegate = self;
    self.registerTestTextField.keyboardType = UIKeyboardTypeASCIICapable;
#pragma mark - 过两天打开
//    [self.getKeyView addSubview:self.registerTestTextField];
    self.getTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getTestButton.frame = CGRectMake(self.registerTestTextField.X + self.registerTestTextField.PART_W - 10, testLabel.center.y - 13, 110, 26);
    [self.getTestButton addTarget:self action:@selector(getTestAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.getTestButton.layer setMasksToBounds:YES];
    [self.getTestButton.layer setCornerRadius:13];
    [self.getTestButton.layer setBorderWidth:1.5];//设置边界的宽度
    //设置按钮的边界颜色
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,0,0,1});
    CGColorRef color = MAINCOLOR.CGColor;
    [self.getTestButton.layer setBorderColor:color];
    [self.getTestButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getTestButton setTitleColor:[UIColor colorWithRed:121 / 255.0 green:121 / 255.0 blue:121 / 255.0 alpha:1] forState:UIControlStateNormal];
//    [self.getTestButton setTintColor:[UIColor lightGrayColor]];
    self.getTestButton.titleLabel.font = [UIFont systemFontOfSize: 13];
#pragma mark - 过两天打开
//    [self.getKeyView addSubview:self.getTestButton];
    self.warnTestLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, testLabel.Y + testLabel.PART_H, WIDTH - 20, 10)];
    self.warnTestLabel.textColor = [UIColor redColor];
    self.warnTestLabel.textAlignment = NSTextAlignmentLeft;
    self.warnTestLabel.font = [UIFont systemFontOfSize:8];
    [self.getKeyView addSubview:self.warnTestLabel];
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(10, self.warnTestLabel.Y + self.warnTestLabel.PART_H+5, WIDTH - 20, 1)];
    cView.backgroundColor =[ UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
#pragma mark - 过两天打开
//    [self.getKeyView addSubview:cView];
    UILabel *tellRule = [[UILabel alloc] initWithFrame:CGRectMake(0, cView.Y + cView.PART_H, WIDTH, 20)];
    tellRule.text = @"6至16位数字或字母";
    tellRule.textAlignment = NSTextAlignmentCenter;
    tellRule.textColor = [UIColor lightGrayColor];
    tellRule.font = [UIFont systemFontOfSize:11];
//    [self.getKeyView addSubview:tellRule];
    UIButton *getKeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    getKeyButton.frame = CGRectMake(10, tellRule.Y + tellRule.PART_H, WIDTH - 20, 50);
    getKeyButton.backgroundColor = MAINCOLOR;
    [getKeyButton addTarget:self action:@selector(getKeyAction:) forControlEvents:UIControlEventTouchUpInside];
    [getKeyButton setTitle:@"注册" forState:UIControlStateNormal];
    [getKeyButton setTintColor:[UIColor whiteColor]];
    [getKeyButton.layer setMasksToBounds:YES];
    [getKeyButton.layer setCornerRadius:5];// button边框
    [getKeyButton.layer setBorderWidth:1.5];//设置边界的宽度
    [getKeyButton.layer setBorderColor:MAINCOLOR.CGColor];
    [self.getKeyView addSubview:getKeyButton];
    UILabel *backLoginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, getKeyButton.Y + getKeyButton.PART_H + 5, WIDTH, 5)];
//    backLoginLabel.text = @"已有账号?";
    backLoginLabel.textAlignment = NSTextAlignmentCenter;
    backLoginLabel.textColor = [UIColor lightGrayColor];
    backLoginLabel.font = [UIFont systemFontOfSize:13.5];
    [self.getKeyView addSubview:backLoginLabel];
    UIButton *backLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backLoginButton.frame = CGRectMake(10, backLoginLabel.Y + backLoginLabel.PART_H, WIDTH - 20, 50);
    [backLoginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [backLoginButton setTintColor:MAINCOLOR];
    [backLoginButton.layer setMasksToBounds:YES];
    [backLoginButton.layer setCornerRadius:10];
    [backLoginButton.layer setBorderWidth:1.5];//设置边界的宽度
    [backLoginButton.layer setBorderColor:MAINCOLOR.CGColor];
    [backLoginButton setTitle:@"去登陆" forState:UIControlStateNormal];
    [backLoginButton addTarget:self action:@selector(makeLoginUp) forControlEvents:UIControlEventTouchUpInside];
    [self.getKeyView addSubview:backLoginButton];
    
    UIButton *casualButton = [UIButton buttonWithType:UIButtonTypeSystem];
    casualButton.frame = CGRectMake(WIDTH / 3, HEIGHT - 50, WIDTH / 3, 40);
    [casualButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [casualButton setTitle:@"随便看看 >>" forState:UIControlStateNormal];
    [casualButton addTarget:self action:@selector(casualAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.getKeyView addSubview:casualButton];
}

#pragma mark - 验证码
- (void)getTestAction:(UIButton *)button
{
    NSString *str = [NSString stringWithFormat:@"%@/verification", HEADHOST];
    NSDictionary *phoneNumberDic = @{@"mobile":self.registerPhoneTextField.text, @"category": @"signup"};
    [NetHandler postDataWithUrl:str parameters:phoneNumberDic tokenKey:@"" tokenValue:@"" ifCaches:NO cachesData:nil success:^(NSData *successData) {
        self.getTestCode = YES;
        [self startTime:self.getTestButton];
    } failure:^(NSData *failureData) {
    }];
}
#pragma mark GCD实现验证码倒计时
- (void)startTime:(UIButton *)button
{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        }else{
            // int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - 点击注册
- (void)getKeyAction:(UIButton *)button
{
    if (self.getTestCode) {
        button.userInteractionEnabled = NO;
        self.warnNameLabel.text = @"";
        self.warnPhoneLabel.text = @"";
        self.warnPasswordLabel.text = @"";
        self.warnTestLabel.text = @"";
        NSString *str = [NSString stringWithFormat:@"%@/signup", HEADHOST];
        NSDictionary *parameters = @{@"name":self.registerNameTextField.text,@"mobile":self.registerPhoneTextField.text,@"password":self.registerKeyTextField.text, @"code":self.registerTestTextField.text};
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.requestSerializer = [AFJSONRequestSerializer serializer];
        session.responseSerializer = [AFHTTPResponseSerializer serializer];
        [session POST:str parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            button.userInteractionEnabled = YES;
            self.warnNameLabel.text = @"";
            self.warnPhoneLabel.text = @"";
            self.warnPasswordLabel.text = @"";
            self.warnTestLabel.text = @"";
            [self makeLoginUp];
            self.phoneTextField.text = self.registerPhoneTextField.text;
            self.keyTextField.text = self.registerKeyTextField.text;
            MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finish){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [popupView hide];
                });
            };
            [StateBarMsgView getStateBarMsgView].message = @"注册成功";
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            button.userInteractionEnabled = YES;
            NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (responseData.length>0) {
                id dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
                self.warnNameLabel.text = [dict objectForKey:@"name"];
                self.warnPhoneLabel.text = [dict objectForKey:@"mobile"];
                self.warnPasswordLabel.text = [dict objectForKey:@"password"];
                self.warnTestLabel.text = [dict objectForKey:@"code"];
            }
            if (responseData.length==0) {
                NSString *message = (NSString *)error.userInfo[@"NSLocalizedDescription"];
                if (message.length>0 && error.code != -1003) {
                    [StateBarMsgView getStateBarMsgView].message = message;
                }
                if (error.code == -1003) {
                    // 找不到指定域名的主机, 通常为域名解析错误
                    NSString *ipUrl = [str stringByReplacingOccurrencesOfString:HEADHOST withString:IPHOST];
                    AFHTTPSessionManager *ipSession = [AFHTTPSessionManager manager];
                    ipSession.requestSerializer = [AFJSONRequestSerializer serializer];
                    ipSession.responseSerializer = [AFHTTPResponseSerializer serializer];
                    [ipSession POST:ipUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        button.userInteractionEnabled = YES;
                        self.warnNameLabel.text = @"";
                        self.warnPhoneLabel.text = @"";
                        self.warnPasswordLabel.text = @"";
                        self.warnTestLabel.text = @"";
                        [self makeLoginUp];
                        self.phoneTextField.text = self.registerPhoneTextField.text;
                        self.keyTextField.text = self.registerKeyTextField.text;
                        MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finish){
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [popupView hide];
                            });
                        };
                        [[[MMAlertView alloc] initWithConfirmTitle:@"注册成功" detail:@""] showWithBlock:completeBlock];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        button.userInteractionEnabled = YES;
                        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                        if (responseData.length>0) {
                            id dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
                            self.warnNameLabel.text = [dict objectForKey:@"name"];
                            self.warnPhoneLabel.text = [dict objectForKey:@"mobile"];
                            self.warnPasswordLabel.text = [dict objectForKey:@"password"];
                            self.warnTestLabel.text = [dict objectForKey:@"code"];
                        }
                        if (responseData.length==0) {
                            NSString *message = (NSString *)error.userInfo[@"NSLocalizedDescription"];
                            if (message.length>0 && error.code != -1003) {
                                [StateBarMsgView getStateBarMsgView].message = message;
                            }
                        }
                    }];
                }
            }
        }];
    }
}

#pragma mark - 点击确认提交
- (void)makeSureAction
{
#pragma mark 记得改这个地方加验证成功提示
    if (self.forgetTestCode) {
        NSString *str = [NSString stringWithFormat:@"%@/app/reg?serialNum=10001&userAccount=%@&password=%@&mobileCode=%@", PICSTR, self.forgetPhoneTextField.text, self.forgetKeyTextField.text, self.forgetTestTextField.text];
    }
}

#pragma mark - 忘记密码
- (void)forget
{
    self.forgetTestCode = NO;
//    [self.photoTextField resignFirstResponder];
//    [self.keyTextField resignFirstResponder];
    self.forgetView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.forgetView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.forgetView];
    
    self.logoImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH / 2.5, HEIGHT / 8, WIDTH / 5, WIDTH / 5)];
    self.logoImage3.layer.cornerRadius = 10;
    self.logoImage3.clipsToBounds = YES;
    self.logoImage3.image = [UIImage imageNamed:@"logo.png"];
    [self.forgetView addSubview:self.logoImage3];
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logoImage3.PART_H + self.logoImage3.Y + 8, WIDTH, 30)];
    logoLabel.text = CURRENTVERSION;
    logoLabel.textColor = [UIColor lightGrayColor];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    [self.forgetView addSubview:logoLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, logoLabel.Y + logoLabel.PART_H + HEIGHT / 20, 48 , 30)];
    if (HEIGHT<500) {
        phoneLabel.frame = CGRectMake(10, logoLabel.Y + logoLabel.PART_H, 48 , 30);
    }
    phoneLabel.text = @"手机:";
    phoneLabel.textColor = [UIColor lightGrayColor];
    [self.forgetView addSubview:phoneLabel];
    self.forgetPhoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.X + phoneLabel.PART_W, phoneLabel.Y, WIDTH - phoneLabel.X - phoneLabel.PART_W - 10, 30)];
    self.forgetPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.forgetPhoneTextField.delegate = self;
    [self.forgetView addSubview:self.forgetPhoneTextField];
    [self.forgetPhoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(10, phoneLabel.Y + phoneLabel.PART_H, WIDTH - 20, 1)];
    aView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self.forgetView addSubview:aView];
    
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, aView.Y + aView.PART_H + 25, 48 , 30)];
    if (HEIGHT<500) {
        keyLabel.frame = CGRectMake(10, aView.Y + aView.PART_H + 5, 48 , 30);
    }
    keyLabel.text = @"新密码:";
    keyLabel.textColor = [UIColor lightGrayColor];
    [self.forgetView addSubview:keyLabel];
    self.forgetKeyTextField = [[UITextField alloc] initWithFrame:CGRectMake(keyLabel.X + keyLabel.PART_W, keyLabel.Y, WIDTH - keyLabel.X - keyLabel.PART_W - 10, 30)];
    self.forgetKeyTextField.delegate = self;
    self.forgetKeyTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.forgetView addSubview:self.forgetKeyTextField];
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(10, keyLabel.Y + keyLabel.PART_H, WIDTH - 20, 1)];
    bView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self.forgetView addSubview:bView];
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, bView.Y + bView.PART_H + 25, 58, 30)];
    if (HEIGHT<500) {
        testLabel.frame = CGRectMake(testLabel.X, bView.Y + bView.PART_H + 5, testLabel.PART_W, testLabel.PART_H);
    }
    testLabel.text = @"验证码:";
    testLabel.textColor = [UIColor lightGrayColor];
    [self.forgetView addSubview:testLabel];
    self.forgetTestTextField = [[UITextField alloc] initWithFrame:CGRectMake(testLabel.X + testLabel.PART_W, testLabel.Y, WIDTH - testLabel.X - testLabel.PART_W - 10 - 100, 30)];
    self.forgetTestTextField.delegate = self;
    self.forgetTestTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.forgetView addSubview:self.forgetTestTextField];
    self.forgetTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetTestButton.frame = CGRectMake(self.forgetTestTextField.X + self.forgetTestTextField.PART_W - 10, testLabel.center.y - 16, 110, 28);
    [self.forgetTestButton addTarget:self action:@selector(getForgetTestAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetTestButton setBackgroundImage:[UIImage imageNamed:@"oval.png"] forState:UIControlStateNormal];
    [self.forgetTestButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.forgetTestButton setTitleColor:[UIColor colorWithRed:121 / 255.0 green:121 / 255.0 blue:121 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.forgetTestButton.titleLabel.font = [UIFont systemFontOfSize: 13];
    [self.forgetView addSubview:self.forgetTestButton];
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(10, testLabel.Y + testLabel.PART_H, WIDTH - 20, 1)];
    cView.backgroundColor =[ UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self.forgetView addSubview:cView];
    
    UIButton *getKeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    getKeyButton.frame = CGRectMake(10, cView.Y + + cView.PART_H + 20, WIDTH - 20, 50);
    getKeyButton.backgroundColor = MAINCOLOR;
    [getKeyButton addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
    [getKeyButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [getKeyButton setTintColor:[UIColor whiteColor]];
    [self.forgetView addSubview:getKeyButton];
    UILabel *backLoginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, getKeyButton.Y + getKeyButton.PART_H + 5, WIDTH, 5)];
    //    backLoginLabel.text = @"已有账号?";
    backLoginLabel.textAlignment = NSTextAlignmentCenter;
    backLoginLabel.textColor = [UIColor lightGrayColor];
    backLoginLabel.font = [UIFont systemFontOfSize:13.5];
    [self.getKeyView addSubview:backLoginLabel];
    UIButton *backLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backLoginButton.frame = CGRectMake(10, backLoginLabel.Y + backLoginLabel.PART_H, WIDTH - 20, 50);
    [backLoginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [backLoginButton setTintColor:[UIColor blackColor]];
    [backLoginButton setTitle:@"去登陆" forState:UIControlStateNormal];
    [backLoginButton addTarget:self action:@selector(makeLoginUp) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetView addSubview:backLoginButton];
    
    UIButton *casualButton = [UIButton buttonWithType:UIButtonTypeSystem];
    casualButton.frame = CGRectMake(WIDTH / 3, HEIGHT - 50, WIDTH / 3, 40);
    [casualButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [casualButton setTitle:@"随便看看 >>" forState:UIControlStateNormal];
    [casualButton addTarget:self action:@selector(casualAction) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetView addSubview:casualButton];
}

#pragma mark - 忘记密码验证码
- (void)getForgetTestAction:(UIButton *)button
{
    NSString *str = [NSString stringWithFormat:@"%@/verification", HEADHOST];
    NSDictionary *phoneNumberDic = @{@"mobile":self.registerPhoneTextField.text, @"category": @"forget"};
    [NetHandler postDataWithUrl:str parameters:phoneNumberDic tokenKey:@"" tokenValue:@"" ifCaches:NO cachesData:nil success:^(NSData *successData) {
        [self startTime:button];
    } failure:^(NSData *failureData) {
    }];
}

#pragma mark - 登陆
- (void)login
{
    self.loginView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginView];
    
    self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 88)];
    self.logoImage.clipsToBounds = YES;
    self.logoImage.image = [UIImage imageNamed:@"welcome.png"];
//    [self.loginView addSubview:self.logoImage];
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logoImage.PART_H + self.logoImage.Y + 8, WIDTH, 30)];
    logoLabel.text = CURRENTVERSION;
    logoLabel.textColor = [UIColor lightGrayColor];
    logoLabel.textAlignment = NSTextAlignmentCenter;
//    [self.loginView addSubview:logoLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT / 4, 48 , 30)];
    phoneLabel.text = @"手机:";
    phoneLabel.textColor = [UIColor lightGrayColor];
    [self.loginView addSubview:phoneLabel];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.X + phoneLabel.PART_W, phoneLabel.Y, WIDTH - phoneLabel.X - phoneLabel.PART_W - 10, 30)];
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.delegate = self;
    [self.loginView addSubview:self.phoneTextField];
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(10, phoneLabel.Y + phoneLabel.PART_H+10, WIDTH - 20, 1)];
    aView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self.loginView addSubview:aView];
    
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, aView.Y + aView.PART_H + 25, 48 , 30)];
    keyLabel.text = @"密码:";
    keyLabel.textColor = [UIColor lightGrayColor];
    [self.loginView addSubview:keyLabel];
    self.keyTextField = [[UITextField alloc] initWithFrame:CGRectMake(keyLabel.X + keyLabel.PART_W, keyLabel.Y, WIDTH - keyLabel.X - keyLabel.PART_W - 10, 30)];
    self.keyTextField.placeholder = @"6至16位数字或字母";
    // 读取本地手机号和密码
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
    // 拼接上要存储的文件路径(前面自动加上/),如果没有此文件系统会自动创建一个
    NSString *fullPath = [documentsPath stringByAppendingPathComponent:@"aa.txt"];
    NSString *userPassword = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
    if (userPassword.length > 11) {
        NSString *phoneNumber = [userPassword substringToIndex:11];
        self.phoneTextField.text = phoneNumber;
        NSString *password = [userPassword substringFromIndex:11];
        self.keyTextField.text  = password;
    }
    self.keyTextField.secureTextEntry = YES;
    self.keyTextField.delegate = self;
    self.keyTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.loginView addSubview:self.keyTextField];
    UIButton *eyeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    eyeButton.frame = CGRectMake(WIDTH - 60, self.keyTextField.center.y-15, 30, 30);
    [eyeButton setBackgroundImage:[UIImage imageNamed:@"eye.png"] forState:0];
    eyeButton.tag = 1081;
    [eyeButton addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView addSubview:eyeButton];
    
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(10, keyLabel.Y + keyLabel.PART_H+10, WIDTH - 20, 1)];
    bView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self.loginView addSubview:bView];
    
    self.loginButton = [[HyLoglnButton alloc] initWithFrame:CGRectMake(10, bView.Y + bView.PART_H + 25, WIDTH - 20, 50)];
    self.loginButton.backgroundColor = MAINCOLOR;
    [self.loginButton.layer setMasksToBounds:YES];
    [self.loginButton.layer setCornerRadius:5];
    [self.loginButton.layer setBorderWidth:1.5];//设置边界的宽度
    [self.loginButton.layer setBorderColor:MAINCOLOR.CGColor];
    [self.loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginView addSubview:self.loginButton];
    // 忘记密码
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetButton.frame = CGRectMake(WIDTH / 3, self.loginButton.Y + self.loginButton.PART_H, WIDTH / 3, 40);
    [forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetButton setTintColor:GRAY121COLOR];
    [forgetButton addTarget:self action:@selector(makeForgetUp) forControlEvents:UIControlEventTouchUpInside];
//    [self.loginView addSubview:forgetButton];
    
    UIButton *getButton = [UIButton buttonWithType:UIButtonTypeSystem];
    getButton.frame = CGRectMake(10, self.loginButton.Y + self.loginButton.PART_H + 10, WIDTH - 20, 50);
    getButton.clipsToBounds = YES;;
    getButton.layer.cornerRadius = 5;
    [getButton.layer setBorderWidth:1.5];//设置边界的宽度
    [getButton.layer setBorderColor:MAINCOLOR.CGColor];
    [getButton setTitle:@"注册" forState:UIControlStateNormal];
    [getButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [getButton addTarget:self action:@selector(makeKeyUp) forControlEvents:UIControlEventTouchUpInside];
    [getButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.loginView addSubview:getButton];
    
    CGFloat buttonWidth = 44;
    // 添加一个在审核期间隐藏第三方登录的设置
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyy-MM-dd";
    NSString *currentDate = [formatter1 stringFromDate:[NSDate date]];
    UIView *thirdLineView = [[UIView alloc] initWithFrame:CGRectMake(10, HEIGHT-50-buttonWidth-10-20, WIDTH - 20, 1)];
    if (HEIGHT < 500) {
        thirdLineView.frame = CGRectMake(thirdLineView.X, thirdLineView.Y + 20, thirdLineView.PART_W, thirdLineView.PART_H);
    }
    thirdLineView.backgroundColor = GRAY121COLOR;
    thirdLineView.alpha = 0.3;
    if ([currentDate compare:CHECKPASSTIME]==1) {
//        [self.loginView addSubview:thirdLineView];
    }
    UILabel *thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-80, thirdLineView.Y-9.5, 160, 20)];
    thirdLabel.backgroundColor = [UIColor whiteColor];
    thirdLabel.font = [UIFont systemFontOfSize:12];
    thirdLabel.textColor = GRAY121COLOR;
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    thirdLabel.text = @"使用第三方账号登录";
    if ([currentDate compare:CHECKPASSTIME]==1) {
//        [self.loginView addSubview:thirdLabel];
    }
    
    UIButton *weiChat = [UIButton buttonWithType:UIButtonTypeCustom];
    weiChat.frame = CGRectMake((WIDTH/2-buttonWidth/2)/2-buttonWidth/2, HEIGHT-50-buttonWidth-10, buttonWidth, buttonWidth);
    if (HEIGHT < 500) {
        weiChat.frame = CGRectMake(weiChat.X, weiChat.Y + 10, weiChat.PART_W, weiChat.PART_H);
    }
    [weiChat addTarget:self action:@selector(weiChatAction) forControlEvents:UIControlEventTouchUpInside];
    [weiChat.layer setMasksToBounds:YES];
    [weiChat.layer setCornerRadius:buttonWidth/2];
    [weiChat.layer setBorderWidth:1];
    [weiChat.layer setBorderColor:[UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:0.3].CGColor];
    [weiChat setImage:[UIImage imageNamed:@"weiChat.png"] forState:UIControlStateNormal];
    weiChat.imageEdgeInsets = UIEdgeInsetsMake(5,5,5,5);
    if ([currentDate compare:CHECKPASSTIME]==1) {
//        [self.loginView addSubview:weiChat];
    }
    UIButton *qq = [UIButton buttonWithType:UIButtonTypeCustom];
    qq.frame = CGRectMake(WIDTH/2-buttonWidth/2, weiChat.Y, buttonWidth, buttonWidth);
    [qq addTarget:self action:@selector(qqAction) forControlEvents:UIControlEventTouchUpInside];
    [qq.layer setMasksToBounds:YES];
    [qq.layer setCornerRadius:buttonWidth/2];
    [qq.layer setBorderWidth:1];
    [qq.layer setBorderColor:[UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:0.3].CGColor];
    [qq setImage:[UIImage imageNamed:@"qq.png"] forState:UIControlStateNormal];
    qq.imageEdgeInsets = UIEdgeInsetsMake(6,6,6,6);
    if ([currentDate compare:CHECKPASSTIME]==1) {
//        [self.loginView addSubview:qq];
    }
    UIButton *weiBo = [UIButton buttonWithType:UIButtonTypeCustom];
    weiBo.frame = CGRectMake((WIDTH- qq.X- qq.PART_W)/2 + WIDTH/2, weiChat.Y, buttonWidth, buttonWidth);
    [weiBo addTarget:self action:@selector(weiBoAction) forControlEvents:UIControlEventTouchUpInside];
    [weiBo.layer setMasksToBounds:YES];
    [weiBo.layer setCornerRadius:buttonWidth/2];
    [weiBo.layer setBorderWidth:1];
    [weiBo.layer setBorderColor:[UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:0.3].CGColor];
    [weiBo setImage:[UIImage imageNamed:@"weiBo.png"] forState:UIControlStateNormal];
    weiBo.imageEdgeInsets = UIEdgeInsetsMake(5,5,5,5);
    if ([currentDate compare:CHECKPASSTIME]==1) {
//        [self.loginView addSubview:weiBo];
    }
}
#pragma mark - 把注册页面拿到最上方
- (void)makeKeyUp
{
    [self.view bringSubviewToFront:self.getKeyView];
}

- (void)makeForgetUp
{
    [self.view bringSubviewToFront:self.forgetView];
}

- (void)makeLoginUp
{
    [self.view bringSubviewToFront:self.loginView];
}
#pragma mark - 随便看看
- (void)casualAction
{
    [self dismissModalViewControllerAnimated:YES];
//    [self removeFromParentViewController];
//    [self.view removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneTextField resignFirstResponder];
    [self.keyTextField resignFirstResponder];
    [self.registerNameTextField resignFirstResponder];
    [self.registerPhoneTextField resignFirstResponder];
    [self.registerKeyTextField resignFirstResponder];
    [self.registerTestTextField resignFirstResponder];
    [self.forgetPhoneTextField resignFirstResponder];
    [self.forgetKeyTextField resignFirstResponder];
    [self.forgetTestTextField resignFirstResponder];
}

#pragma mark - 获取登录信息
- (void)loginAction:(HyLoglnButton *)button
{
    NSString *str = [NSString stringWithFormat:@"%@/login", HEADHOST];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text, @"mobile", self.keyTextField.text, @"password", nil];
//    [NetHandler postDataWithUrl:str parameters:parameters tokenKey:@"" tokenValue:@"" ifCaches:NO cachesData:nil success:^(AFHTTPRequestOperation *operation) {
//    } failure:^(AFHTTPRequestOperation *operation) {
//    }];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session POST:str parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [button ExitAnimationCompletion:^{
            self.haveSuccessdeLogin = YES;
            NSString *str = [NSString stringWithFormat:@"%@%@", self.phoneTextField.text, self.keyTextField.text];
            NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
            NSString *fullPath = [documentsPath stringByAppendingPathComponent:@"aa.txt"];// 存储用户名密码的路径
            NSString *fullPath2 = [documentsPath stringByAppendingPathComponent:@"aa2.txt"];// 存储token的路径
            [str writeToFile:fullPath atomically:NO encoding:NSUTF8StringEncoding error:nil];
            [JSESSIONID getJSESSIONID].token = [NSString stringWithFormat:@"%@ %@", [responseObject objectForKey:@"token_type"], [responseObject objectForKey:@"access_token"]];
            [self casualAction];
            if (self.personBlock != nil) {
                self.personBlock(@"1");
            }
            [[JSESSIONID getJSESSIONID].token writeToFile:fullPath2 atomically:NO encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"登陆成功%@", responseObject);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != -1003) {
            [button ErrorRevertAnimationCompletion:nil];
        }
        NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (responseData>0) {
            NSString *message = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
            message = [[message stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
            NSRange range;
            range = [message rangeOfString:@":"];
            if (range.location != NSNotFound) {
                message = [message substringFromIndex:range.location+1];
            }
            if (message.length>0) {
                [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:message] showWithBlock:nil];
            }
            return;
        }
        if (responseData.length==0) {
            NSString *message = (NSString *)error.userInfo[@"NSLocalizedDescription"];
            if (message.length>0 && error.code != -1003) {
                [StateBarMsgView getStateBarMsgView].message = message;
            }
            if (error.code == -1003) {
                // 找不到指定域名的主机, 通常为域名解析错误
                NSString *ipUrl = [str stringByReplacingOccurrencesOfString:HEADHOST withString:IPHOST];
                AFHTTPSessionManager *ipSession = [AFHTTPSessionManager manager];
                ipSession.requestSerializer = [AFJSONRequestSerializer serializer];
                ipSession.responseSerializer = [AFJSONResponseSerializer serializer];
                [ipSession POST:ipUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [button ExitAnimationCompletion:^{
                        self.haveSuccessdeLogin = YES;
                        NSString *str = [NSString stringWithFormat:@"%@%@", self.phoneTextField.text, self.keyTextField.text];
                        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
                        NSString *fullPath = [documentsPath stringByAppendingPathComponent:@"aa.txt"];// 存储用户名密码的路径
                        NSString *fullPath2 = [documentsPath stringByAppendingPathComponent:@"aa2.txt"];// 存储token的路径
                        [str writeToFile:fullPath atomically:NO encoding:NSUTF8StringEncoding error:nil];
                        [JSESSIONID getJSESSIONID].token = [NSString stringWithFormat:@"%@ %@", [responseObject objectForKey:@"token_type"], [responseObject objectForKey:@"access_token"]];
                        [self casualAction];
                        if (self.personBlock != nil) {
                            self.personBlock(@"1");
                        }
                        [[JSESSIONID getJSESSIONID].token writeToFile:fullPath2 atomically:NO encoding:NSUTF8StringEncoding error:nil];
                        NSLog(@"登陆成功%@", responseObject);
                    }];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [button ErrorRevertAnimationCompletion:nil];
                    NSData *responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                    if (responseData>0) {
                        NSString *message = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
                        message = [[message stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
                        NSRange range;
                        range = [message rangeOfString:@":"];
                        if (range.location != NSNotFound) {
                            message = [message substringFromIndex:range.location+1];
                        }
                        if (message.length>0) {
                            [[[MMAlertView alloc] initWithConfirmTitle:@"错误" detail:message] showWithBlock:nil];
                        }
                        return;
                    }
                    if (responseData.length==0) {
                        NSString *message = (NSString *)error.userInfo[@"NSLocalizedDescription"];
                        if (message.length>0 && error.code != -1003) {
                            [StateBarMsgView getStateBarMsgView].message = message;
                        }
                    }
                }];
            }
        }
    }];
    [self.phoneTextField resignFirstResponder];
    [self.keyTextField resignFirstResponder];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
    }
    self.getTestButton.userInteractionEnabled = textField.text.length == 11;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    self.loginView.frame = CGRectMake(0, - HEIGHT / 8 + 30, WIDTH, HEIGHT + HEIGHT / 8 - 30);
    self.getKeyView.frame = CGRectMake(0, - HEIGHT / 8 + 30, WIDTH, HEIGHT + HEIGHT / 8 - 30);
    self.forgetView.frame = CGRectMake(0, - HEIGHT / 8 + 30, WIDTH, HEIGHT + HEIGHT / 8 - 30);
}

#pragma mark - 当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.loginView.frame = self.view.bounds;
    self.getKeyView.frame = self.view.bounds;
    self.forgetView.frame = self.view.bounds;
}

#pragma mark - 微信登录
- (void)weiChatAction
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
//            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//            NSLog(@"\nusername = %@,\n\n usid = %@,\n\n token = %@,\n\n iconUrl = %@,\n\n unionId = %@,\n\n thirdPlatformUserProfile = %@,\n\n thirdPlatformResponse = %@ \n\n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//            [[[MMAlertView alloc] initWithConfirmTitle:@"获得微信登录授权" detail:[NSString stringWithFormat:@"昵称:%@\n openid:%@\n unionId:%@\n accessToken:%@\n 头像:%@",snsAccount.userName,snsAccount.usid,snsAccount.unionId,snsAccount.accessToken,snsAccount.iconURL]]showWithBlock:nil];
            
            NSNumber *gender = [NSNumber numberWithInteger:0];
            if ([[response.thirdPlatformUserProfile objectForKey:@"sex"] integerValue] ==1) {
                gender = [NSNumber numberWithInteger:1];
            }
            if ([[response.thirdPlatformUserProfile objectForKey:@"sex"] integerValue] ==2) {
                gender = [NSNumber numberWithInteger:2];
            }
            NSDictionary *thirdInfo = @{@"name":snsAccount.userName, @"id":snsAccount.usid, @"from":@"wechat",@"gender":gender,@"avatar":snsAccount.iconURL};
            [self thirdLogin:thirdInfo];
        }
    });
    if ([snsPlatform.platformName isEqualToString:UMShareToWechatSession]) {
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession completion:^(UMSocialResponseEntity *respose){
            NSLog(@"get openid  response is %@",respose);
        }];
    }
    
}

#pragma mark - QQ登录
- (void)qqAction
{
    //此处调用授权的方法,你可以把下面的platformName 替换成 UMShareToSina,UMShareToTencent等
    NSString *platformName = UMShareToQzone;
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        // 获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
//            NSLog(@"username is %@, uid is %@, token is %@, iconUrl is %@, thirdPlatformResponse = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, response.thirdPlatformUserProfile);
//            [[[MMAlertView alloc] initWithConfirmTitle:@"获得QQ登录授权" detail:[NSString stringWithFormat:@"昵称:%@\n userid:%@\n token:%@\n 头像:%@",snsAccount.userName,snsAccount.usid, snsAccount.accessToken,snsAccount.iconURL]]showWithBlock:nil];
            
            NSNumber *gender = [NSNumber numberWithInteger:0];
            if ([[response.thirdPlatformUserProfile objectForKey:@"gender"] isEqualToString:@"男"]) {
                gender = [NSNumber numberWithInteger:1];
            }
            if ([[response.thirdPlatformUserProfile objectForKey:@"gender"] isEqualToString:@"女"]) {
                gender = [NSNumber numberWithInteger:2];
            }
            NSDictionary *thirdInfo = @{@"name":snsAccount.userName, @"id":snsAccount.usid, @"from":@"qq",@"gender":gender,@"avatar":snsAccount.iconURL};
            [self thirdLogin:thirdInfo];
        }
        //这里可以获取到腾讯微博openid,Qzone的token等
        /*
         if ([platformName isEqualToString:UMShareToTencent]) {
         [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
         NSLog(@"get openid  response is %@",respose);
         }];
         }
         */
    });
}
#pragma mark - 微博登录
- (void)weiBoAction
{
    //此处调用授权的方法,你可以把下面的platformName 替换成 UMShareToSina,UMShareToTencent等
    NSString *platformName = UMShareToSina;
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        // 获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
//            NSLog(@"username is %@, uid is %@, token is %@, iconUrl is %@, thirdPlatformResponse = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL,response.thirdPlatformUserProfile);
//            [[[MMAlertView alloc] initWithConfirmTitle:@"获得微博登录授权" detail:[NSString stringWithFormat:@"昵称:%@\n userid:%@\n token:%@\n 头像:%@",snsAccount.userName,snsAccount.usid, snsAccount.accessToken,snsAccount.iconURL]]showWithBlock:nil];
            
            NSNumber *gender = [NSNumber numberWithInteger:0];
            if ([[response.thirdPlatformUserProfile valueForKey:@"gender"] isEqualToString:@"m"]) {
                gender = [NSNumber numberWithInteger:1];
            }
            if ([[response.thirdPlatformUserProfile valueForKey:@"gender"] isEqualToString:@"f"]) {
                gender = [NSNumber numberWithInteger:2];
            }
            NSDictionary *thirdInfo = @{@"name":snsAccount.userName, @"id":snsAccount.usid, @"from":@"weibo",@"gender":gender,@"avatar":snsAccount.iconURL};
            [self thirdLogin:thirdInfo];
        }
        //这里可以获取到腾讯微博openid,Qzone的token等
        /*
         if ([platformName isEqualToString:UMShareToTencent]) {
         [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
         NSLog(@"get openid  response is %@",respose);
         }];
         }
         */
    });
}

- (void)thirdLogin:(NSDictionary *)thirdInfo
{
    NSString *str = [NSString stringWithFormat:@"%@/access", HEADHOST];
    [NetHandler postDataWithUrl:str parameters:thirdInfo tokenKey:@"Authorization" tokenValue:[JSESSIONID getJSESSIONID].token ifCaches:NO cachesData:nil success:^(NSData *successData) {
        self.haveSuccessdeLogin = YES;
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
        NSString *fullPath2 = [documentsPath stringByAppendingPathComponent:@"aa2.txt"];// 存储token的路径
        [self casualAction];
        id dict = [NSJSONSerialization JSONObjectWithData:successData options:NSJSONReadingMutableContainers error:nil];
        [JSESSIONID getJSESSIONID].token = [NSString stringWithFormat:@"%@ %@", [dict objectForKey:@"token_type"], [dict objectForKey:@"access_token"]];
        if (self.personBlock != nil) {
            self.personBlock(@"1");
        }
        [[JSESSIONID getJSESSIONID].token writeToFile:fullPath2 atomically:NO encoding:NSUTF8StringEncoding error:nil];
    } failure:^(NSData *failureData) {
    }];
}

- (void)eyeAction:(UIButton *)button
{
    if (button.tag == 1080) {
        self.registerKeyTextField.secureTextEntry = !self.registerKeyTextField.secureTextEntry;
        UIImage *image = self.registerKeyTextField.secureTextEntry?[UIImage imageNamed:@"eye.png"]:[UIImage imageNamed:@"shutEye.png"];
        [button setBackgroundImage:image forState:0];
    }
    if (button.tag == 1081) {
        self.keyTextField.secureTextEntry = !self.keyTextField.secureTextEntry;
        UIImage *image = self.keyTextField.secureTextEntry?[UIImage imageNamed:@"eye.png"]:[UIImage imageNamed:@"shutEye.png"];
        [button setBackgroundImage:image forState:0];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
