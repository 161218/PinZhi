//
//  NavgationTool.h
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UINavigationController.h>

@interface NavgationTool : NSObject

/**
 *  设置导航条的样式及tabBarItem样式
 *
 *  @param nav <#nav description#>
 */
+ (void)setNavgationDefaultStyle:(UINavigationController *)nav;
@end
