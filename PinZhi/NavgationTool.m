//
//  NavgationTool.m
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "NavgationTool.h"
#import <UIKit/UINavigationBar.h>
#import <UIKit/NSAttributedString.h>
#import <UIKit/UITabBarController.h>
#import <UIKit/UITabBarItem.h>
#import "macro.h"
@implementation NavgationTool

+ (void)setNavgationDefaultStyle:(UINavigationController *)nav{
    nav.navigationBar.translucent = NO;
    [nav.navigationBar setTintColor:[UIColor blackColor]];//导航条上的文字颜色
    [nav.navigationBar setBarTintColor:RGBA(244, 243, 238, 1)];//导航条背景
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];//导航条标题
    
//    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(0xd9, 0x4b, 0x3c)} forState:UIControlStateSelected];
//    
//    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(0x71, 0x6f, 0x6f)} forState:UIControlStateNormal];
    
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateSelected];
    
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
}
@end
