//
//  AdminService.m
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/24.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "AdminService.h"
#import "ASIFormDataRequest.h"
#import "Util.h"
@implementation AdminService

//验证用户名/密码
-(NSString *) CheckLoginUser:(NSString *)username Pass:(NSString *)password {
    NSString *result = nil;
    NSString *urlString = [basePath stringByAppendingString:@"LoginServlet"];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    //通过POST方式同步请求验证用户名和密码信息，返回验证结果
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:username forKey:@"userName"];
    [request setPostValue:password forKey:@"password"];
    [request startSynchronous];
    result = [request responseString];
    return result;
}

@end
