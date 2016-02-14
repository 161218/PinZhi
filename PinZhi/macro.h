//
//  macro.h
//  xiaojiaoya
//
//  Created by huineng on 15/1/18.
//  Copyright (c) 2015年 huineng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicParametered.h"
#import "HttpEngine.h"
#import "MBProgressHUD+Add.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"

#define FULL_WIDTH [[UIScreen mainScreen] bounds].size.width
#define FULL_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]

#define IsEmptyString(str) (!str || [str isEqualToString:@""])

#define RGBA(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define FONT(s)          [UIFont systemFontOfSize:s]
#define XJYColor [UIColor colorWithRed:255/255.0f green:127/255.0f blue:102/255.0f alpha:1]

#define NAVIBAR_HEIGHT 0.f
//#define NAVIBAR_HEIGHTT 50.f
//#define NAVIBAR_HEIGHTr 100.f

#define D_DATE_BEGIN                            @"2010-01-01"
#define D_DATE_SET                              @"2013-06-15"

#define TIME_OUT_SECONDS 30

#define RECT_SCREEN                        [[UIScreen mainScreen] bounds]
#define RECT_BODY(viewController)          viewController.view.bounds
#define RECT_CELL(cell)                    cell.bounds
#define RECT_VIEW                          [[UIScreen mainScreen] bounds]
#define RECT_TOOLBAR                       [[UIScreen mainScreen] bounds]

#define RGBA(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]

#define RGBA(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define FONT(s)          [UIFont systemFontOfSize:s]

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width


#define FULL_WIDTH [UIScreen mainScreen].bounds.size.width
#define FULL_HEIGHT [UIScreen mainScreen].bounds.size.height
#pragma mark - API

#define  DAIBAN_URL @"http://180.153.43.39:8090/ysmr-pzgl/ws/jaxrs/RsForm/001?status=%@&userid=%@&hotelid=%@"//代办  //完成
#define  DAIBAN_URL_NEW @"http://180.153.43.39:8090/ysmr-pzgl/ws/jaxrs/RsForm/001?userid=%@&hotelid=%@&status=%@&startDate=%@&endDate=%@"//待办  //完成

#define  ZHIJIAN_URL @"http://180.153.43.39:8090/ysmr-pzgl/ws/jaxrs/RsForm/003?id=%@"//质检
#define  WANCHENG_URL @"http://180.153.43.39:8090/ysmr-pzgl/ws/jaxrs/RsForm/002?id=%@"//完成
#define  SAHNGBAO_URL @"http://180.153.43.39:8090/ysmr-pzgl/ws/jaxrs/RsForm/006?employeeid=%@&status=%@"//上报
#define  IMAGE_URL @"http://180.153.43.39:8090/ysmr-pzgl/ws/jaxrs/RsForm/004?id=%@"//图片
#define  GUOQI_URL @"http://180.153.43.39:8090/ysmr-pzgl/ws/jaxrs/RsForm/001?userid=%@&hotelid=%@&status=%@"//过期任务



#import "ASIHTTPRequest.h"
#import "UIHelper.h"
#import "UpdateCheck.h"