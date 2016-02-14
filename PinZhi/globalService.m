//
//  UrlService.m
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "globalService.h"
#import "AFHTTPRequestOperationManager.h"
#import "XJYUser.h"
#import <CommonCrypto/CommonDigest.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation GlobalService

+(NSArray *)instance{
    NSArray *array = [[NSArray alloc] init];
    return array;
}
+(UIColor *)getStatusColor:(int)status{
    if (status == PROJECT_STATUS_SAFE) {
        return [UIColor colorWithRed:113/255.f green:193/255.f blue:99/255.f alpha:1];
    }
    else if (status == PROJECT_STATUS_NORMAL) {
        return [UIColor colorWithRed:254/255.f green:182/255.f blue:43/255.f alpha:1];
    }
    else if (status == PROJECT_STATUS_DANGER) {
        return [UIColor colorWithRed:254/255.f green:125/255.f blue:76/255.f alpha:1];
    }
    else{
        return [UIColor colorWithRed:230/255.f green:54/255.f blue:19/255.f alpha:1];
    }
}

+ (NSDictionary *)systemParams
{
    NSMutableDictionary *_params = [NSMutableDictionary dictionary];
    
    [_params setObject:@"1" forKey:@"_json"];
    
    //应用类型
    [_params setObject:APP_NAME forKey:@"_app"];
    
    //应用名称
    [_params setObject:APP_TYPE forKey:@"_atype"];
    
    //设备唯一 id
    [_params setObject:[UIDevice currentDevice] forKey:@"_did"];
    
    //网络状况
    //    AFNetworkReachabilityStatus network = [[AFNetworkReachabilityStatus manager] network];
    [_params setObject:[NSString stringWithFormat:@"%ld",(long)1] forKey:@"_network"];
    //
    //第一次安装的来源
    [_params setObject:@"neiwang" forKey:@"_fs"];
    
    //屏幕宽度
    //    NSString* swidth = [NSString stringWithFormat:@"%.0f",[UIDevice currentDevice] wide:];
    [_params setValue:@"960" forKey:@"_swidth"];
    
    
    //    //省流量模式
    [_params setValue:[NSString stringWithFormat:@"%d",0] forKey:@"_saveMode"];
    //
    //版本号
    [_params setObject:[NSString stringWithFormat:@"%@",APP_VERSION] forKey:@"_av"];
    
    //渠道
    [_params setObject:CHANNEL forKey:@"_channel"];
    
    //用户id 和 sign
    if ([[XJYUser shareInstance] isLogin]) {
        [_params setValue:[[XJYUser shareInstance] userInfo].uid forKey:@"_uid"];
        [_params setValue:[[XJYUser shareInstance] userInfo].sign forKey:@"sign"];
    }
    
    //时间戳
    NSString *timestamp = [NSString stringWithFormat:@"%0.f",[[NSDate date] timeIntervalSince1970]];
    [_params setValue:timestamp forKey:@"_t"];
    
    return _params;
}


+ (NSMutableDictionary *)generateSystemParamsWithApiParams:(NSDictionary *)params {
    
    //接口传入参数
    NSMutableDictionary *totalParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    //基础系统参数
    NSMutableDictionary *systemParams = [[self systemParams] mutableCopy];
    
    //加上系统参数
    [totalParams addEntriesFromDictionary:[self systemParams]];
    
    //key 排序
    NSArray *keys = [totalParams allKeys];
    NSArray *sortedkeys = [keys sortedArrayUsingSelector:@selector(compare:)];
    
    //拼接参数
    NSMutableString *parmsStr = [NSMutableString string];
    
    for (NSString *key in sortedkeys) {
        if (![[totalParams objectForKey:key] isKindOfClass:[NSArray class]]) {            [parmsStr appendFormat:@"%@",totalParams[key]];
        }
    }
    
    //计算token
    NSString *baseString = [NSString stringWithFormat:@"%@%@%@%@%@", totalParams[@"_app"], totalParams[@"_atype"], @"573e028c10750389e6b92bf59f6f3ae7", totalParams[@"_t"], [self MD5:parmsStr]];
    NSString *tokenString = [self MD5:baseString];
    
    [systemParams setObject:tokenString forKey:@"_at"];
    
    return systemParams;
}

+ (NSString *) MD5:(NSString *)string {
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

+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return @"";
    }
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end