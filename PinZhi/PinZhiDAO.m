//
//  PinZhiDAO.m
//  PinZhi
//
//  Created by HUPU on 15/7/8.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "PinZhiDAO.h"

static FMDatabase*_database=nil;

@implementation PinZhiDAO

+ (NSString *)getDatabasePath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"hp_pz_info.sqlite"];
}

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

+(void)getDatabase
{
    _database=[[FMDatabase alloc]initWithPath:[self getDatabasePath]];
    NSLog(@"%@",[self getDatabasePath]);
    if (![_database open])
    {
        [_database close];
        return;
    }
    [_database setShouldCacheStatements:YES];
    if (![_database tableExists:@"hp_pz_info"])
    {
        NSString *createSQL = @"CREATE TABLE hp_pz_info (Hid TEXT,Wid TEXT,Fid TEXT,Fname TEXT,StartDate TEXT,EndDate TEXT,Fwid TEXT,Code TEXT,Name TEXT,Value TEXT)";
        
        [_database executeUpdate:createSQL];
    }
    
    
    [_database close];
}

#pragma mark-查询
+(NSMutableArray*)getAllMessage
{
    NSMutableArray*mutableArray=[[NSMutableArray alloc]initWithCapacity:0];
    if (![_database open])
    {
        [_database close];
        //断言
        NSAssert([_database open], @"数据库打开失败");
    }
    [_database setShouldCacheStatements:YES];
    NSString*querySQL=@"SELECT * FROM hp_pz_info";
    FMResultSet*resultSet=[_database executeQuery:querySQL];
    while ([resultSet next])
    {
        QualityModel *apeople=[[QualityModel alloc]init];
        
        apeople.Hid=[resultSet stringForColumn:@"Hid"];//
        apeople.Wid=[resultSet stringForColumn:@"Wid"];//
        apeople.Fid=[resultSet stringForColumn:@"Fid"];//
        apeople.Fname=[resultSet stringForColumn:@"Fname"];//
        apeople.StartDate=[resultSet stringForColumn:@"StartDate"];//
        apeople.EndDate=[resultSet stringForColumn:@"EndDate"];//
        apeople.Fwid=[resultSet stringForColumn:@"Fwid"];//
        apeople.Code=[resultSet stringForColumn:@"Code"];//
        apeople.Name=[resultSet stringForColumn:@"Name"];//
        apeople.Value=[resultSet stringForColumn:@"Value"];//
        
        [mutableArray addObject:apeople];
    }
    return mutableArray;
}

#pragma mark - 插入一条新信息

+(BOOL)insertAMessage:(QualityModel*)aPeople
{
    BOOL isSuccess;
    
    if (![_database open])
    {
        [_database close];
    }
    [_database setShouldCacheStatements:YES];
    NSString*insertSQL=@"INSERT INTO hp_pz_info(Hid,Wid,Fid,Fname,StartDate,EndDate,Fwid,Code,Name,Value) VALUES (?,?,?,?,?,?,?,?,?,?)";
    
    isSuccess=[_database executeUpdate:insertSQL, aPeople.Hid,
               aPeople.Wid,
               aPeople.Fid,
               aPeople.Fname,
               aPeople.StartDate,
               aPeople.EndDate,
               aPeople.Fwid,
               aPeople.Code,
               aPeople.Name,
               aPeople.Value];
    [_database close];
    return isSuccess;
}



@end
