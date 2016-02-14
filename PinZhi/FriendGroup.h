//
//  FriendGroup.h
//
//  Created by TianGe-ios on 14-8-21.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendGroup : NSObject

@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

+ (instancetype)friendGroupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
