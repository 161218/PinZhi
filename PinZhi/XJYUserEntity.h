//
//  XJYUserEntity.h
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "JSONModel.h"

/**
 *  性别枚举
 */
typedef NS_ENUM(NSUInteger, SEX) {
    /**
     *  男
     */
    Male = 1,
    /**
     *  女
     */
    Female = 2,
};


/**
 *  用户实体
 */
@interface XJYUserEntity :JSONModel

/**
 *  登录sign
 */
@property (nonatomic, strong) NSString *sign;

/**
 *  用户id
 *
 */
@property (nonatomic, strong) NSString *uid;

/**
 *  用户id
 *
 */
@property (nonatomic, strong) NSString *uname;


/**
 *  登录token
 */
@property (nonatomic, strong) NSString *token;


@end
