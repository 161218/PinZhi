//
//  util.m
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "util.h"
#import "sys/utsname.h"

@implementation util
+(NSDate *)stringTranslateDate:(NSString *)strDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=nil;
    if (strDate.length==0)
        date = [formatter dateFromString:D_DATE_BEGIN];
    else
        date = [formatter dateFromString:strDate];
    return date;
}

+(NSString *)dateTranslateString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [formatter stringFromDate:date];
    if ([strDate compare:D_DATE_BEGIN]==NSOrderedSame)
    {
        return @"";
    }
    return strDate;
}

@end
