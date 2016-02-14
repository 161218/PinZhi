//
//  LaunchIntroductioned.h
//  自定义demo
//
//  Created by 刘子阳 on 15/6/25.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchIntroductioned : UIScrollView<UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *imageNameArray;
@property (strong, nonatomic) UITabBarController *tabBarController;
+ (void)checkShowIntroInView:(UIView *)view;

@end
