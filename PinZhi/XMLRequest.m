//
//  XMLRequest.m
//  PinZhi
//
//  Created by HUPU on 15/7/10.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "XMLRequest.h"

@implementation XMLRequest

-(void)returnMoreInfo
{
    _infoArray = [[NSMutableArray alloc] init];
    
    [self Soapshuj];

}


#pragma mark－ 部门信息
-(void)Soapshuj{
    /*
     employeeid 10003473 员工id
     employeesn CCH-IT-0006 员工账号
     employeename 盛磊 员工姓名
     mobile 18957113301 手机号
     departmentid 10030 部门
     hotelid 1009 酒店编号
     */
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *departmentid = [userDefault objectForKey:@"hotelid"];
    //NSString *hotelid = [userDefault objectForKey:@"hotelid"];
    
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    _matchingElement = @"GetdepartmentResult";
    
    //注意封装数据时 要定义转义符
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>\n"
                             
                             //封装好主要数据  其他部分都是死的
                             "<Getdepartment xmlns=\"http://outpre.4008266333.net/\">"
                             "<hotelid>%@</hotelid>"
                             "</Getdepartment>"
                             
                             "</soap:Body>\n"
                             "</soap:Envelope>",departmentid];
    NSLog(@"调用webserivce的字符串是:%@",soapMessage);
    
    //请求发送到的路径
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    NSURL *url = [NSURL URLWithString:@"http://outpre.4008266333.net/"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    //以下对请求信息添加属性前四句是必有的，
    [urlRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue: @"http://outpre.4008266333.net" forHTTPHeaderField:@"SoapException"];//后面的这个类型多试几个就行
    [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    if (theConnection) {
        _webData = [NSMutableData data];
    }
    
}

#pragma mark --  NSURLConnectionDataDelegate
//接收到服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_webData setLength: 0];
}
//接受到服务器响应的时候
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_webData appendData:data];
}
//请求结束 连接断开
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *theXML = [[NSString alloc] initWithBytes:[_webData mutableBytes]
                                                length:[_webData length]
                                              encoding:NSUTF8StringEncoding];
    // 打印出得到的XML
    NSLog(@"%@", theXML);
    // 使用NSXMLParser解析出我们想要的结果
    _xmlParser = [[NSXMLParser alloc] initWithData: _webData];
    [_xmlParser setDelegate: self];
    [_xmlParser setShouldResolveExternalEntities: YES];
    [_xmlParser parse];
    
    NSLog(@"打印出得到的XML ---------------------------1");
    
    NSLog(@"_infoArray -- %lu",(unsigned long)_infoArray.count);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RELOADVOEWNOTIFICATION" object:_infoArray];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *departmentid = [userDefault objectForKey:@"departmentid"];
    
    for (int i = 0; i < _infoArray.count; i++)
    {
        if ([_infoArray[i] isEqualToString:departmentid])
        {
            
            NSString *department = _infoArray[i+1];
            
            NSLog(@"department -- %@",department);
        }
    }
    
    
}

//错误信息
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _webData = nil;
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
    if ([elementName isEqualToString:_matchingElement]) {
        if (!_soapResults) {
            _soapResults = [[NSMutableString alloc] init];
            
            _elementFound = YES;
        }
    }
    
}
//发现内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_elementFound) {
        [_soapResults appendString:string];
    }
    else
    {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *departmentid = [userDefault objectForKey:@"hotelid"];
        
        if (![string isEqualToString:@" "] && ![string isEqualToString:departmentid]){
            [_infoArray addObject:string];
        }
    }
    
}
//存储接收到的信息
//发现结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:_matchingElement]) {
        NSLog(@"解析出来的数据:===%@",_soapResults);
        _elementFound = FALSE;
        if (_isFrist == NO)
        {
            dispatch_queue_t reentrantAvoidanceQueue = dispatch_queue_create("reentrantAvoidanceQueue", DISPATCH_QUEUE_SERIAL);
            dispatch_async(reentrantAvoidanceQueue, ^{
                NSData* xmlData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
                _xmlParserTwo = [[NSXMLParser alloc] initWithData: xmlData];
                [_xmlParserTwo setDelegate: self];
                [_xmlParserTwo setShouldResolveExternalEntities: YES];
                [_xmlParserTwo parse];
                self.isFrist = YES;
            });
            dispatch_sync(reentrantAvoidanceQueue, ^{ });
        }
    }
    
//        NSLog(@"_infoArray---%lu",(unsigned long)_infoArray.count);
//        NSLog(@"_infoArray---%@",_infoArray);

}
@end
