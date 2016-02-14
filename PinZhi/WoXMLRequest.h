//
//  WoXMLRequest.h
//  PinZhi
//
//  Created by 刘子阳 on 15/7/20.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WoXMLRequest : NSObject<NSXMLParserDelegate>

@property(nonatomic,strong)NSXMLParser *xmlParserTwo;
@property(nonatomic,assign)BOOL isFrist;
@property(nonatomic,assign)BOOL isInfo;
@property(nonatomic,strong)NSMutableArray *infoArray;


@property(nonatomic,strong)NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFound;
@property (strong, nonatomic) NSString *matchingElement;
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults;

-(void)returnMoreInfo;

@end
