
//
//  WodeViewController.m
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "WodeViewController.h"
#import "macro.h"
#import "XMLRequest.h"
#import "XMLRequestTwo.h"
#import "UIBarButtonItem+Badge.h"//角标

#import "ViewController.h"
#import "ViewController.h"
#import "MessageViewController.h"
#import "WoSpecialViewController.h"
@interface WodeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,LoginViewController>
{
    UITableView *wodeTableView;
    UIView *userInfoView;
    
    UIButton* btnNextPage;//
}
@end

@implementation WodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"RELOADVOEWNOTIFICATION" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi2:) name:@"RELOADVOEWNOTIFICATIIN" object:nil];
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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我    的";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    //去除下个页面系统导航自带的文字并显示为白色
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = item;
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    // Build your regular UIBarButtonItem with Custom View
//    UIImage *image = [UIImage imageNamed:@"phone.png"];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0,0,image.size.width, image.size.height);
//    [button addTarget:self action:@selector(searchprogram) forControlEvents:UIControlEventTouchDown];
//    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    // Make BarButton Item
//    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = navLeftButton;
//    self.navigationItem.rightBarButtonItem.badgeValue = @"1";
//    self.navigationItem.rightBarButtonItem.badgeBGColor = self.navigationController.navigationBar.tintColor;

    //======
    wodeTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 44) style:UITableViewStylePlain];
    wodeTableView.delegate = self;
    wodeTableView.dataSource = self;
    //隐藏系统分割线
//    wodeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置Tableview 不能滚动
    [wodeTableView setScrollEnabled:NO];
    [self.view addSubview:wodeTableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, [[UIScreen mainScreen] applicationFrame].size.width-100, 130)];
    imageView.image = [UIImage imageNamed:@"card-002"];
    [self.view addSubview:imageView];
    
    userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, [[UIScreen mainScreen] applicationFrame].size.width, 80)];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    [moneyLabel setFrame:CGRectMake(0, 20, [[UIScreen mainScreen] applicationFrame].size.width, 20)];
    [moneyLabel setTextColor:[UIColor whiteColor]];
    [moneyLabel setTextAlignment:NSTextAlignmentCenter];
    [moneyLabel setBackgroundColor:[UIColor clearColor]];
    [moneyLabel setTag:102];
    [userInfoView addSubview:moneyLabel];
    
    //员工姓名
    UILabel *phone = [[UILabel alloc] init];
    [phone setTextColor:[UIColor blackColor]];
    [phone setFrame:CGRectMake(20,0, [[UIScreen mainScreen] applicationFrame].size.width, 20)];
    [phone setTextAlignment:NSTextAlignmentCenter];
    [phone setFont:[UIFont fontWithName:@"Helvetica" size:25.0]];
    [phone setTag:103];
    [userInfoView addSubview:phone];
    //员工部门
    UILabel *jishubm = [[UILabel alloc] init];
    [jishubm setTextColor:[UIColor blackColor]];
    [jishubm setFrame:CGRectMake(18,30, [[UIScreen mainScreen] applicationFrame].size.width, 20)];
    [jishubm setTextAlignment:NSTextAlignmentCenter];
    [jishubm setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    [jishubm setTag:110];
    [userInfoView addSubview:jishubm];
    //酒店名字
    UILabel *jiudianName = [[UILabel alloc] init];
    [jiudianName setTextColor:[UIColor blackColor]];
    [jiudianName setFrame:CGRectMake(70,70, [[UIScreen mainScreen] applicationFrame].size.width - 140, 25)];
    [jiudianName setTextAlignment:NSTextAlignmentCenter];
    [jiudianName setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    [jiudianName setTag:111];
    [userInfoView addSubview:jiudianName];
    
    //登录
//    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    loginButton.backgroundColor=RGBA(251, 93, 10, 1);
//    [loginButton setFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width/2 - 80, 60, 160, 40)];
//    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
//    loginButton.layer.cornerRadius=5.0f;
//    loginButton.layer.masksToBounds=YES;
//    [loginButton setTag:100];
//    [loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [userInfoView addSubview:loginButton];
    
//Tableview 顶部
    wodeTableView.tableHeaderView =[[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x+10, 0, [[UIScreen mainScreen] applicationFrame].size.width-20, 150)];
    [wodeTableView.tableHeaderView addSubview:imageView];
    [wodeTableView.tableHeaderView addSubview:userInfoView];
    
    [wodeTableView reloadData];
    
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-page"]];
//    wodeTableView.backgroundView = view;


    
    btnNextPage = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x+10, [[UIScreen mainScreen] applicationFrame].size.height-150, [[UIScreen mainScreen] applicationFrame].size.width-20, 40)];
    [btnNextPage addTarget:self action:@selector(exitbtn) forControlEvents:UIControlEventTouchUpInside];
    [btnNextPage setBackgroundImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
    btnNextPage.tag=112;
     [self.view addSubview:btnNextPage];
}
#pragma mark- UITableViewDeledate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self userDefault]==YES) {
        return 3;
    }
    else
    {
        return 4;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if(section==1)
    {
        return 1;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-page"]];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"我的上报";
            UIImage *icon = [UIImage imageNamed:@"icon-my-rep"];
            CGSize itemSize = CGSizeMake(23, 23);
            UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [icon drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            UILabel *carColorImageLabel = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 55, 10, 18, 30)];
            carColorImageLabel.text = @" >";
            [carColorImageLabel setFont:[UIFont fontWithName:@"FZLanTingHei-R-GBK" size:13]];
            [carColorImageLabel setTextColor:[UIColor lightGrayColor]];
            [cell addSubview:carColorImageLabel];
        }
    }else if (indexPath.section==1){
        cell.textLabel.text = @"历史消息";
        UIImage *icon = [UIImage imageNamed:@"icon-my-mes.png"];
        CGSize itemSize = CGSizeMake(23, 23);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UILabel *carColorImageLabel = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 55, 10, 18, 30)];
        carColorImageLabel.text = @" >";
        [carColorImageLabel setFont:[UIFont fontWithName:@"FZLanTingHei-R-GBK" size:13]];
        [carColorImageLabel setTextColor:[UIColor lightGrayColor]];
        [cell addSubview:carColorImageLabel];
    }else if (indexPath.section==2)
    {
        
        cell.textLabel.text = @"过期任务";
        UIImage *icon = [UIImage imageNamed:@"icon-my-time"];
        CGSize itemSize = CGSizeMake(23, 23);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UILabel *carColorImageLabel = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 55, 10, 18, 30)];
                    carColorImageLabel.text = @" >";
        [carColorImageLabel setFont:[UIFont fontWithName:@"FZLanTingHei-R-GBK" size:13]];
        [carColorImageLabel setTextColor:[UIColor lightGrayColor]];
        [cell addSubview:carColorImageLabel];
    }
    else{
        cell.textLabel.text = @"系统版本";
        UIImage *icon = [UIImage imageNamed:@"icon-my-ver"];
        CGSize itemSize = CGSizeMake(23, 23);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UILabel *carColorImageLabel = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 25, 10, 30, 30)];
        //            carColorImageLabel.text = @" >";
        [carColorImageLabel setFont:[UIFont fontWithName:@"FZLanTingHei-R-GBK" size:13]];
        [carColorImageLabel setTextColor:[UIColor lightGrayColor]];
        [cell addSubview:carColorImageLabel];
        
        //获取版本号/APP名
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        //          NSString *name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        //            NSLog(@"%@ v%@",name,version);
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 60, 10, 40, 30)];
        label.text=[NSString stringWithFormat:@"v%@",version];
        NSLog(@"v:%@",version);
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:14.0f]];
        label.textColor=[UIColor grayColor];
        [cell addSubview:label];
    }
    
    
    
    if (indexPath.section==0)
    {
        
    }
    else if(indexPath.section==1)
    {
        
    }
    else{
        //隐藏多余的分割线
        [self setExtraCellLineHidden:tableView];
    }
    return cell;
}
//设置每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
//设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0)
//    {
//        return 0;
//    }
//    else
//    {
//        return 0;
//    }
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            NSLog(@"点击了关于品质......");
            
            dispatch_async(dispatch_get_main_queue(), ^
             {
                 //没有登录 不允许查看我的上报
                 //跳转界面
                 if ([self userDefault]==YES)
                 {
                     UIViewController *tvc= [[ViewController alloc]init];
                     UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:tvc];
                     [self.navigationController presentViewController:homeNav animated:YES completion:nil];
                 }else{
                     WoSpecialViewController *tvc=[[WoSpecialViewController alloc]init];
                     [self.navigationController pushViewController:tvc animated:NO];
                 }
             });

        }
    }else if (indexPath.section==2){
        GuoQiViewController *tvc=[[GuoQiViewController alloc]init];
        [self.navigationController pushViewController:tvc animated:NO];
    }
    else if (indexPath.section==1){
        MessageViewController *tvc=[[MessageViewController alloc]init];
        [self.navigationController pushViewController:tvc animated:NO];
    }
    else
    {
        if (indexPath.row==0) {
            //更新
        }
    }
}
#pragma mark -退出登录
-(void)exitbtn{
      [self logout];
}
#pragma mark -退出登录  待完成:目前用删除本地存储plist方式退出
- (void)logout
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"你确定要退出吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"不退出", nil];
    alertView.tag = 1001;
    [alertView show];
}
#pragma mark - uialertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001)
    {
        if (buttonIndex == 0)
        {
            //
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                self.phoneNumber = nil;
                /*
                 employeeid 10003473 员工id
                 employeesn CCH-IT-0006 员工账号
                 employeename 盛磊 员工姓名
                 mobile 18957113301 手机号
                 departmentid 10030 部门
                 hotelid 1009 酒店编号
                 */
                //获取UserDefaults单例
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                //移除UserDefaults中存储的用户信息
                [userDefaults removeObjectForKey:@"employeeid"];
                [userDefaults removeObjectForKey:@"employeesn"];
                [userDefaults removeObjectForKey:@"employeename"];
                [userDefaults removeObjectForKey:@"mobile"];
                [userDefaults removeObjectForKey:@"departmentid"];
                [userDefaults removeObjectForKey:@"hotelid"];
                [userDefaults removeObjectForKey:@"password"];
                [userDefaults synchronize];
                
                 //通知主线程刷新
                 dispatch_async(dispatch_get_main_queue(), ^{
                     //如果退出立即弹出登录窗口
                     if ([self userDefault]==YES)
                     {
                         ViewController *tvc= [[ViewController alloc]init];
                         UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:tvc];
                         [self.navigationController presentViewController:homeNav animated:YES completion:nil];
                     }
                     
                    //回调或者说是通知主线程刷新
                    [wodeTableView reloadData];
                    [self refreshUserInfo];
                    });
                });
            return;
        }
        else
        {
            return;
        }
    }
}
#pragma mark - 登录
//- (void)loginButtonPressed:(id)sender{
//    ViewController *loginView = [[ViewController alloc] init];
//    loginView.delegate = self;
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginView];
//    [self.navigationController presentViewController:navi animated:YES completion:nil];
//}
#pragma mark -viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    //部门信息
    XMLRequest *xml = [[XMLRequest alloc] init];
    [xml returnMoreInfo];
    
    //酒店信息
    XMLRequestTwo *xmlTwo = [[XMLRequestTwo alloc] init];
    [xmlTwo returnMoreInfo];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.frame = CGRectMake(0, [[UIScreen mainScreen] applicationFrame].size.height - 28, [[UIScreen mainScreen] applicationFrame].size.width, 48);
    
    if ([self userDefault]==YES) {
       [self performSelectorInBackground:@selector(refreshUserInfo) withObject:nil];
    }
    else{
        [[userInfoView viewWithTag:104] setHidden:YES];
        [[userInfoView viewWithTag:102] setHidden:NO];
        [[userInfoView viewWithTag:103] setHidden:NO];
        [[userInfoView viewWithTag:110] setHidden:NO];
        [[userInfoView viewWithTag:111] setHidden:NO];
        
       
        
        [[btnNextPage viewWithTag:112]setHidden:NO];
    }
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *username = [userDefault objectForKey:@"employeename"];
//    
//    [(UILabel *)[userInfoView viewWithTag:103] setText:[NSString stringWithFormat:@"%@",username]];
//    [(UILabel *)[userInfoView viewWithTag:110] setText:[NSString stringWithFormat:@"技术部门 %@",_department]];
//     [(UILabel *)[userInfoView viewWithTag:111] setText:[NSString stringWithFormat:@"成都瑞城城市名人酒店"]];
    [wodeTableView reloadData];
}
#pragma mark - private
- (void)refreshUserInfo{
        [[userInfoView viewWithTag:104] setHidden:NO];
        [[userInfoView viewWithTag:102] setHidden:YES];
        [[userInfoView viewWithTag:103] setHidden:YES];
        [[userInfoView viewWithTag:110] setHidden:YES];
        [[userInfoView viewWithTag:111] setHidden:YES];
    
    
        [[btnNextPage viewWithTag:112]setHidden:YES];
}
#pragma mark - login delegate
- (void)loginSuccess
{
    [wodeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
- (void)loginFail
{
}
#pragma mark -消息查看
-(void)searchprogram{
    MessageViewController *tvc=[[MessageViewController alloc]init];
    [self.navigationController pushViewController:tvc animated:NO];
}
#pragma mari -检测更新
-(void)checkUpdate{
    if([UpdateCheck hasNewVersion])
    {
        //下载新版本
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新版本" message:@"检测到新版本，是否更新？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前去下载", nil];
        [alert show];
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有新版本" message:@"该版本已是最新版本！敬请期待" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
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
#pragma mark- 不想要哪条cell分割线就调用下
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma make -- tongzhi
- (void)tongzhi:(NSNotification *)sender
{
    NSMutableArray *array = sender.object;
        NSLog(@"array1:%@", array);
    NSLog(@"－－－－－接收到通知------");
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *departmentid = [userDefault objectForKey:@"departmentid"];
    NSString *username = [userDefault objectForKey:@"employeename"];
    NSString *hotelname = [userDefault objectForKey:@"hotelname"];
    NSString *departmentname = [userDefault objectForKey:@"departmentname"];
    for (int i = 0; i < array.count; i++)
    {
        if ([array[i] isEqualToString:departmentid])
        {
            _department = array[i+1];
            NSLog(@"department -- %@",_department);
        }
    }
    
    [(UILabel *)[userInfoView viewWithTag:103] setText:[NSString stringWithFormat:@"%@",username]];
    
    if (username==nil ||[username isEqual:@""]) {
        _department=@"";
    }
    
    [(UILabel *)[userInfoView viewWithTag:110] setText:[NSString stringWithFormat:@" %@",departmentname]];
    [(UILabel *)[userInfoView viewWithTag:111] setText:[NSString stringWithFormat:@" %@",hotelname]];
}
#pragma make -- tongzhi
- (void)tongzhi2:(NSNotification *)sender
{
    NSMutableArray *array = sender.object;
    NSLog(@"array2:%@", array);
    NSLog(@"－－－－－接收到通知------2");
}
@end
