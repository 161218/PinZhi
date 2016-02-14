//
//  GlobalService.h
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//-----------------------------app配置相关 start-------------------------------------

// 当前版本号
#define APP_VERSION                 @"1.0"

// 应用类型
#define APP_TYPE                    @"iphone"

//应用名称
#define APP_NAME                    @"now"

#ifdef SOURCEBETA
// 应用渠道
#define CHANNEL                      @"NIMBETA"//NIMAppStore

#else
// 应用渠道
#define CHANNEL                      @"NIMDEV"//NIMAppStore

#endif

#define USERAGENT_NAME              [NSString stringWithFormat:@"Mogujie4iPhone/%@/%d" ,CHANNEL ,APP_VERSION]

#define APPLEID                     @"452176796"

#define URL_LICENSE                 @"http://www.mogujie.com/mobile/license/mgj_iphone/500.html"
//-----------------------------app配置相关 end-------------------------------------

//动画时间间隔
#define MGJ_ANIMATION_DURATION      0.4f
#define MGJ_KEYBOARD_ANIMATION_DURATION 0.3f
//-----------------------------UI相关 end-------------------------------------

//-----------------------------网络相关   start-------------------------------------
// URL

#define	API_HOST                    @"www.mogujie.com"

#define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */
#define CC_MD5_BLOCK_BYTES      64          /* block size in bytes */
#define CC_MD5_BLOCK_LONG       (CC_MD5_BLOCK_BYTES / sizeof(CC_LONG))

#define FULL_WIDTH [UIScreen mainScreen].bounds.size.width
#define FULL_HEIGHT [UIScreen mainScreen].bounds.size.height


typedef NS_ENUM(NSInteger , projectStatus){
    PROJECT_STATUS_SAFE=0,
    PROJECT_STATUS_NORMAL,
    PROJECT_STATUS_DANGER,
    PROJECT_STATUS_LOSECONTROL
};

@interface GlobalService: NSObject

+(NSArray *)instance;

+(UIColor *)getStatusColor:(int)status;

+ (NSDictionary *)systemParams;

+ (NSMutableDictionary *)generateSystemParamsWithApiParams:(NSDictionary *)params;

+ (NSString *)base64StringFromText:(NSString *)text;
+ (NSString *) MD5:(NSString *)string;

@end