//
//  PinZhiDAO.h
//  PinZhi
//
//  Created by HUPU on 15/7/8.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "QualityModel.h"

@interface PinZhiDAO : NSObject
{
    FMDatabase*_database;
}

+ (void)getDatabase;
+ (NSString *)getDatabasePath;
+ (NSMutableArray*)getAllMessage;
+(BOOL)insertAMessage:(QualityModel*)aPeople;

@end
