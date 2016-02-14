//
//  QualityInfoViewController.m
//  PinZhi
//
//  Created by HUPU on 15/7/7.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "QualityInfoViewController.h"

#define Alter0 @"无网络"
#define Alter1 @"当前为2G网络,确认提交？"
#define Alter2 @"当前为3G网络,确认提交？"
#define Alter3 @"当前为4G网络,确认提交？"
#define Alter5 @"当前为WIfi网络,确认提交？"
@interface QualityInfoViewController ()


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

@implementation QualityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    _taskformidArray = [[NSMutableArray alloc] init];
    _indexidsArray = [[NSMutableArray alloc] init];
    _indexvaluesArray = [[NSMutableArray alloc] init];
    _indexmenusArray = [[NSMutableArray alloc] init];
    _imagesArray = [[NSMutableArray alloc] init];
    _photoViewArray = [[NSMutableArray alloc] init];
    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,20)];
    [rightButton setImage:[UIImage imageNamed:@"arrow-back.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
    self.title = self.useName;
    /*================================================================================*/
    //返回顶部
    CGRect fhamed=CGRectMake([[UIScreen mainScreen] applicationFrame].size.width-65,[[UIScreen mainScreen] applicationFrame].size.height-150, 50,50);
    //image UIbutton 坐标
    //    CGRect framed2=CGRectMake(0,[[UIScreen mainScreen] applicationFrame].size.height-130, 50,50);
    //
    //    bgdbview=[[UIView alloc]initWithFrame:fhamed];
    //iamge
    //    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back_top_icon"]];
    //    imageview.frame=framed2;
    //button
    btnadd=[[UIButton alloc]initWithFrame:fhamed];
    [btnadd setBackgroundImage:[UIImage imageNamed:@"back_top_icon"] forState:UIControlStateNormal];
    [btnadd addTarget:self action:@selector(dingbubtn) forControlEvents:UIControlEventTouchUpInside];
    
    //    [bgdbview addSubview:imageview];
    /*================================================================================*/
    _indexPath = -1;
    _section = -1;
    
    _qualityArray = [[NSMutableArray alloc] init];
    
    _qualityDict = [[NSMutableDictionary alloc] init];

    _btnArray = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 93) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, 40)];
    self.tableView.rowHeight = 40;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self useAFNetWorking];
    
    
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-page"]];
//    self.tableView.backgroundView = view;

    // Do any additional setup after loading the view.
}
#pragma mark -确认提交事件
-(void)tijiaobtn{
    
    BOOL yes = [self moreTimer:self.selfTime];

//    if (yes == NO)
//    {
//        
//        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示:" message:@"任务已过期" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//        alter.tag = 741;
//        [alter show];
//        return;
//    }
    
    for (int i = 0; i < _btnArray.count; i++)
    {
        [(UITextView *)[self.tableView viewWithTag:2000 + i] resignFirstResponder];
    }

    
     //状态栏是由当前app控制的，首先获取当前app
    //type数字对应的网络状态依次是 ： 0 - 无网络 ; 1 - 2G ; 2 - 3G ; 3 - 4G ; 5 - WIFI
   UIApplication *app = [UIApplication sharedApplication];
   
   NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
   
   int type = 0;
   for (id child in children)
   {
   if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                  type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
             }
     }
    NSLog(@"----%d", type);
   
        if (type==0) {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"表单一经提交,不能更改。" message:@"是否提交?" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            alter.tag=111;
            [alter show];
        }else if (type==1){
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"表单一经提交，不能更改。" message:@"是否提交?" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            alter.tag=111;
            [alter show];
        }else if (type==2){
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"表单一经提交,不能更改。" message:@"是否提交?" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            alter.tag=111;
            [alter show];
        }else if (type==3){
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"表单一经提交,不能更改。" message:@"是否提交?" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            alter.tag=111;
            [alter show];
        }else{
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"表单一经提交,不能更改。" message:@"是否提交?" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            alter.tag=111;
            [alter show];
        }
}
#pragma mark-UIAlertViewdeleget
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag==111) {
//        if (buttonIndex==0)
//        {
//            //提交
//            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"是否确认提交" message:nil delegate:self cancelButtonTitle:@"确认提交" otherButtonTitles:@"检查一下", nil];
//            alter.tag=120;
//            [alter show];
//        }
//    }
//    else
//    {
    
    if (alertView.tag==111) {
        
    
    
        if (buttonIndex==0)
        {
            //
            if (alertView.tag == 741)
            {
                return;
            }
            
            
            NSLog(@"_indexvaluesArray --- %@ -- %@ -- %@ -- %@",_indexidsArray,_indexvaluesArray,_indexmenusArray,_imagesArray);
            
            self.taskformid = self.useInfo;
            NSString *indexids = @"";
            NSString *indexvalues = @"";
            NSString *indexmenus = @"";
            NSString *images = @"";
            
            
            for (int i = 0; i < _btnArray.count; i++)
            {
                if (i == 0 )
                {
                    indexids = [NSString stringWithFormat:@"%@",_indexidsArray[i]];
                    
                    NewButton* yesOrNoBtn = _indexvaluesArray[i];
                    indexvalues = [NSString stringWithFormat:@"%@",yesOrNoBtn.isOne];
                    
                    indexmenus = [NSString stringWithFormat:@"%@",_indexmenusArray[i]];
                    
                    images = [NSString stringWithFormat:@"%@",_imagesArray[i]];
                    
                }
                else
                {
                    indexids = [NSString stringWithFormat:@"%@,%@",indexids,_indexidsArray[i]];
                    
                    NewButton* yesOrNoBtn = _indexvaluesArray[i];
                    indexvalues = [NSString stringWithFormat:@"%@,%@",indexvalues,yesOrNoBtn.isOne];
                    
                    indexmenus = [NSString stringWithFormat:@"%@,%@",indexmenus,_indexmenusArray[i]];
                    
                    images = [NSString stringWithFormat:@"%@,%@",images,_imagesArray[i]];
                }
                
            }
            //
            footBtn.userInteractionEnabled=NO;
            [self.view.window showHUDWithText:@"正在提交" Type:ShowLoading Enabled:YES];
            
            NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 "<soap:Body>"
                                 
                                 "<n:fillForm xmlns:n=\"http://www.apl.com/webservice/upload\">"
                                 "<taskformid>%@</taskformid>"
                                 "<indexids>%@</indexids>"
                                 "<indexvalues>%@</indexvalues>"
                                 "<indexmenus>%@</indexmenus>"
                                 "<images>%@</images>"
                                 "</n:fillForm>"
                                 
                                 "</soap:Body>"
                                 "</soap:Envelope>",self.taskformid,indexids,indexvalues,indexmenus,images
                                 ];
            NSLog(@"soapMsg===%@",soapMsg);
            
            NSString *space=@"http://www.apl.com/webservice/upload";
            NSString *methodname=@"fillForm";
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
    }
//    }

}



- (NSString *)base64Encode:(NSString *)str
{
    // 1. 将字符串转换成二进制数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    // 2. 对二进制数据进行base64编码
    NSString *result = [data base64EncodedStringWithOptions:0];
    
    NSLog(@"base464—> %@", result);
    return result;
}



#pragma mark -返回顶部
-(void)dingbubtn{
    NSLog(@"点击了返回顶部");
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark 返回顶部
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 88)
    {
        [self.view addSubview:btnadd];
    }
    else
    {
        [btnadd removeFromSuperview];
    }
}

-(void)useAFNetWorking
{
    //= quality.Fname;
    NSLog(@"_useInfo -- %@",_useInfo);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:ZHIJIAN_URL,_useInfo]];
    NSLog(@"url -- %@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    [_indexvaluesArray removeAllObjects];
    NSLog(@"car info upload requestFinished");
    NSData *data = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *errorParse = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorParse];
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSLog(@"dictionary");
        NSArray *arrayRequest = (NSArray *)jsonObject;
        
        for (int i = 1; i < arrayRequest.count;i++)
        {
            NSDictionary *dict = arrayRequest[i];
            
            NSLog(@"dictionary -- %@",dict);

            QualityModel *quality = [[QualityModel alloc] init];
            
            quality = [quality initWithAttributes:dict];
            
            NSLog(@"quality -- %@",quality);

            [_indexidsArray addObject:quality.Code];
            
            
            [_indexmenusArray addObject:@" "];
            
            [_imagesArray addObject:@" "];
            
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(160, 40, 60, 40)];
            [_photoViewArray addObject:imageview];
            
            [_qualityArray addObject:quality];
            
            [_btnArray addObject:@"1"];
            
            
            NewButton* yesOrNoBtn = [NewButton buttonWithType:0];
            [yesOrNoBtn setFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 80, 10, 60, 34)];
            [yesOrNoBtn addTarget:self action:@selector(moreInfo:) forControlEvents:UIControlEventTouchUpInside];
            yesOrNoBtn.layer.cornerRadius=5.0f;
            yesOrNoBtn.layer.masksToBounds=YES;
            [_indexvaluesArray addObject:yesOrNoBtn];
            
            
            
            //
            footBtn = [UIButton buttonWithType:0];
            footBtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1];
            footBtn.frame = CGRectMake(20, 10, [[UIScreen mainScreen] applicationFrame].size.width - 40, 40);
            footBtn.layer.cornerRadius=5.0f;
            footBtn.layer.masksToBounds=YES;
            [footBtn setTitle:@"确认提交" forState:UIControlStateNormal];
            [footBtn addTarget:self action:@selector(tijiaobtn) forControlEvents:UIControlEventTouchUpInside];
            [self.tableView.tableFooterView addSubview:footBtn];
        }
        
        [self.tableView reloadData];
        

    }else{
        NSLog(@"An error happened while deserializing the JSON data.");
    }

    NSLog(@"%@",[request responseString]);
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"car info upload requestFailed! Error: %@",request.error);
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _qualityArray.count;
}
//设置每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_btnArray.count > 0 && [_btnArray[indexPath.row] isEqualToString:@"2"])
    {
        return 215;
    }
    else
    {
        return 55;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    __autoreleasing MoreTableViewCell *cell = [[MoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.yesOrNoBtn.tag = indexPath.row +1;
    
    QualityModel *quality = _qualityArray[indexPath.row];    
    
    cell.nameLabel.text =quality.Name;
//    cell.nameLabel.numberOfLines=0;
//    [cell.nameLabel sizeToFit];
    cell.nameLabel.adjustsFontSizeToFitWidth = YES;
    
    cell.clipsToBounds = YES;
    
    cell.informationTF.tag = 2000 + indexPath.row;
    cell.informationTF.delegate = self;
    cell.informationTF.text = _indexmenusArray[indexPath.row];
    
    
    [cell.picBtn addTarget:self action:@selector(pickerBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.picBtn.tag = 1000 + indexPath.row;
    
    NewButton* yesOrNoBtn = _indexvaluesArray[indexPath.row];
    
    NSLog(@"_btnArray -- %lu",(unsigned long)_btnArray.count);
    
    if ( _btnArray.count > 0 && [_btnArray[indexPath.row] isEqualToString:@"2"])
    {
        yesOrNoBtn.backgroundColor = [UIColor redColor];
        [yesOrNoBtn setTitle:@"不合格" forState:0];
        yesOrNoBtn.isOne = @"2";
        
        
    }
    else if(_btnArray.count > 0 && [_btnArray[indexPath.row] isEqualToString:@"3"])
    {
        yesOrNoBtn.backgroundColor = [UIColor colorWithRed:128/255.0 green:132/255.0 blue:132/255.0 alpha:1];
        [yesOrNoBtn setTitle:@"不适用" forState:0];
        yesOrNoBtn.isOne = @"3";
    }
    else
    {
        yesOrNoBtn.backgroundColor = [UIColor colorWithRed:73/255.0 green:169/255.0 blue:104/255.0 alpha:1];
        [yesOrNoBtn setTitle:@"合格" forState:0];
        yesOrNoBtn.isOne = @"1";
        
    }
    yesOrNoBtn.tag = indexPath.row+100;
    [cell addSubview:yesOrNoBtn];
    
    UIImageView *imageView = _photoViewArray[indexPath.row];
    imageView.frame = CGRectMake(170, 55, 80, 40);
    [cell addSubview:imageView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    _indexPath = (int)indexPath.row;
//    _section = (int)indexPath.section;
//    
//    NewButton *btn = _indexvaluesArray[indexPath.row];
//    
//    if ([btn.isOne isEqualToString:@"1"])
//    {
//        _indexPath = (int)btn.tag - 100;
//        
//        [self.tableView reloadData];
//        
//        [_btnArray replaceObjectAtIndex:_indexPath withObject: @"2"];
//        
//    }
//    else if ([btn.isOne isEqualToString:@"2"])
//    {
//        _indexPath = -1;
//        
//        [self.tableView reloadData];
//        
//        [_btnArray replaceObjectAtIndex:(int)btn.tag - 100 withObject: @"3"];
//    }
//    else
//    {
//        _indexPath = -1;
//        
//        [self.tableView reloadData];
//        
//        [_btnArray replaceObjectAtIndex:(int)btn.tag - 100 withObject: @"1"];
//        
//    }
//
//    
//    
//    [self.tableView reloadData];

}

//btn方法
-(void)moreInfo:(NewButton *)btn
{
    NSLog(@"btn -- %ld",(long)btn.tag);
    
    if ([btn.isOne isEqualToString:@"1"])
    {
        _indexPath = (int)btn.tag - 100;
        
        [self.tableView reloadData];

        [_btnArray replaceObjectAtIndex:_indexPath withObject: @"2"];

    }
    else if ([btn.isOne isEqualToString:@"2"])
    {
        _indexPath = -1;
        
        [self.tableView reloadData];
        
        [_btnArray replaceObjectAtIndex:(int)btn.tag - 100 withObject: @"3"];
    }
    else
    {
        _indexPath = -1;
        
        [self.tableView reloadData];
        
        [_btnArray replaceObjectAtIndex:(int)btn.tag - 100 withObject: @"1"];

    }
    
}



#pragma mark-确认提交 代理方法
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
    NSLog(@"待办子页面数据%@", theXML);
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
            //上传成功
            footBtn.userInteractionEnabled=YES;
            
            [self.view.window showHUDWithText:@"提交成功" Type:ShowPhotoYes Enabled:YES];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }else{
             footBtn.userInteractionEnabled=YES;
            [self.view.window showHUDWithText:@"提交失败" Type:ShowPhotoNo Enabled:YES];
        }
        
        [_infoArray addObject:string];
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
    else
    {
    }
    
    //    NSLog(@"_infoArray---%lu",(unsigned long)_infoArray.count);
    //    NSLog(@"_infoArray---%@",_infoArray);
}


-(void)pickerBtn:(UIButton *)btn
{
    
    _imagesTag = (int)btn.tag - 1000;
        
    
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择",@"拍照", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    [sheet showInView:self.view];
}

#pragma mark-
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
    }
    
    switch (buttonIndex) {
        case 0:
            // 取消
            return;
        case 1:
            // 相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        case 2:
            // 相机
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
    }
    
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = NO;
    
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
    
    
    
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
//    ((UIImageView *)[self.tableView viewWithTag:_imagesTag+3000]).image = image;
    
    UIImageView *imageView = _photoViewArray[_imagesTag];
    imageView.image = image;
    
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    
    [_imagesArray replaceObjectAtIndex:_imagesTag withObject:encodedImageStr];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


//
-(void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [textView.text stringByReplacingOccurrencesOfString:@"," withString:@"，"];
    
    [_indexmenusArray  replaceObjectAtIndex:(textView.tag - 2000) withObject:textView.text];
    
    NSLog(@"textViewDidEndEditing --- %ld",(long)textView.tag);
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark -- time
-(BOOL)moreTimer:(NSString *)time
{
    //到期时间
    NSString* string2 = time;
    NSDateFormatter *inputFormatter2 = [[NSDateFormatter alloc] init];
    [inputFormatter2 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate2 = [inputFormatter2 dateFromString:string2];
    NSLog(@"date = %@", inputDate2);
    
    NSDate *now = [NSDate date];
    NSLog(@"now = %@", now);
    
    NSDate *sameDate = [now laterDate:inputDate2];
    
    if ([now isEqualToDate:sameDate] && ![now isEqualToDate:inputDate2])
    {
        return NO;

    }
    else
    {
        return YES;
    }
    
    
    
}


#pragma mark-
-(void)searchprogram{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
