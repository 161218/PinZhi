//
//  LaunchIntroductioned.m
//  自定义demo
//
//  Created by 刘子阳 on 15/6/25.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "LaunchIntroductioned.h"
#import "UIView+Sizes.h"
#import "LocalStorageManager.h"

#import "QualityTwoViewController.h"
#import "QualityViewController.h"
#import "SpecialViewController.h"
#import "WodeViewController.h"
#import "WoSpecialViewController.h"

#import "NavgationTool.h"

#import "ViewController.h"
@implementation LaunchIntroductioned

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturePress:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}
+ (void)checkShowIntroInView:(UIView *)view{
    if([LocalStorageManager sharedManager].hasLaunchBefore == YES){
        return ;
    }
    LaunchIntroductioned *launchView = [[LaunchIntroductioned alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [launchView updateWithImageNameArray:@[@"launch_info_0", @"launch_info_1", @"launch_info_2"]];
    [view addSubview:launchView];
    
    [LocalStorageManager sharedManager].hasLaunchBefore = YES;
}

- (void)updateWithImageNameArray:(NSArray *)imageNameArray{
    self.imageNameArray = imageNameArray;
    for (int i = 0; i < imageNameArray.count; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNameArray[i]]];
        imageView.frame = CGRectMake(i*self.width, 0, self.width, self.height);
        
        [self addSubview:imageView];
    }
    self.contentSize = CGSizeMake(imageNameArray.count * self.width, self.height);
}

- (void)tapGesturePress:(UITapGestureRecognizer *)tap{
    NSInteger index = self.contentOffset.x / self.frame.size.width;
    if(index == self.imageNameArray.count-1){//最后一张
        [UIView animateWithDuration:1 animations:^{
            self.alpha = 0;
            self.center = CGPointMake(self.center.x, self.center.y-self.height);
        } completion:^(BOOL finished) {
            
            [self RukouTabbar];//Tabbar
        }];
    }
}
#pragma mark - login delegate
- (void)loginSuccess{
    [((UITabBarController *)self.window.rootViewController) setSelectedIndex:0];
}
- (void)loginFail{
    
}
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
    
    daibanNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"待办"
                                                         image:[[UIImage imageNamed:@"tab_ce_us"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                 selectedImage:[[UIImage imageNamed:@"tab_ce_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    wanchengNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"完成"
                                                           image:[[UIImage imageNamed:@"tab_ay_us"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                   selectedImage:[[UIImage imageNamed:@"tab_ay_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
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
//    [tabBarController setSelectedIndex:0];
    
    if ([self userDefault]==NO )
    {
        [tabBarController setSelectedIndex:0];
        
    }
    else
    {
        [tabBarController setSelectedIndex:3];
        
    }
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
@end
