//
//  DynamicParameter.h
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "util.h"

@interface DynamicParametered : NSObject
{
    
}
@property (retain) NSString *uid;
@property (retain) NSString *password;
@property (retain) NSString *token;
@property (retain) NSMutableDictionary *dictUserInfo;
@property (retain) NSMutableArray *arrayygInfo;
@property (retain) NSNumber       *numIndexyg;

@property (retain) NSMutableDictionary *dictAddYgInfo;//添加员工临时信息
+(instancetype)sharedDynamicParameter;

+(BOOL)logined:(id)viewController;
@end
