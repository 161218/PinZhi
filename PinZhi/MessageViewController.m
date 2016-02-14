//
//  MessageViewController.m
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "MessageViewController.h"


@interface MessageViewController ()
{
    UITableView *wodeTableView;
}
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"消    息";
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,20)];
    [rightButton setImage:[UIImage imageNamed:@"arrow-back.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
    
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    wodeTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 44) style:UITableViewStylePlain];
    wodeTableView.delegate = self;
    wodeTableView.dataSource = self;
    [self.view addSubview:wodeTableView];
    
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-page"]];
//    wodeTableView.backgroundView = view;
    
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
}
#pragma mark -返回顶部
-(void)dingbubtn{
    NSLog(@"点击了返回顶部");
    [wodeTableView setContentOffset:CGPointMake(0, 0) animated:YES];
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

#pragma mark- UITableViewDeledate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//         cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-page"]];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    
    cell.textLabel.text = @"";
    
    return cell;
}
//设置每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)searchprogram{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
