//
//  AppDelegate.h
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinZhiDAO.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end

