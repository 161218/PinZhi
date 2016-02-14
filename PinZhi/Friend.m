//
//  Friend.m
//
//  Created by TianGe-ios on 14-8-21.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//


#import "Friend.h"

@implementation Friend

+ (instancetype)friendWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
