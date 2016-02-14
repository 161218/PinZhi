//
//  util.h
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "macro.h"

@interface util : NSObject
+(NSNumber *)getTimestamp;
+(NSDate *)stringTranslateDate:(NSString *)strDate;
+(NSString *)dateTranslateString:(NSDate *)date;
@end
