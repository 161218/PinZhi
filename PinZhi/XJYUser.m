
//
//  XJYUser.m
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "XJYUser.h"
#import "AFHTTPRequestOperationManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "globalService.h"
#import "macro.h"

typedef void(^SuccessBlock)(NSDictionary *result);
typedef void(^FailureBlock)(NSError* error);

@implementation XJYUser

- (id)init
{
    self = [super init];
    
    if (self) {
        _isLogin = NO;
        NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
        NSData *userData = [mySettingData objectForKey:@"userData"];
        _userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        if (_userInfo) {
            _isLogin = YES;
        }
    }
    return self;
}

- (void)checkLoginStatus {
    ;
}

-(void)updateUserInfo: (XJYUserEntity *)userEntity{
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    NSData *userData =  [NSKeyedArchiver archivedDataWithRootObject:userEntity];
    _isLogin = YES;
    [mySettingData setObject:userData forKey:@"userData"];
}

-(void)loginSuccessWithUserInfo:(XJYUserEntity *)userInfo {
    ;
}

- (void)loginWithUsername:(NSString *)name password:(NSString *)password captCode:(NSString *)captCode captKey:(NSString *)captKey loadingInView:(UIView *)view success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    [params setValue:@"0" forKey:@"ishttps"];
//    [params setValue:name forKey:@"username"];
    NSString *strPasswd=[self MD5:password];
    [params setValue:strPasswd forKey:@"passwd"];
//    [params setValue:[UIDevice alloc].name forKey:@"minfo"];
    //params = [GlobalService generateSystemParamsWithApiParams:params];
//    [params setValue:@"1" forKey:@"ishttps"];
    [params setValue:name forKey:@"mobile"];
    //[params setValue:[GlobalService base64StringFromText: [GlobalService MD5:password]] forKey:@"passwd"];
//    [params setValue:[UIDevice alloc].name forKey:@"minfo"];
//    [params setValue:@"2" forKey:@"platform"];
//    [params setValue:@"0" forKey:@"flag"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //NSString *rurl = [@"http://lotus.f2e.mogujie.org/mock/nmapi%2Fnow%2Fv10%2Fproject%2Flist" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *rurl = [NSString stringWithFormat:@"%@s=/Api/User/login",AddUrl];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
//    [manager POST:rurl parameters:params success:^
//     (AFHTTPRequestOperation *operation, NSDictionary *result){
//         NSNumber *code = [result valueForKeyPath:@"status.code"];
//         NSNumber *code = [result valueForKeyPath:@"status.code"];
//         NSString *msg = [result valueForKeyPath:@"status.msg"];
//         NSDictionary *jsonResult = [result valueForKeyPath:@"data"];
//         if(!jsonResult || ![jsonResult isKindOfClass:[NSDictionary class]] || (![code  isEqualToNumber:([NSNumber numberWithInt:1000])]))
//         {
//             if ([code  isEqualToNumber:([NSNumber numberWithInt:1022])])
//             {
//             }
//             else
//             {
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"服务繁忙" message:msg delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles:nil, nil];
//                 [alertView show];
//             }
//         }
//         else{
//             success(jsonResult);
//         }
//         //self.login(dic); // 像是函数那样调用这个 block，调用之必须确保 self.login block 已经被定义（这里是在 login.m 定义。）
//     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         UIAlertView *loginErrorView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"服务器不在银河系" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//         [loginErrorView show];
//         NSLog(@"request project list error = %@",[error localizedDescription]);
//     }];
//    
}
- (void)relogin {
    ;
}

-(void)setUserInfo:(XJYUserEntity *)userInfo {
    ;
}

-(void)logout {
    ;
}

-(void)handleUserTokenExpired:(void (^)())complete{
    ;
}

+ (XJYUser *)shareInstance
{
    static dispatch_once_t onceToken;
    static XJYUser *user = nil;
    dispatch_once(&onceToken, ^{
        user = [[XJYUser alloc] init];
    });
    return user;
}

-(void)refreshUserTokenSuccess:(void (^)(XJYUserEntity *))success failure:(void (^)(NSError *))failure{
    ;
}

-(void)startCinfoTimer{
    ;
}

-(void)setUserInfoWithDictionary:(NSDictionary *)dict{
    ;
}

- (NSString *) MD5:(NSString *)string {
    // Create pointer to the string as UTF8
    const char* ptr = [string UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}


@end
