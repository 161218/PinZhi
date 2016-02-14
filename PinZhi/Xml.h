//
//  Xml.h
//  PinZhi
//
//  Created by HUPU on 15/10/12.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Xml : NSObject<NSXMLParserDelegate>

@property(nonatomic,strong)NSXMLParser *xmlParser;
@property (strong, nonatomic) NSMutableString *soapResults;
@property (nonatomic) BOOL elementFound;
@property(nonatomic,strong)NSMutableArray *infoArray;
@property (strong, nonatomic) NSString *matchingElement;

-(void)xmlString:(NSString *)string;

@end
