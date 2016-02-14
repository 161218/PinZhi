//
//  UIHelper.h
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIHelper : NSObject

//隐藏tabbar，返回tabbar状态
+ (BOOL)hideTabBar:(UITabBar *)tabbar isHidden:(BOOL)isHidden;

//显示tabbar， 返回tabbar状态
+ (BOOL)showTabBar:(UITabBar *)tabbar isHidden:(BOOL)isHidden;

@end
