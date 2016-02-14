//
//  Friend.h
//
//  Created by TianGe-ios on 14-8-21.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic, copy) NSString *name;

+ (instancetype)friendWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
