//
//  DynamicParameter.m
//  here
//
//  Created by ptmc on 14-8-29.
//  Copyright (c) 2014年 ptmc. All rights reserved.
//

#import "DynamicParameter.h"
#import "LoginViewController.h"
static DynamicParameter *gDynamicParameter=nil;
@implementation DynamicParameter

+(instancetype)sharedDynamicParameter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gDynamicParameter=[[DynamicParameter alloc]init];
    });
    return gDynamicParameter;
}

-(id)init
{
    self=[super init];
    if (self) {
        //self.kid=[[NSString alloc]init];
        self.dictUserInfo=[[NSMutableDictionary alloc]init];
        self.arrayBabyInfo=[[NSMutableArray alloc]init];
        self.dictAddBabyInfo=[[NSMutableDictionary alloc]init];
    }
    return self;
}

+(BOOL)logined:(id)viewController
{
    if ([[DynamicParameter sharedDynamicParameter].uid length]==0)
    {
        UIViewController *view=(UIViewController *)viewController;
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [view.navigationController pushViewController:lvc animated:YES];
        return NO;
    }
    return YES;
}
@end
