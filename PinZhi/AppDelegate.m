//
//  AppDelegate.m
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "QualityTwoViewController.h"
#import "QualityViewController.h"
#import "SpecialViewController.h"
#import "WodeViewController.h"

#import "NavgationTool.h"
#import "LocalStorageManager.h"
#import "LaunchIntroductioned.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    //闪屏图暂停1秒
    [NSThread sleepForTimeInterval:1.0];
    
    [self createViewControllers];
//    if([LocalStorageManager sharedManager].hasLaunchBefore == YES){//判断是否是第一次启动应用
//            [self createViewControllers];
//    }
//    else{
//        [LaunchIntroductioned checkShowIntroInView:self.window];//NO 表示第一次启动
//    }
    NSLog(@"沙盒路径：%@",NSHomeDirectory());
//    [PinZhiDAO getDatabase];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user int下erface.
//    if (application.applicationIconBadgeNumber>0) {  //badge number 不为0，说明程序有那个圈圈图标
//        NSLog(@"我可能收到了推送");
//        //这里进行有关处理
//        [application setApplicationIconBadgeNumber:0];   //将图标清零。
//    }else{
//        [application setApplicationIconBadgeNumber:1];
//    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/*
 *  生成主入口的相关viewcontroller
 */
- (void)createViewControllers
{
    [self RukouTabbar];//Tabbar
    [self.window makeKeyAndVisible];
}
#pragma mark - login delegate
- (void)loginSuccess{
    
    [((UITabBarController *)self.window.rootViewController) setSelectedIndex:2];
}
- (void)loginFail{
    
}
#pragma mark - 判断是否写入过账号
-(BOOL)userDefault{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *employeeid = [userDefault objectForKey:@"employeeid"];
    if(employeeid==nil)
    {
        return YES;
    }
    else{
        return NO;
    }
}
#pragma mark －App Store更新
#pragma mark -Tabbar
-(void)RukouTabbar{
    //Tabbar
    QualityViewController *daibanVC = [[QualityViewController alloc] init];
    QualityTwoViewController *wancheng = [[QualityTwoViewController alloc] init];
    SpecialViewController *teshu = [[SpecialViewController alloc] init];
    WodeViewController *woDe = [[WodeViewController alloc] init];
    
    UINavigationController *daibanNav = [[UINavigationController alloc] initWithRootViewController:daibanVC];
    UINavigationController *wanchengNav = [[UINavigationController alloc] initWithRootViewController:wancheng];
    UINavigationController *teshuNav = [[UINavigationController alloc] initWithRootViewController:teshu];
    
    UINavigationController *woDeNav = [[UINavigationController alloc] initWithRootViewController:woDe];
    
    NSArray *controllers = [NSArray arrayWithObjects:daibanNav, wanchengNav, teshuNav, woDeNav, nil];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    //tabBarController 添加背景图片
    UIImageView * img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar"]];
    img.frame = CGRectOffset( img.frame, 0, 1 );
    [tabBarController.tabBar insertSubview:img atIndex:0];
    
    self.tabBarController = tabBarController;
    self.window.rootViewController = tabBarController;
    tabBarController.viewControllers = controllers;
    
    /*tab_ce_us
    tab_ce_s*/
    daibanNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"待办"
                                                         image:[[UIImage imageNamed:@"tab_ay_us"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                 selectedImage:[[UIImage imageNamed:@"tab_ay_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    wanchengNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"完成"
                                                           image:[[UIImage imageNamed:@"tab_ce_us"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                   selectedImage:[[UIImage imageNamed:@"tab_ce_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    teshuNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"上报"
                                                        image:[[UIImage imageNamed:@"tab_rt_us"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"tab_rt_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    woDeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                       image:[[UIImage imageNamed:@"tab_my_us"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[[UIImage imageNamed:@"tab_my_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [NavgationTool setNavgationDefaultStyle:daibanNav];
    [NavgationTool setNavgationDefaultStyle:wanchengNav];
    [NavgationTool setNavgationDefaultStyle:teshuNav];
    [NavgationTool setNavgationDefaultStyle:woDeNav];
    
    tabBarController.delegate = self;   
    [tabBarController setSelectedIndex:0];
}
@end
