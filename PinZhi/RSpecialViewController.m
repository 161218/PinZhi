//
//  RSpecialViewController.m
//  PinZhi
//
//  Created by HUPU on 15/7/20.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "RSpecialViewController.h"

@interface RSpecialViewController ()<NSXMLParserDelegate>


@property (strong, nonatomic) NSMutableData *webData;
@property(nonatomic,strong)NSXMLParser *xmlParser;

@property (nonatomic) BOOL elementFound;
@property (strong, nonatomic) NSString *matchingElement;
@property (strong, nonatomic) NSMutableString *soapResults;

@property(nonatomic,strong)NSMutableArray *infoArray;

@property(nonatomic,assign)BOOL isFrist;
@property(nonatomic,assign)BOOL isInfo;
@property(nonatomic,strong)NSXMLParser *xmlParserTwo;
@end

@implementation RSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"上报查看";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,20)];
    [rightButton setImage:[UIImage imageNamed:@"arrow-back.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
    
    
    
    CGRect framedd=CGRectMake(0, 64, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 44);
    //
    UIButton *backgroundBtn = [UIButton buttonWithType:0];
    backgroundBtn.frame = framedd;
    [self.view addSubview:backgroundBtn];
    
    //背景
    CGRect framed=CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x+5,[[UIScreen mainScreen] applicationFrame].origin.y, [[UIScreen mainScreen] applicationFrame].size.width-10, [[UIScreen mainScreen] applicationFrame].origin.y+260);
    //标题
    CGRect frame2=CGRectMake(10,framed.origin.y-10, FULL_WIDTH-15*2, 40);
    //投诉人
    CGRect frame3=CGRectMake(10,frame2.origin.y+45, FULL_WIDTH-15*2, 40);
    //被投诉人
    CGRect frame4=CGRectMake(10,frame3.origin.y+45, FULL_WIDTH-15*2, 40);
    //详细信息
    CGRect frame5=CGRectMake(10,frame4.origin.y+20, FULL_WIDTH-15*2, 80);
    //图片上传
    CGRect frame6=CGRectMake(10,frame5.origin.y+115, FULL_WIDTH-15*2, 40);
    
    //text
    //标题
    CGRect framet2=CGRectMake(90,framed.origin.y-5, FULL_WIDTH-58*2, 30);
    //投诉人
    CGRect framet3=CGRectMake(90,framet2.origin.y+45, FULL_WIDTH-58*2, 30);
    //被投诉人
    CGRect framet4=CGRectMake(90,framet3.origin.y+45, FULL_WIDTH-58*2, 30);
    //详细信息
    CGRect framet5=CGRectMake(90,framet4.origin.y+45, FULL_WIDTH-58*2, 70);
    //图片上传
    CGRect framet6=CGRectMake(90,framet5.origin.y+75, FULL_WIDTH-58*2, 30);
    
    //
    CGRect frame2s=CGRectMake(10,framed.origin.y-10, FULL_WIDTH-15*2, 40);
    // 人/部门
    CGRect frame3s=CGRectMake(18,frame2s.origin.y+60, FULL_WIDTH-15*2, 40);
    //被投诉人 人/部门
    CGRect frame4s=CGRectMake(18,frame3.origin.y+60, FULL_WIDTH-15*2, 40);
    
    //背景
    bgview=[[UIButton alloc]initWithFrame:framed];
    bgview.backgroundColor=RGBA(255, 255, 255,0);
    [self.view addSubview:bgview];
    
    // 人/部门
    tousubm=[[UIButton alloc]initWithFrame:frame3s];
    tousubm.backgroundColor=RGBA(240, 240, 240,0);
    tousubm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [tousubm setTitleColor:RGBA(212, 202, 179, 1) forState:UIControlStateNormal];
    [tousubm setTitle:@"人/部门" forState:UIControlStateNormal];
    [tousubm setFont:[UIFont systemFontOfSize:12.0f]];
    [bgview addSubview:tousubm];
    
    // 人/部门
    btousubm=[[UIButton alloc]initWithFrame:frame4s];
    btousubm.backgroundColor=RGBA(240, 240, 240,0);
    btousubm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btousubm setTitleColor:RGBA(212, 202, 179, 1) forState:UIControlStateNormal];
    [btousubm setTitle:@"人/部门" forState:UIControlStateNormal];
    [btousubm setFont:[UIFont systemFontOfSize:12.0f]];
    [bgview addSubview:btousubm];
    
    //标题
    bname=[[UIButton alloc]initWithFrame:frame2];
    bname.backgroundColor=RGBA(240, 240, 240,0);
    bname.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bname setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bname setTitle:@"标   题:" forState:UIControlStateNormal];
    [bname setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:bname];
    //标题text
    _bnametext=[[UITextField alloc]initWithFrame:framet2];
    _bnametext.backgroundColor=[UIColor whiteColor];
    _bnametext.layer.cornerRadius=5.0f;
    _bnametext.layer.masksToBounds=YES;
    _bnametext.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    _bnametext.layer.borderWidth= 1.0f;
    _bnametext.text=self.specialModel.name;
    _bnametext.textColor=[UIColor lightGrayColor];
    _bnametext.userInteractionEnabled = NO;
    [bgview addSubview:_bnametext];
    
    //投诉人
    btousu=[[UIButton alloc]initWithFrame:frame3];
    btousu.backgroundColor=RGBA(240, 240, 240,0);
    btousu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btousu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btousu setTitle:@"投   诉:" forState:UIControlStateNormal];
    [btousu setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:btousu];
    //投诉人text
    _btousutext=[[UITextField alloc]initWithFrame:framet3];
    _btousutext.backgroundColor=[UIColor whiteColor];
    _btousutext.layer.cornerRadius=5.0f;
    _btousutext.layer.masksToBounds=YES;
    _btousutext.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    _btousutext.layer.borderWidth= 1.0f;
    _btousutext.text=self.specialModel.tspeople;
    _btousutext.userInteractionEnabled = NO;
     _btousutext.textColor=[UIColor lightGrayColor];
    [bgview addSubview:_btousutext];
    
    //被投诉人
    bbtousu=[[UIButton alloc]initWithFrame:frame4];
    bbtousu.backgroundColor=RGBA(240, 240, 240,0);
    bbtousu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bbtousu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bbtousu setTitle:@"被投诉:" forState:UIControlStateNormal];
    [bbtousu setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:bbtousu];
    //被投诉人text
    _bbtousutext=[[UITextField alloc]initWithFrame:framet4];
    _bbtousutext.backgroundColor=[UIColor whiteColor];
    _bbtousutext.layer.cornerRadius=5.0f;
    _bbtousutext.layer.masksToBounds=YES;
    _bbtousutext.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    _bbtousutext.layer.borderWidth= 1.0f;
    _bbtousutext.text=[NSString stringWithFormat:@"%@",self.specialModel.tsdepartmentname];
    _bbtousutext.userInteractionEnabled = NO;
     _bbtousutext.textColor=[UIColor lightGrayColor];
    [bgview addSubview:_bbtousutext];
    
    //详细信息
    bxmessage=[[UIButton alloc]initWithFrame:frame5];
    bxmessage.backgroundColor=RGBA(240, 240, 240,0);
    bxmessage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bxmessage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bxmessage setTitle:@"详细信息:" forState:UIControlStateNormal];
    [bxmessage setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:bxmessage];
    
    //详细信息text
    _bxmessagetext=[[UITextView alloc]initWithFrame:framet5];
    _bxmessagetext.backgroundColor=[UIColor whiteColor];
    _bxmessagetext.layer.cornerRadius=5.0f;
    _bxmessagetext.layer.masksToBounds=YES;
    _bxmessagetext.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    _bxmessagetext.layer.borderWidth= 1.0f;
    _bxmessagetext.text=self.specialModel.menu;
    _bxmessagetext.userInteractionEnabled = NO;
    _bxmessagetext.textColor=[UIColor lightGrayColor];
    _bxmessagetext.font=[UIFont systemFontOfSize:17.0];
    [bgview addSubview:_bxmessagetext];
    
    UILabel *adviseJT = [[UILabel alloc] initWithFrame:CGRectMake(10, framet5.origin.y+75, FULL_WIDTH-15*2, 40)];
    adviseJT.text = @"集团管理员:";
    adviseJT.font=[UIFont systemFontOfSize:14.0];
    [bgview addSubview:adviseJT];
    UITextField *adviseJTFT = [[UITextField alloc] initWithFrame:CGRectMake(90, framet5.origin.y+80, FULL_WIDTH-58*2, 30)];
    adviseJTFT.userInteractionEnabled = NO;
    adviseJTFT.layer.cornerRadius=5.0f;
    adviseJTFT.layer.masksToBounds=YES;
    adviseJTFT.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    adviseJTFT.layer.borderWidth= 1.0f;
    adviseJTFT.textColor=[UIColor lightGrayColor];
    adviseJTFT.font=[UIFont systemFontOfSize:17.0];
    adviseJTFT.text=self.specialModel.adviseJT;
    [bgview addSubview:adviseJTFT];


    
    UILabel *adviseZY = [[UILabel alloc] initWithFrame:CGRectMake(10, framet5.origin.y+75+45, FULL_WIDTH-15*2, 40)];
    adviseZY.text = @"质检专员:";
    adviseZY.font=[UIFont systemFontOfSize:14.0];
    [bgview addSubview:adviseZY];
    UITextField *adviseZYFT = [[UITextField alloc] initWithFrame:CGRectMake(90, framet5.origin.y+80+45, FULL_WIDTH-58*2, 30)];
    adviseZYFT.userInteractionEnabled = NO;
    adviseZYFT.layer.cornerRadius=5.0f;
    adviseZYFT.layer.masksToBounds=YES;
    adviseZYFT.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    adviseZYFT.layer.borderWidth= 1.0f;
    adviseZYFT.textColor=[UIColor lightGrayColor];
    adviseZYFT.font=[UIFont systemFontOfSize:17.0];
    adviseZYFT.text=self.specialModel.adviseZY;
    [bgview addSubview:adviseZYFT];

    
//    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg-page"]];

//    photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 250, 100, 100)];
//    photoImageView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:photoImageView];
    // Do any additional setup after loading the view.
}
/*
 已上报特殊问题编辑接口
 wsdl地址：	"http://192.168.10.149:8080/ysmr-pzgl/ws/jaxws/upload?wsdl"
 方法名：	"tswtsbView"
 Namespacacte：  "http://www.apl.com/webservice/upload"
 SOAPAction:	"tswtsbView"
 1个参数：	 id
 参数介绍：
 id:必填项,当前编辑特殊问题的id，如"215"
 
 返回值：	返回字符串"0"或"1","0"代表失败，"1"代表成功，picturestr表示图片base64字符串。 例如{"result":"1"},{"id":191,"name":"1","menu":"222","tspeople":"1","tsdepartmentid":10030,"tsdepartmentname":"信息部","picturestr":"IA=="}
 */
-(void)viewWillAppear:(BOOL)animated{
    //拿到id进来开始Soap请求图片数据
//    [self useAFNetWorking];
}

#pragma mark -- ASIHTTPRequest
-(void)useAFNetWorking
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:IMAGE_URL,self.specialModel.Hid]];
    
    NSLog(@"%@ -- ",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    [request startAsynchronous];
}
//
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"car info upload requestFinished");
    
//    NSArray *arrayRequest = (NSArray *)request;
//    
//    NSDictionary *dict = arrayRequest[1];
//    
//    NSLog(@"%@",dict);
    
    NSData *data = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *errorParse = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorParse];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
       
        //[self.tableview reloadData];
        
    }else{
        NSLog(@"An error happened while deserializing the JSON data.");
    }
    NSLog(@"%@",jsonObject);
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"car info upload requestFailed! Error: %@",request.error);
    
}



-(void)Soapbodyid{
    
    
    
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                         "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                         "<soap:Body>"
                         
                         "<n:tswtsbView xmlns:n=\"http://www.apl.com/webservice/upload\">"
                         "<id>%@</id>"
                         "</n:tswtsbView>"
                         
                         "</soap:Body>"
                         "</soap:Envelope>",self.specialModel.Hid
                         ];
    NSLog(@"soapMsg===%@",soapMsg);
    
    NSString *space=@"http://www.apl.com/webservice/upload";
    NSString *methodname=@"tswtsbView";
    NSURL *url=[NSURL URLWithString:@"http://180.153.43.39:8090/ysmr-pzgl/ws/jaxws/upload"];
    //    NSURL *url=[NSURL URLWithString:@"http://192.168.10.149:8080/ysmr-pzgl/ws/jaxws/upload?wsdl"];
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    NSString *soapAction=[NSString stringWithFormat:@"%@/%@",space,methodname];
    //头部设置
    NSDictionary *headField=[NSDictionary dictionaryWithObjectsAndKeys:[url host],@"Host",
                             @"text/xml; charset=utf-8",@"Content-Type",
                             msgLength,@"Content-Length",
                             soapAction,@"SoapException",nil];//SoapException
    [urlRequest setAllHTTPHeaderFields:headField];
    //超时设置
    [urlRequest setTimeoutInterval: 30 ];
    //访问方式
    [urlRequest setHTTPMethod:@"POST"];
    
    // 将字符串转换成数据
    urlRequest.HTTPBody = [soapMsg dataUsingEncoding:NSUTF8StringEncoding];
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
        if ([string isEqualToString:@"1"]) {
            NSLog(@"返回数据成功");
        }else{
        }
        
        [_infoArray addObject:string];
    }
}
//存储接收到的信息
//发现结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:_matchingElement]) {
        NSLog(@"解析出来的图片数据:===%@",_soapResults);
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
    else
    {
    }
    NSLog(@"图片array---%lu",(unsigned long)_infoArray.count);
    NSLog(@"图片array---%@",_infoArray);
}

-(void)searchprogram
{
    [self.navigationController popViewControllerAnimated:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
