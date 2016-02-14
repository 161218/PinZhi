//
//  ViewController.m
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "ViewController.h"
#import "QualityViewController.h"
#import "macro.h"
#import "Xml.h"

//#import "WodeViewController.h"
@interface ViewController ()
{
    MBProgressHUD *hud;
    
}
@property(nonatomic, strong)UITextField *userNameTextField;
@property(nonatomic, strong)UITextField *passwordTextField;
@property(nonatomic,strong)NSXMLParser *xmlParser;

@property (nonatomic) BOOL elementFound;
@property (strong, nonatomic) NSString *matchingElement;
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isFrist = NO;
    
    _infoArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Xml:) name:@"Xml" object:nil];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"用户登录";
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:RGBA(244, 243, 238, 1)];
    
    //     UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,20)];
    //     [rightButton setImage:[UIImage imageNamed:@"arrow-back.png"]forState:UIControlStateNormal];
    //     [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    //     UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    //     self.navigationItem.leftBarButtonItem= rightItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    //   self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg-page"]];
    
    [self addContent];
}

#pragma mark -post订单信息
-(void)Xml:(NSNotification *)text{
    
    _userInfoArray = text.userInfo[@"responseJSON"];
    
    [self userDefaults];
    
    [self.delegate loginSuccess];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mrak -
-(void)addContent {
    //
    CGRect frame1=CGRectMake((FULL_WIDTH-80)/2,10, 80, 80);
    //用户名输入框
    CGRect frame2=CGRectMake(30,frame1.origin.y+frame1.size.height+20, FULL_WIDTH-30*2, 50);
    CGRect frame2one=CGRectMake(10,10,20,25);
    CGRect frame2two=CGRectMake(40,0,FULL_WIDTH-40-30*2, 50);
    //密码输入框
    CGRect frame3=CGRectMake(30,frame2.origin.y+frame2.size.height+5, FULL_WIDTH-30*2, 50);
    CGRect frame3one=CGRectMake(10,15,25,15);
    CGRect frame3two=CGRectMake(40,0,FULL_WIDTH-40-30*2, 50);
    //登陆按钮
    CGRect frame4=CGRectMake(30,frame3.origin.y+frame3.size.height+10, FULL_WIDTH-30*2, 40);
    
    CGRect framed=CGRectMake(0, 64, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 44);
    
    UIButton *backgroundBtn = [UIButton buttonWithType:0];
    backgroundBtn.frame = framed;
    [backgroundBtn addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backgroundBtn];
    
    //工号：CCH-QS-001   杨可风 质量监察部 管理员  密码：cch400826
    //工号：CCH-RC-0002  徐进超  康乐部   专员     密码：cch400826
    //工号：CCH-FB-0001  蒋春辉  餐饮部 小组       密码：cch400826
    //
    UIView *username=[[UIView alloc]initWithFrame:frame2];
    username.layer.cornerRadius=5.0f;
    username.layer.masksToBounds=YES;
    username.layer.borderColor=[RGBA(220, 212, 197, 1.0) CGColor];
    username.layer.borderWidth= 1.0f;
    [self.view addSubview:username];
    
    UIImageView *imagename=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_login_user.png"]];
    imagename.frame=frame2one;
    [username addSubview:imagename];
    
    _userNameTextField = [[UITextField alloc] initWithFrame:frame2two];
    _userNameTextField.placeholder=@"用户名";
    //_userNameTextField.text=@"CCH-IT-0006";//CCH-FB-0001//CCH-IT-0006
    _userNameTextField.delegate=self;
    _userNameTextField.tag=101;
    if (self.Username) {
        _userNameTextField.text = self.Username;
    }
    [username addSubview:_userNameTextField];
    
    //密码
    UIView *pwdname=[[UIView alloc]initWithFrame:frame3];
    pwdname.layer.cornerRadius=5.0f;
    pwdname.layer.masksToBounds=YES;
    pwdname.layer.borderColor=[RGBA(220, 212, 197, 1.0) CGColor];
    pwdname.layer.borderWidth= 1.0f;
    [self.view addSubview:pwdname];
    
    UIImageView *imagepwd=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_login_pwd.png"]];
    imagepwd.frame=frame3one;
    [pwdname addSubview:imagepwd];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:frame3two];
    _passwordTextField.backgroundColor=[UIColor whiteColor];
    _passwordTextField.placeholder=@"密码";
    //_passwordTextField.text=@"123456";//cch400826//123456
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.delegate=self;
    [pwdname addSubview:_passwordTextField];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:frame4];
    [loginBtn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.masksToBounds=YES;
    loginBtn.layer.cornerRadius=5;
    loginBtn.backgroundColor=RGBA(251, 93, 10, 1);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
}

-(void)firstBtn
{
    [_passwordTextField resignFirstResponder];
    [_userNameTextField resignFirstResponder];
}
//登录
-(void)doLogin {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (self.userNameTextField.text.length <= 0)
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名有误!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
        return;
    }
    if (self.passwordTextField.text.length < 6)
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码有误!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
        return;
    }
    
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    _matchingElement = @"CheckLoginResult";
    
    //注意封装数据时 要定义转义符
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>\n"
                             
                             //封装好主要数据  其他部分都是死的
                             "<CheckLogin xmlns=\"http://outpre.4008266333.net/\">"
                             "<username>%@</username>"
                             "<pwd>%@</pwd>"
                             "</CheckLogin>"
                             
                             "</soap:Body>\n"
                             "</soap:Envelope>",self.userNameTextField.text,self.passwordTextField.text];
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
    
    //状态指示器
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在登录";
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
    
    _soapResults = nil;
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
        [_infoArray addObject:string];
        
    }
}
//{
//        if (_elementFound) {
//            [_soapResults appendString:string];
//        }
//        else
//        {
//            if (![string isEqualToString:@" "]) {
//                [_infoArray addObject:string];
//            }
//
//            if (_infoArray.count==8) {
//                [self userDefaults];
//            }
//
//        }
//
//    [self.delegate loginSuccess];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//存储接收到的信息
//发现结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    [hud hide:YES];
    
    if ([elementName isEqualToString:_matchingElement]) {
        NSLog(@"解析出来的数据:===%@",_soapResults);
        _elementFound = FALSE;
        dispatch_queue_t reentrantAvoidanceQueue = dispatch_queue_create("reentrantAvoidanceQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_async(reentrantAvoidanceQueue, ^{
            
            Xml *xml = [[Xml alloc] init];
            [xml xmlString:_soapResults];
            
        });
        
        dispatch_sync(reentrantAvoidanceQueue, ^{
            
            
        });
        
        
        
    }
    else
    {
    }
    
    
    
    NSLog(@"_infoArraydenglu---%lu",(unsigned long)_infoArray.count);
    NSLog(@"_infoArraydenglu---%@",_infoArray);
}
#pragma mark- 登录左上角返回
-(void)searchprogram{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark-
-(void)userDefaults{
    /*
     employeeid 10003473 员工id
     employeesn CCH-IT-0006 员工账号
     employeename 盛磊 员工姓名
     mobile 18957113301 手机号
     departmentid 10030 部门
     hotelid 1009 酒店编号
     */
    /*
     <XML><employeeid>10003473</employeeid> <employeesn>CCH-IT-0006</employeesn> <employeename>盛磊</employeename><mobile>18957113301</mobile><departmentid>10030</departmentid><departmentname>集团信息部</departmentname><hotelname>集团</hotelname><hotelid>1009</hotelid></XML>
     
     */
    NSString *password=self.passwordTextField.text;
    //登陆成功后把用户名和密码存储到UserDefault
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_userInfoArray[0] forKey:@"employeeid"];
    [userDefaults setObject:_userInfoArray[1] forKey:@"employeesn"];
    [userDefaults setObject:_userInfoArray[2] forKey:@"employeename"];
    [userDefaults setObject:_userInfoArray[3] forKey:@"mobile"];
    [userDefaults setObject:_userInfoArray[4] forKey:@"departmentid"];
    [userDefaults setObject:_userInfoArray[5] forKey:@"departmentname"];
    [userDefaults setObject:_userInfoArray[6] forKey:@"hotelname"];
    [userDefaults setObject:_userInfoArray[7] forKey:@"hotelid"];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"success" object:nil];
    
}
#pragma mark-UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _userNameTextField)
    {
        _passwordTextField.text = @"";
    }
    
    return YES;
}


@end