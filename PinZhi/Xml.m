//
//  Xml.m
//  PinZhi
//
//  Created by HUPU on 15/10/12.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "Xml.h"

@implementation Xml

-(void)xmlString:(NSString *)string
{
    
    self.infoArray = [[NSMutableArray alloc] init];

    NSData* xmlData = [string dataUsingEncoding:NSUTF8StringEncoding];
    _xmlParser = [[NSXMLParser alloc] initWithData: xmlData];
    [_xmlParser setDelegate: self];
    [_xmlParser setShouldResolveExternalEntities: YES];
    [_xmlParser parse];
    
}


#pragma mark --  NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------start--------------");
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------end--------------");
}
//发现开始标签
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (!_soapResults) {
        _soapResults = [[NSMutableString alloc] init];
        
    }

}
//发现内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"string -- %@",string);
    if (![string isEqualToString:@" "]) {
        [_infoArray addObject:string];
    }

    
    
//     [_infoArray addObject:string];
}
//存储接收到的信息
//发现结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
        
    NSLog(@"解析出来的数据:===%@",_soapResults);
    
    if (_infoArray.count==8)
    {
         NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:_infoArray,@"responseJSON",nil];
        
        NSNotification *notification =[NSNotification notificationWithName:@"Xml" object:nil userInfo:dict];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
  
    
    
    NSLog(@"_infoArray---%lu",(unsigned long)_infoArray.count);
    NSLog(@"_infoArray---%@",_infoArray);
}





@end
