//
//  HttpEngine.h
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//
#define D_HTTP_PARAM_status                      @"status"
#define D_HTTP_PARAM_data                        @"data"
//

@interface HttpEngine : NSObject
+(void)setRandomKey:(NSString *)strRandomKey;
+(void)get:(void (^)(NSDictionary *,NSInteger))callback andUrl:(NSString *)url andIndex:(NSInteger)index;
+(void)post:(void (^)(NSDictionary *,NSInteger))callback andUrl:(NSString *)url andDict:(NSMutableDictionary *)dict andIndex:(NSInteger)index;
+(void)postFile:(void (^)(NSDictionary *,NSInteger))callback andUrl:(NSString *)url andArrayData:(NSArray *)arrayData andDict:(NSMutableDictionary *)dict mimeType:(NSString *)mimeType  andIndex:(NSInteger)index;
@end