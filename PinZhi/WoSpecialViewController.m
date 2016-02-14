//
//  WoSpecialViewController.m
//  PinZhi
//
//  Created by 刘子阳 on 15/7/20.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "WoSpecialViewController.h"
#import "ViewController.h"
#import "MJRefresh.h"
#import "macro.h"

@interface WoSpecialViewController ()<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>
{
    //记录上次选中button
    //    UIButton*_lastBtn;
    UIButton *_wwcbtn;
    UIButton *_ywcbtn;
}
@property(nonatomic,strong)UITableView *tableview;
@property(strong,nonatomic)NSMutableArray *qualityArray;



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

@implementation WoSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _infoArray = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view from its nib.
    _qualityArray = [[NSMutableArray alloc] init];
    if ([self userDefault]==YES)
    {
        UIViewController *tvc= [[ViewController alloc]init];
        UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:tvc];
        [self.navigationController presentViewController:homeNav animated:YES completion:nil];
    }
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,20)];
    [rightButton setImage:[UIImage imageNamed:@"arrow-back.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
    
    
    CGRect framed=CGRectMake(0,[[UIScreen mainScreen] applicationFrame].origin.y-10, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 30);
    
    _tableview=[[UITableView alloc]initWithFrame:framed style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view addSubview:_tableview];
    
    /*================================================================================*/
    //返回顶部
    CGRect fhamed=CGRectMake([[UIScreen mainScreen] applicationFrame].size.width-65,[[UIScreen mainScreen] applicationFrame].size.height-150, 50,50);
    //button
    btnadd=[[UIButton alloc]initWithFrame:fhamed];
    [btnadd setBackgroundImage:[UIImage imageNamed:@"back_top_icon"] forState:UIControlStateNormal];
    [btnadd addTarget:self action:@selector(dingbubtn) forControlEvents:UIControlEventTouchUpInside];
    
    //    [bgdbview addSubview:imageview];
    /*================================================================================*/
    
    //
    CGRect frameds=CGRectMake(0,[[UIScreen mainScreen] applicationFrame].origin.y-20, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    CGFloat width = frameds.size.width / 2;
    
    //未完成任务
    _wwcbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, frameds.origin.y, width, 44)];
    _wwcbtn.backgroundColor = [UIColor whiteColor];
//    [_wwcbtn setTitleColor:[UIColor blackColor] forState:normal];
    [_wwcbtn setTitleColor:[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1] forState:0];
    [_wwcbtn setTitle:@"进行中" forState:UIControlStateNormal];
    [_wwcbtn addTarget:self action:@selector(renwubtn:) forControlEvents:UIControlEventTouchUpInside];
    _wwcbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _wwcbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    _wwcbtn.tag=101;
    [self.view addSubview:_wwcbtn];
    
    
    //今日 要替换新名字
//    jinri=[[UILabel alloc]initWithFrame:CGRectMake(_wwcbtn.size.width - 60, frameds.origin.y+7, width/3, 30)];
//    jinri.text=@"进行中";
//    jinri.textColor=[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1];
//    jinri.font=[UIFont systemFontOfSize:14.0f];
//    [self.view addSubview:jinri];
    
//    UIImageView *wwcView = [[UIImageView alloc] init];
//    wwcView.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width/2 - 40, 22, 10, 5);
//    wwcView.image = [UIImage imageNamed:@"arrow.png"];
//    [self.view addSubview:wwcView];
    
    //已完成任务
    _ywcbtn=[[UIButton alloc]initWithFrame:CGRectMake(width+1,frameds.origin.y, width, 44)];
    _ywcbtn.backgroundColor = [UIColor whiteColor];
     [_ywcbtn setTitleColor:[UIColor lightGrayColor] forState:normal];
    [_ywcbtn setTitle:@"完成" forState:UIControlStateNormal];
    [_ywcbtn addTarget:self action:@selector(renwubtn:) forControlEvents:UIControlEventTouchUpInside];
    _ywcbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _ywcbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    _ywcbtn.tag=102;
    [self.view addSubview:_ywcbtn];
    
//    if (_qualityArray.count==0) {
//        self.navigationItem.title = [NSString stringWithFormat:@"我的上报 (0条)"];
//    }

    
    //全部 要替换新名字
//    UILabel *quanbu=[[UILabel alloc]initWithFrame:CGRectMake(_ywcbtn.size.width*2 - 60, frameds.origin.y+7, width/3, 30)];
//    quanbu.text=@"完成";
//    quanbu.textColor=[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1];
//    quanbu.font=[UIFont systemFontOfSize:14.0f];
//    [self.view addSubview:quanbu];
    
//    UIImageView *ywcView = [[UIImageView alloc] init];
//    ywcView.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 40, 22, 10, 5);
//    ywcView.image = [UIImage imageNamed:@"arrow.png"];
//    [self.view addSubview:ywcView];
    
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-page"]];
//    self.tableview.backgroundView = view;
    
//    // 1.集成刷新控件
    [self addHeader];
//    //    [self addFooter];//需要接口参数
}
- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.tableview addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [_wwcbtn setTitleColor:[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1] forState:0];
        [_ywcbtn setTitleColor:[UIColor lightGrayColor] forState:0];
        [vc useAFNetWorking:@"0"];
        NSLog(@"_qualityArray.count -- %lu",(unsigned long)_qualityArray.count);
        
        
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.tableview reloadData];
            // 结束刷新
            [vc.tableview headerEndRefreshing];
        });
    }];

    [self.tableview headerBeginRefreshing];
}
/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJCollectionViewController--dealloc---");
}

-(void)viewWillAppear:(BOOL)animated{
    // 1.集成刷新控件
//    [self addHeader];
    //    [self addFooter];//需要接口参数
}

#pragma mark -返回顶部
-(void)dingbubtn{
    NSLog(@"点击了返回顶部");
    [self.tableview setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark 返回顶部
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 88)
    {
        //        [UIView beginAnimations:nil context:nil]; // 开始动画
        //        [UIView setAnimationDuration:10.0]; // 动画时长
        //        /**
        //         **  图像向下移动
        //         **/
        //        CGPoint point = bgdbview.center;
        //        point.y = -20;
        //        [bgdbview setCenter:point];
        //        [UIView commitAnimations]; // 提交动画
        [self.view addSubview:btnadd];
    }
    else
    {
        [btnadd removeFromSuperview];
    }
}

#pragma mark - 判断是否写入过账号密码
-(BOOL)userDefault{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *employeeid = [userDefault objectForKey:@"employeeid"];
    if(employeeid==nil)
    {
        return YES;
    }
    else{
        return NO;
    }
}
#pragma mark - 未完成  已完成
-(void)renwubtn:(UIButton *)btn
{
    NSLog(@"点击了%ld",(long)btn.tag);
    if (btn.tag==101)
    {
        [self useAFNetWorking:@"0"];
        [_qualityArray removeAllObjects];
        [_wwcbtn setTitleColor:[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1] forState:0];
        [_ywcbtn setTitleColor:[UIColor lightGrayColor] forState:0];
    }else{
        [self useAFNetWorking:@"1"];
        [_qualityArray removeAllObjects];
        [_ywcbtn setTitleColor:[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1] forState:0];
        [_wwcbtn setTitleColor:[UIColor lightGrayColor] forState:0];
        
    }
    
}

#pragma mark - UITableViewdelegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _qualityArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
    }
    
    SpecialModel *special = _qualityArray[indexPath.row];
    cell.textLabel.text = special.name;
    
    if (ScreenHeight>=736) { //6+
        UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,38, 120, 10 )];
        newLabel.font = [UIFont systemFontOfSize:13];
        newLabel.textColor = [UIColor lightGrayColor];
        newLabel.text =  [NSString stringWithFormat:@"%@",special.insertTime];
        [cell addSubview:newLabel];
    }else{ //4  5 6
        UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,38, 120, 10 )];
        newLabel.font = [UIFont systemFontOfSize:13];
        newLabel.textColor = [UIColor lightGrayColor];
        newLabel.text =  [NSString stringWithFormat:@"%@",special.insertTime];
        [cell addSubview:newLabel];
    }
    //        //    //任务数量
    if (_qualityArray.count==0) {
        self.navigationItem.title = [NSString stringWithFormat:@"我的上报 (%lu条)",(unsigned long)_qualityArray.count];
    }else{
        self.navigationItem.title = [NSString stringWithFormat:@"我的上报 (%lu条)",(unsigned long)_qualityArray.count];
    }
//    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(16,40, 200, 10 )];
//    newLabel.font = [UIFont systemFontOfSize:13];
//    newLabel.textColor = [UIColor lightGrayColor];
//    newLabel.text =  [NSString stringWithFormat:@"截止：%@",quality.EndDate];
//    [cell addSubview:newLabel];
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-003.png"]];
//    imageView.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 70, 15, 50, 20);
//    [cell addSubview:imageView];
    
    return cell;
}
//设置每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSpecialViewController *vc=[[RSpecialViewController alloc]init];
    vc.specialModel = _qualityArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:NO];
}


#pragma mark -- ASIHTTPRequest
-(void)useAFNetWorking:(NSString *)string
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *employeeid = [userDefault objectForKey:@"employeeid"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:SAHNGBAO_URL,employeeid,string]];
    
    NSLog(@"我的上报 返回数据===%@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    [request startAsynchronous];
}
//
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"car info upload requestFinished");
    
    [_qualityArray removeAllObjects];
    
    NSData *data = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *errorParse = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorParse];
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSLog(@"dictionary");
        NSArray *arrayRequest = (NSArray *)jsonObject;
        
        for (int i = 1; i < arrayRequest.count;i++)
        {
            NSDictionary *dict = arrayRequest[i];
            
            NSLog(@"dictionary1 -- %@",dict);
            
            
            SpecialModel *special = [[SpecialModel alloc] init];
            special = [special initWithAttributes:dict];

            
            [_qualityArray addObject:special];
        }
        
       //    //任务数量
//            if (_qualityArray.count==0) {
//                self.navigationItem.title = [NSString stringWithFormat:@"我的上报 (%lu条)",(unsigned long)_qualityArray.count];
//            }else{
//                self.navigationItem.title = [NSString stringWithFormat:@"我的上报 (%lu条)",(unsigned long)_qualityArray.count];
//            }
        
        NSLog(@"_qualityArray -- %lu",(unsigned long)_qualityArray.count);
        
    }else{
        NSLog(@"An error happened while deserializing the JSON data.");
    }
    
    [_tableview reloadData];
    
    NSLog(@"%@",[request responseString]);
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"car info upload requestFailed! Error: %@",request.error);
    
}

#pragma mark -- time
-(BOOL)moreTimer:(NSString *)time
{
    //到期时间
    NSString* string2 = time;
    NSDateFormatter *inputFormatter2 = [[NSDateFormatter alloc] init];
    [inputFormatter2 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate2 = [inputFormatter2 dateFromString:string2];
    NSLog(@"date = %@", inputDate2);
    
    NSDate *now = [NSDate date];
    NSLog(@"now = %@", now);
    
    BOOL sameDate = [now isEqualToDate:now];
    
    return sameDate;
}
-(void)searchprogram{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
