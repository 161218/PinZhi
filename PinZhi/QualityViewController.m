//
//  QualityTwoViewController.m
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "QualityViewController.h"
#import "macro.h"
//#import "FriendGroup.h"
//#import "Friend.h"
//
//#import "ListViewController.h"
#import "MoreTableViewCell.h"
#import "ViewController.h"

#import "MJRefresh.h"

/**
 *  随机颜色
 */
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define BRAND_TOP_TAB_VIEW_HEIGHT 74.0/2
@interface QualityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_friendsData;
    //记录上次选中button
    //    UIButton*_lastBtn;
    UIButton *_wwcbtn;
    UIButton *_ywcbtn;
}
@property(nonatomic,strong)UITableView *tableview;
@property(strong,nonatomic)NSMutableArray *qualityArray;
@end

@implementation QualityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuaxin) name:@"success" object:nil];

     _qualityArray = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      //跳转界面
        if ([self userDefault]==YES)
        {
            UIViewController *tvc= [[ViewController alloc]init];
            UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:tvc];
            [self.navigationController presentViewController:homeNav animated:YES completion:nil];
        }
    });
    //_qualityArray.count
    // Do any additional setup after loading the view from its nib.
//    self.navigationItem.title = @"待    办";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    CGRect framed=CGRectMake(0,[[UIScreen mainScreen] applicationFrame].origin.y-10, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 30 -20);
    
    
    _tableview=[[UITableView alloc]initWithFrame:framed style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view addSubview:_tableview];
    
    labelBlack = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width/2-120, _tableview.size.height/3 - 50, 240, 60)];
    labelBlack.font=[UIFont systemFontOfSize:15.0f];
    labelBlack.textColor=[UIColor lightGrayColor];
    labelBlack.text = @"太棒了，待办任务都已完成！\n待办显示上级指示还没完成的任务。";
    labelBlack.textAlignment = NSTextAlignmentCenter;
    labelBlack.numberOfLines = 0;
    labelBlack.hidden = YES;
    [_tableview addSubview:labelBlack];
    
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
    [_wwcbtn addTarget:self action:@selector(renwubtn:) forControlEvents:UIControlEventTouchUpInside];
    _wwcbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _wwcbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    _wwcbtn.tag=101;
    [self.view addSubview:_wwcbtn];
    
    
    //今日 要替换新名字
    jinri=[[UILabel alloc]initWithFrame:CGRectMake(0, frameds.origin.y+7, width, 30)];
    jinri.text=@"时间：今日";
    [jinri setTextAlignment:NSTextAlignmentCenter];
    jinri.textColor=[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1];
    jinri.font=[UIFont systemFontOfSize:17.0f];
    [self.view addSubview:jinri];
    
    UIImageView *wwcView = [[UIImageView alloc] init];
    wwcView.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width/2 - 30, 22, 10, 5);
    wwcView.image = [UIImage imageNamed:@"arrow.png"];
    [self.view addSubview:wwcView];
    
    //已完成任务
    _ywcbtn=[[UIButton alloc]initWithFrame:CGRectMake(width+1,frameds.origin.y, width, 44)];
    _ywcbtn.backgroundColor = [UIColor whiteColor];
    [_ywcbtn setTitleColor:[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1] forState:0];
    [_ywcbtn addTarget:self action:@selector(renwubtn:) forControlEvents:UIControlEventTouchUpInside];
    _ywcbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _ywcbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    _ywcbtn.tag=102;
    [self.view addSubview:_ywcbtn];
    
    //全部 要替换新名字
    UILabel *quanbu=[[UILabel alloc]initWithFrame:CGRectMake(width, frameds.origin.y+7, width, 30)];
    quanbu.text=@"类型：全部";
    [quanbu setTextAlignment:NSTextAlignmentCenter];
    quanbu.textColor=[UIColor colorWithRed:251/255.0 green:93/255.0 blue:10/255.0 alpha:1];
    quanbu.font=[UIFont systemFontOfSize:17.0f];
    [self.view addSubview:quanbu];
    
    UIImageView *ywcView = [[UIImageView alloc] init];
    ywcView.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 30, 22, 10, 5);
    ywcView.image = [UIImage imageNamed:@"arrow.png"];
    [self.view addSubview:ywcView];
    
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-page"]];
//    self.tableview.backgroundView = view;
    
    
    _pickerbtn = [UIButton buttonWithType:0];
    [_pickerbtn addTarget:self action:@selector(pickerDismiss) forControlEvents:UIControlEventTouchUpInside];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,  [[UIScreen mainScreen] applicationFrame].size.height-244, [[UIScreen mainScreen] applicationFrame].size.width, 300)];
    
    _pickerViewTwo = [[UIPickerView alloc] initWithFrame:CGRectMake(0,  [[UIScreen mainScreen] applicationFrame].size.height-244, [[UIScreen mainScreen] applicationFrame].size.width, 300)];

    if (_qualityArray.count==0) {
        self.navigationItem.title = [NSString stringWithFormat:@"待    办 (0条)"];
    }
    
    // 1.集成刷新控件
//    [self addHeader];
//    [self addFooter];//需要接口参数
}

- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.tableview addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [vc useAFNetWorking];
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.tableview reloadData];
            // 结束刷新
            [vc.tableview headerEndRefreshing];
        });
    }];

    [self.tableview headerBeginRefreshing];
}

//- (void)addFooter
//{
//    __unsafe_unretained typeof(self) vc = self;
//    // 添加上拉刷新尾部控件
//    [self.tableview addFooterWithCallback:^{
//        // 进入刷新状态就会回调这个Block
//        
//            [vc.qualityArray addObject:MJRandomColor];
//        
//        // 模拟延迟加载数据，因此2秒后才调用）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [vc.tableview reloadData];
//            // 结束刷新
//            [vc.tableview footerEndRefreshing];
//        });
//    }];
//}
/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJCollectionViewController--dealloc---");
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
    
    _pickerbtn.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    [self.view addSubview:_pickerbtn];
    
    NSLog(@"点击了%ld",(long)btn.tag);
    if (btn.tag==101)
    {
        _pickerView.frame = CGRectMake(0,  [[UIScreen mainScreen] applicationFrame].size.height-244, [[UIScreen mainScreen] applicationFrame].size.width, 300);
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self.view.window addSubview:_pickerView];
        
    }
    else
    {
        _pickerViewTwo.frame = CGRectMake(0,  [[UIScreen mainScreen] applicationFrame].size.height-244, [[UIScreen mainScreen] applicationFrame].size.width, 300);
        _pickerViewTwo.delegate = self;
        _pickerViewTwo.dataSource = self;
        _pickerViewTwo.backgroundColor = [UIColor whiteColor];
        [self.view.window addSubview:_pickerViewTwo];
    }
}

#pragma mark- UITableViewDeledate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self userDefault]==YES) {
        return 0;
        
    }
    else
    {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _qualityArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellIdentifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    static NSString *cellIdentifier = @"cellIdentifier";
    __autoreleasing DaibanViewCell *cell = [[DaibanViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
//    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-page"]];
   
    QualityModel *quality = _qualityArray[indexPath.row];
    
//    cell.textLabel.text = quality.Fname;
//    cell.textLabel.numberOfLines=0;
//    [cell.textLabel sizeToFit];
    
    cell.nameLabel.text = quality.Fname;
    cell.nameLabel.adjustsFontSizeToFitWidth = YES;
    
    
    if (ScreenHeight>=736) { //6+
        UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,40, 100, 10 )];
        newLabel.font = [UIFont systemFontOfSize:13];
        newLabel.textColor = [UIColor lightGrayColor];
        newLabel.text =  [NSString stringWithFormat:@"%@",quality.EndDate];
        [cell addSubview:newLabel];
    }else{ //4  5 6
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,40, 100, 10 )];
    newLabel.font = [UIFont systemFontOfSize:13];
    newLabel.textColor = [UIColor lightGrayColor];
    newLabel.text =  [NSString stringWithFormat:@"%@",quality.EndDate];
    [cell addSubview:newLabel];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-003.png"]];
    imageView.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 70, 20, 40, 15);
    [cell addSubview:imageView];
    
    UIImageView *timeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_1"]];
    timeView.frame = CGRectMake(95, 40, 10, 10);
    [cell addSubview:timeView];
    
    labelBlack.frame = CGRectMake(500, 0, 0, 0);
    
    
    return cell;
}
//设置每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QualityModel *quality = _qualityArray[indexPath.row];
    
    QualityInfoViewController *viewController = [[QualityInfoViewController alloc] init];
    //未完成 已完成 任务数组
    viewController.useInfo = quality.Hid;
    viewController.useName = quality.Fname;
    
    viewController.selfTime = quality.EndDate;

    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark- UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == _pickerView)
    {
        return 3;
    }
    else
    {
        return 1;
    }
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView == _pickerView)
    {
        NSArray *array =@[@"今日",@"本周",@"本月"];
        _proNameStr = [array objectAtIndex:row];
        
        NSLog(@"[array objectAtIndex:row] -- %@",[array objectAtIndex:row]);
        jinri.text = [NSString stringWithFormat:@"时间：%@",[array objectAtIndex:row]];
        
        _timeString = [self getMonthBeginAndEndWith:nil andNumber:row];
        
        //目前先按一个接口一个参数走 需要三个参数
        [self addHeader];
    }
    else
    {
        _proNameStr =  @"全部";
        
        _timeString = nil;
        
        [self addHeader];
    }
    [pickerView removeFromSuperview];

}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == _pickerView)
    {
        NSArray *array =@[@"今日",@"本周",@"本月"];
        
        return array[row];
    }
    else
    {
        
        return @"全部";
    }
}

#pragma mark -- ASIHTTPRequest
-(void)useAFNetWorking
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *employeeid = [userDefault objectForKey:@"employeeid"];
    NSString *hotelid = [userDefault objectForKey:@"hotelid"];
    
    
    NSURL *url;
    
    if (_timeString == nil)
    {
        NSLog(@"1111%@",_timeString);
        
        url = [NSURL URLWithString:[NSString stringWithFormat:DAIBAN_URL,@"0",employeeid,hotelid]];
    }
    else
    {
        NSArray *array = [_timeString componentsSeparatedByString:@"&"];
        url = [NSURL URLWithString:[NSString stringWithFormat:DAIBAN_URL_NEW,employeeid,hotelid,@"0",array[0],array[1]]];
        NSLog(@"2222 -- %@",url);

    }
    
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
            
            QualityModel *quality = [[QualityModel alloc] init];
            
            [PinZhiDAO insertAMessage:quality];
            
            quality = [quality initWithAttributes:dict];
            
            NSLog(@"quality -- %@",quality);
            
            
            [_qualityArray addObject:quality];
            

        }
        
        NSLog(@"_qualityArray -- %lu",(unsigned long)_qualityArray.count);

        
        //任务数量
        if (_qualityArray.count==0) {
            self.navigationItem.title = [NSString stringWithFormat:@"待    办 (0条)"];
            labelBlack.hidden = NO;

        }else{
            self.navigationItem.title = [NSString stringWithFormat:@"待    办 (%lu条)",(unsigned long)_qualityArray.count];
            labelBlack.hidden = YES;
        }
        
    }else{
        
        
        NSLog(@"An error happened while deserializing the JSON data.");
    }
    
    NSLog(@"%@",[request responseString]);
}

- (void)requestFailed:(ASIHTTPRequest *)request{

    NSLog(@"car info upload requestFailed! Error: %@",request.error);
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    _pickerView.frame = CGRectMake(0, 1000, 0, 0);
    _pickerViewTwo.frame = CGRectMake(0, 1000, 0, 0);
    _pickerbtn.frame = CGRectMake(1000, 0, 40, 40);
    
    
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

-(void)pickerDismiss
{
    _pickerView.frame = CGRectMake(0, 1000, 0, 0);
    _pickerViewTwo.frame = CGRectMake(0, 1000, 0, 0);
    _pickerbtn.frame = CGRectMake(1000, 0, 40, 40);
    
}

- (NSString *)getMonthBeginAndEndWith:(NSDate *)newDate andNumber:(NSInteger)row
{
    if (newDate == nil) {
        newDate = [NSDate date];
    }
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    
    BOOL ok;
    if (row == 0)
    {
        ok = [calendar rangeOfUnit:NSCalendarUnitDay startDate:&beginDate interval:&interval forDate:newDate];
    }
    else if (row == 1)
    {
        ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    }
    else
    {
        ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    }
    
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    NSString *s = [NSString stringWithFormat:@"%@&%@",beginString,endString];
    NSLog(@"s---%@",s);
    
    return s;
}



-(void)shuaxin
{
}
-(void)viewWillAppear:(BOOL)animated
{
    [self addHeader];
    
}

@end
