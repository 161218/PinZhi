//
//  WodeViewController.h
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuoQiViewController.h"

@interface WodeViewController : UIViewController<NSXMLParserDelegate>

@property(nonatomic,copy)NSString *phoneNumber;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *department;

//@property(nonatomic,strong)NSMutableArray *infoArray2;
@end
