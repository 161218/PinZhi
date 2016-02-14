//
//  QualityModel.m
//  PinZhi
//
//  Created by HUPU on 15/7/8.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "QualityModel.h"

@implementation QualityModel

/*
 代办
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


-(instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self=[super init];
    if (!self)
    {
        return nil;
    }
    self.Hid=[attributes objectForKey:@"Id"];
    self.Wid=[attributes objectForKey:@"Wid"];
    self.Fid=[attributes objectForKey:@"Fid"];
    self.Fname=[attributes objectForKey:@"Fname"];
    self.StartDate=[attributes objectForKey:@"StartDate"];
    self.EndDate=[attributes objectForKey:@"EndDate"];
    self.Fwid=[attributes objectForKey:@"Fwid"];
    self.Code=[attributes objectForKey:@"Code"];
    self.Name=[attributes objectForKey:@"Name"];
    self.Value=[attributes objectForKey:@"Value"];
    self.Reback=[attributes objectForKey:@"Reback"];
    

    return self;
}



@end
