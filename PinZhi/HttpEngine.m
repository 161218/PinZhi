//
//  HttpEngine.m
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "HttpEngine.h"

@implementation HttpEngine

+(void)get:(void (^)(NSDictionary *,NSInteger))callback andUrl:(NSString *)url andIndex:(NSInteger)index
{
    AFHTTPRequestOperationManager *operation=[AFHTTPRequestOperationManager manager];
    [operation GET:url parameters:nil success:^(AFHTTPRequestOperation * __unused task, id resultJson){
        
        //回到主程
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback){
                callback(resultJson,index);
            }
        });
        
    } failure:^(AFHTTPRequestOperation *task,NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback){
                callback(nil,index);
            }
            NSLog(@"error=%@,%@",error,[error userInfo]);
        });
    }];
}
+(NSNumber *)getTimestamp;
{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    return [[NSNumber alloc]initWithLongLong:recordTime];
}

+(void)post:(void (^)(NSDictionary *,NSInteger))callback andUrl:(NSString *)url andDict:(NSMutableDictionary *)dict andIndex:(NSInteger)index
{
    //param签名
    //[dict setValue:[HttpEngine getTimestamp] forKey:D_HTTP_PARAM_timestamp];
    //sort key
    NSArray *keys = [dict allKeys];
    NSArray *arraySortedKey = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
                               {
                                   return [obj1 compare:obj2 options:NSNumericSearch];
                               }];
    NSString *strPost=[[NSString alloc]init];
    for (NSString *strKey in arraySortedKey)
    {
        NSObject *value=[dict objectForKey:strKey];
        strPost=[strPost stringByAppendingFormat:@"%@=%@",strKey,value];
    }

    //http
    AFHTTPRequestOperationManager *operation=[AFHTTPRequestOperationManager manager];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation POST:url parameters:dict success:^(AFHTTPRequestOperation * __unused task, id resultJson){
        
        //回到主程
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"%@",resultJson);
            if(callback){
                callback(resultJson,index);
            }
        });
        
    } failure:^(AFHTTPRequestOperation *task,NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(callback)
            {
                callback(nil,index);
                //[[NSNotificationCenter defaultCenter]postNotificationName:D_NOTIFY_NET object:D_NOTIFY_HTTP_failed userInfo:nil];
            }
            NSLog(@"error=%@,%@",error,[error userInfo]);
        });
    }];
}

//上传文件和信息
+(void)postFile:(void (^)(NSDictionary *,NSInteger))callback andUrl:(NSString *)url andArrayData:(NSArray *)arrayData andDict:(NSMutableDictionary *)dict mimeType:(NSString *)mimeType andIndex:(NSInteger)index
{
    NSArray *keys = [dict allKeys];
    NSArray *arraySortedKey = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
                               {
                                   return [obj1 compare:obj2 options:NSNumericSearch];
                               }];
    NSString *strUrl=[[NSString alloc]init];
    for (NSString *strKey in arraySortedKey)
    {
        NSObject *value=[dict objectForKey:strKey];
        strUrl=[strUrl stringByAppendingFormat:@"%@=%@",strKey,value];
    }
    //http
    AFHTTPRequestOperationManager *operation=[AFHTTPRequestOperationManager manager];
    //[operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    operation.requestSerializer = [AFHTTPRequestSerializer serializer];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    //operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for(int i=0;i<arrayData.count;i++){
            NSData *imageData=[arrayData objectAtIndex:i];
            NSString *fileName=nil;
            NSString *imageName=nil;
            if ([mimeType compare:@"image/jpeg"]==NSOrderedSame)
            {
                fileName=[NSString stringWithFormat:@"file%d",i];
                imageName=[NSString stringWithFormat:@"image%d.jpg",i];
            }
            else if ([mimeType compare:@"audio/wav"]==NSOrderedSame)
            {
                fileName=[NSString stringWithFormat:@"file%d",i];
                imageName=[NSString stringWithFormat:@"wav%d.amr",i];
            }
            [formData appendPartWithFileData:imageData name:fileName fileName:imageName mimeType:mimeType];
            
        }
        
    } success:^(AFHTTPRequestOperation *task, id resultJson) {
        //回到主程
        dispatch_async(dispatch_get_main_queue(), ^{
            if(callback){
                callback(resultJson,index);
            }
        });
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(callback){
                callback(nil,index);
            }
            NSLog(@"error=%@,%@",error,[error userInfo]);
        });
    }];
}
@end
