
//
//  ConfViewController.m
//  PinZhi
//
//  Created by 刘子阳 on 15/7/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "ConfViewController.h"
#import "macro.h"
#import "WoXMLRequest.h"
#import "MJRefresh.h"
#import "RSpecialViewController.h"
@interface ConfViewController ()<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>
{
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

@implementation ConfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _qualityArray = [[NSMutableArray alloc] init];
    self.title=@"我的上报";
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,20)];
    [rightButton setImage:[UIImage imageNamed:@"arrow-back.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg-page"]];
    
    
    CGRect framed=CGRectMake(0,[[UIScreen mainScreen] applicationFrame].size.height/2-300, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 30);
    
    //======
    self.tableview= [[UITableView alloc] initWithFrame:framed style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    //隐藏系统分割线
    //    wodeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-page"]];
    self.tableview.backgroundView = view;
    
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
    
    //
    CGRect frameds=CGRectMake(0,[[UIScreen mainScreen] applicationFrame].origin.y-20, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    CGFloat width = frameds.size.width / 2;
    
    //未完成任务
    _wwcbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, frameds.origin.y, width, 44)];
    _wwcbtn.backgroundColor = [UIColor whiteColor];
    [_wwcbtn setTitleColor:[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1] forState:0];
    [_wwcbtn setTitle:@"进行中" forState:UIControlStateNormal];
    [_wwcbtn addTarget:self action:@selector(renwubtn:) forControlEvents:UIControlEventTouchUpInside];
    _wwcbtn.tag=101;
    [self.view addSubview:_wwcbtn];
    UIImageView *wwcView = [[UIImageView alloc] init];
    wwcView.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width/2 - 40, 22, 10, 5);
    wwcView.image = [UIImage imageNamed:@"arrow.png"];
    [self.view addSubview:wwcView];
    
    //已完成任务
    _ywcbtn=[[UIButton alloc]initWithFrame:CGRectMake(width+1,frameds.origin.y, width, 44)];
    _ywcbtn.backgroundColor = [UIColor whiteColor];
    [_ywcbtn setTitleColor:[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1] forState:0];
    [_ywcbtn setTitle:@"完成" forState:UIControlStateNormal];
    [_ywcbtn addTarget:self action:@selector(renwubtn:) forControlEvents:UIControlEventTouchUpInside];
    _ywcbtn.tag=102;
    [self.view addSubview:_ywcbtn];
    UIImageView *ywcView = [[UIImageView alloc] init];
    ywcView.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 40, 22, 10, 5);
    ywcView.image = [UIImage imageNamed:@"arrow.png"];
    [self.view addSubview:ywcView];
    
    //
    [self addHeader];
}
- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.tableview addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        [vc useAFNetWorking];
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
        
    }
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
        [self.view addSubview:btnadd];
    }
    else
    {
        [btnadd removeFromSuperview];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //进入当前页面隐藏TabBar
    //    self.tabBarController.tabBar.frame = CGRectMake(FULL_WIDTH+10,FULL_HEIGHT+10,0, 0);
    //清除顶部
//    [bgdbview removeFromSuperview];
    
    
    
}
#pragma mark - UITableViewdelegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _qualityArray.count - 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-page"]];
    }
    
    SpecialModel *special = _qualityArray[indexPath.row];
    cell.textLabel.text = special.name;
    
    
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
    
    //    QualityModel *quality = _qualityArray[indexPath.row];
    //    QualityInfoViewController *viewController = [[QualityInfoViewController alloc] init];
    //    //未完成 已完成 任务数组
    //    viewController.useInfo= quality.Hid;
    //    [self.navigationController pushViewController:viewController animated:YES];
    
    RSpecialViewController *vc=[[RSpecialViewController alloc]init];
    vc.specialModel = _qualityArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:NO];
}
#pragma mark -- ASIHTTPRequest
-(void)useAFNetWorking
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *employeeid = [userDefault objectForKey:@"employeeid"];
    //    NSString *hotelid = [userDefault objectForKey:@"hotelid"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:SAHNGBAO_URL,employeeid]];
    
    NSLog(@"%@ -- ",url);
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
            
            NSLog(@"dictionary -- %@",dict);
            
            
            SpecialModel *special = [[SpecialModel alloc] init];
            special = [special initWithAttributes:dict];
            
            
            [_qualityArray addObject:special];
        }
        
        NSLog(@"_qualityArray -- %lu",(unsigned long)_qualityArray.count);
        
        //        [self.tableview reloadData];
        
    }else{
        NSLog(@"An error happened while deserializing the JSON data.");
    }
    
    NSLog(@"%@",[request responseString]);
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"car info upload requestFailed! Error: %@",request.error);
    
}


#pragma mark -
-(void)searchprogram
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
