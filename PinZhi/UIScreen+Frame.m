//
//  UIScreen+Frame.m
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "UIScreen+Frame.h"

@implementation UIScreen (Frame)

//+ (CGFloat)bodyHeight{
//    static UINavigationController *kNavigationController = nil;
//    if(kNavigationController == nil)
//        kNavigationController = [[UINavigationController alloc] init];
//    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
//    return height - [UIApplication sharedApplication].statusBarFrame.size.height - kNavigationController.navigationBar.frame.size.height;
//}
//
//+ (CGFloat)bodyWidth{
////    NSLog(@"[[UIScreen mainScreen] bounds].size.width=%g", [[UIScreen mainScreen] bounds].size.width);
//    return [[UIScreen mainScreen] bounds].size.width;
//}

+ (CGFloat)screenWidth{
//    NSLog(@"[[UIScreen mainScreen] bounds].size.width=%g", [[UIScreen mainScreen] bounds].size.width);
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight{
//    NSLog(@"[[UIScreen mainScreen] bounds].size.height=%g", [[UIScreen mainScreen] bounds].size.height);
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (BOOL)isRetina{
    BOOL is = fabs([[UIScreen mainScreen] scale]-2) < 1e-6;
    NSLog(@"isRetina=%d", is);
    return is;
}

+ (CGFloat)statusBarHeight{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)navigationBarHeight{
    return 44;
}

+ (CGFloat)tabBarHeight{
    return 48;
}

+ (CGFloat)statusNavBarHeight{
    return [self statusBarHeight] + [self navigationBarHeight];
}

+ (CGFloat)screenMinusStaNavTabHeight{
    return [self screenHeight] - [self statusBarHeight] - [self navigationBarHeight] - [self tabBarHeight];
}
@end
