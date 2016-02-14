//
//  QualityModel.h
//  PinZhi
//
//  Created by HUPU on 15/7/8.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QualityModel : NSObject

/*
 Hid
 Wid
 Fid
 Fname
 StartDate
 EndDate
 Fwid
 Code
 Name
 Value
 */
@property (nonatomic, strong) NSString *Hid;
@property (nonatomic, strong) NSString *Wid;
@property (nonatomic, strong) NSString *Fid;
@property (nonatomic, strong) NSString *Fname;
@property (nonatomic, strong) NSString *StartDate;
@property (nonatomic, strong) NSString *EndDate;
@property (nonatomic, strong) NSString *Fwid;
@property (nonatomic, strong) NSString *Code;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Value;
@property (nonatomic, strong) NSString *Reback;


-(instancetype)initWithAttributes:(NSDictionary *)attributes;



@end
