//
//  XJYUser.h
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XJYUserEntity.h"

/**
 *  用户信息工具类
 */
@interface XJYUser: NSObject

/**
 *  上一次登录的用户名，不包括第三方登录
 */
@property(nonatomic, strong, readonly) NSString *lastLoginUserName;

/**
 *  是否登录
 */
@property(nonatomic, assign, readonly) BOOL isLogin;

/**
 *  用户信息
 */
@property(nonatomic, strong) XJYUserEntity *userInfo;


/**
 *  单例方法
 *
 *  @return MGJUser 实例
 */
+ (XJYUser *)shareInstance;


/**
 *  判断用户登录状态，已登录则更新用户信息
 */
- (void)checkLoginStatus;


/**
 *  更新用户信息，更新完成后发通知 MGJUserInfoDidUpdateNotification;
 */
- (void)updateUserInfo:(XJYUserEntity *)userEntity;

/**
 *  启动 cinfo 计时器
 */
- (void)startCinfoTimer;

/**
 *  登录
 *
 *  @param name     用户名
 *  @param password 密码
 *  @param captCode 验证码
 *  @param captKey  验证码的key
 *  @param view     需要加loading的view
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)loginWithUsername:(NSString *)name password:(NSString *)password captCode:(NSString*)captCode captKey:(NSString*)captKey loadingInView:(UIView *)view success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

/**
 *  登录成功后调用该方法写入用户信息，该方法执行完成后会发通知 MGJUserDidLoginNotification
 *
 *  @param userInfo 用户信息
 */
- (void)loginSuccessWithUserInfo:(XJYUserEntity *)userInfo;

/**
 *  用字典数据更新本地用户信息
 *
 *  @param dict 用户信息字典
 */
- (void)setUserInfoWithDictionary:(NSDictionary *)dict;

/**
 *  退出登录，会调用接口并且清除本地信息，执行完后发通知 MGJUserDidLogoutNotification
 */
- (void)logout;

/**
 *  退出重新登录
 */
- (void)relogin;

/**
 *  刷新用户token
 *
 *  @param success success block
 *  @param failure failure block
 */
- (void)refreshUserTokenSuccess:(void (^)(XJYUserEntity *userInfo))success failure:(void (^)(NSError *error))failure;

/**
 *  处理用户状态过期，如果不能刷新用户状态，则提示用户重新登录
 *
 *  @param complete 用户状态刷新成功后调用
 */
- (void)handleUserTokenExpired:(void(^)())complete;


@end
