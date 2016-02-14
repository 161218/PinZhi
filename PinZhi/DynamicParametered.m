//
//  DynamicParameter.m
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "DynamicParametered.h"
#import "ViewController.h"
static DynamicParametered *gDynamicParameter=nil;
@implementation DynamicParametered

+(instancetype)sharedDynamicParameter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gDynamicParameter=[[DynamicParametered alloc]init];
    });
    return gDynamicParameter;
}

-(id)init
{
    self=[super init];
    if (self) {
        //self.kid=[[NSString alloc]init];
        self.dictUserInfo=[[NSMutableDictionary alloc]init];
        self.arrayygInfo=[[NSMutableArray alloc]init];
        self.dictAddYgInfo=[[NSMutableDictionary alloc]init];
    }
    return self;
}

+(BOOL)logined:(id)viewController
{
    if ([[DynamicParametered sharedDynamicParameter].uid length]==0)
    {
        UIViewController *view=(UIViewController *)viewController;
        
        ViewController *loginView = [[ViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginView];
        [view.navigationController presentViewController:navi animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}
@end
