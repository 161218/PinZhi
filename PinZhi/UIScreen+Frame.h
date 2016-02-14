//
//  UIScreen+Frame.h
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface UIScreen (Frame)

////除去状态栏,导航条的高度
//+ (CGFloat)bodyHeight;
//+ (CGFloat)bodyWidth;

//整个手机屏幕的宽度
+ (CGFloat)screenWidth;
//整个手机屏幕的高度
+ (CGFloat)screenHeight;



+ (CGFloat)statusBarHeight;

+ (CGFloat)navigationBarHeight;

+ (CGFloat)tabBarHeight;

/**
 *  状态栏+导航条高度
 *
 */
+ (CGFloat)statusNavBarHeight;

/**
 *  整个屏幕除-状态栏-导航条-taBar高度
 *
 */
+ (CGFloat)screenMinusStaNavTabHeight;

+ (BOOL)isRetina;
@end
