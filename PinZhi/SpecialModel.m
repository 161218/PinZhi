//
//  SpecialModel.m
//  PinZhi
//
//  Created by HUPU on 15/7/20.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "SpecialModel.h"

@implementation SpecialModel


-(instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self=[super init];
    if (!self)
    {
        return nil;
    }
    self.Hid=[attributes objectForKey:@"id"];
    self.name=[attributes objectForKey:@"name"];
    self.menu=[attributes objectForKey:@"menu"];
    self.tspeople=[attributes objectForKey:@"tspeople"];
    self.tsdepartmentid=[attributes objectForKey:@"tsdepartmentid"];
    self.tsdepartmentname=[attributes objectForKey:@"tsdepartmentname"];
    self.insertTime=[attributes objectForKey:@"insertTime"];
    self.status=[attributes objectForKey:@"status"];
    self.adviseJT=[attributes objectForKey:@"adviseJT"];
    self.adviseZY=[attributes objectForKey:@"adviseZY"];
    
    return self;
}




@end
