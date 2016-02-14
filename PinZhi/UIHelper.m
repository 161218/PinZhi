//
//  UIHelper.m
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

+ (BOOL)hideTabBar:(UITabBar *)tabbar isHidden:(BOOL)isHidden{
    
    if (isHidden)
    {
        return isHidden;
    }
    
    CGRect tabbarFrame = [tabbar frame];
    tabbarFrame.origin.y += 49;
    [tabbar setFrame:tabbarFrame];
    
    return YES;
}
+ (BOOL)showTabBar:(UITabBar *)tabbar isHidden:(BOOL)isHidden{
    
    if (isHidden)
    {
        
        CGRect tabbarFrame = [tabbar frame];
        tabbarFrame.origin.y -= 49;
        [tabbar setFrame:tabbarFrame];
        
        return NO;
        
    }else{
        return NO;
    }
}

@end
