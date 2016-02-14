//
//  LocalStorageManager.h
//  自定义demo
//
//  Created by 刘子阳 on 15/6/25.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LOCAL_STORAGE_PATH @"noCloud"
@interface LocalStorageManager : NSObject

/**
 *  热门
 */
@property (nonatomic, strong) NSDictionary *hotCarBrandDict;

/**
 *  所有
 */
@property (nonatomic, strong) NSDictionary *allCarBrandDict;

/**
 *  首页缓存的数据
 */
@property (nonatomic, strong) NSDictionary *homeCacheDict;

/**
 *  热门城市
 */
@property (nonatomic, strong) NSDictionary *hotCityDict;

/**
 *  是否当前版本第一次启动.若NO则为第一次.
 */
@property (nonatomic, assign) BOOL hasLaunchBefore;

/**
 *  上一次用户选择的城市数据.City,Name,ID
 */
@property (nonatomic, strong) NSDictionary *lastSelectedCity;

+ (LocalStorageManager *) sharedManager;

- (NSString *)storeRootPath;


@end
