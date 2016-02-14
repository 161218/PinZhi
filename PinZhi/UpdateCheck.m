//
//  UpdateCheck.m
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "UpdateCheck.h"
#import "ASIHTTPRequest.h"
#import "macro.h"

//线上
@implementation UpdateCheck

//
+ (BOOL)hasNewVersion{

    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error)
    {
        NSString *response = [request responseString];
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSError *errorParse = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorParse];
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"dictionary");
            NSDictionary *dict = (NSDictionary *)jsonObject;

            NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            NSLog(@"%@ -- %@",[dict valueForKey:@"version"],currentVersion);
            
            if ([currentVersion intValue] < [[dict valueForKey:@"version"] intValue]) {
                return YES;
            }else{
                return NO;
            }
            
        }else{
            NSLog(@"An error happened while deserializing the JSON data.");
            return NO;
        }
    }else{
        NSLog(@"%@",error);
        return NO;
    }

}

@end
