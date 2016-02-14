//
//  SpecialModel.h
//  PinZhi
//
//  Created by HUPU on 15/7/20.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialModel : NSObject

@property(strong,nonatomic)NSString *Hid;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *menu;
@property(strong,nonatomic)NSString *tspeople;
@property(strong,nonatomic)NSString *tsdepartmentid;
@property(strong,nonatomic)NSString *tsdepartmentname;
@property(strong,nonatomic)NSString *insertTime;
@property(strong,nonatomic)NSString *status;
@property(strong,nonatomic)NSString *adviseJT;
@property(strong,nonatomic)NSString *adviseZY;



-(instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
