//
//  DynamicParameter.h
//  here
//
//  Created by ptmc on 14-8-29.
//  Copyright (c) 2014年 ptmc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "util.h"

@interface DynamicParameters : NSObject
{
    
}
@property (retain) NSString *uid;
@property (retain) NSString *password;
@property (retain) NSString *token;
@property (retain) NSMutableDictionary *dictUserInfo;
@property (retain) NSMutableArray *arrayBabyInfo;
@property (retain) NSNumber       *numIndexBaby;

@property (retain) NSMutableDictionary *dictAddBabyInfo;//添加宝宝临时信息
+(instancetype)sharedDynamicParameter;

+(BOOL)logined:(id)viewController;
@end
