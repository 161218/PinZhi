//
//  ListViewController.m
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/24.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "ListViewController.h"
//#import "FriendGroup.h"
//#import "Friend.h"
//#import "HeadView.h"
#import "macro.h"
#import "MoreTableViewCell.h"

//#import "SpecialViewController.h"
@interface ListViewController ()
{
    NSArray *_jiudianDataed;
}
@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"质检申报1";
    self.tableView.sectionHeaderHeight = 50;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    _indexPath = -1;
    _section = -1;

    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,20)];
    [rightButton setImage:[UIImage imageNamed:@"arrow-back.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = item;
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self loadData];
}
#pragma mark 加载数据
- (void)loadData
{
    _jiudianDataed =_jiuidanData;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _jiudianDataed.count;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    FriendGroup *friendGroup = _jiudianDataed[section];
//    NSInteger count = friendGroup.isOpened ? friendGroup.friends.count : 0;
//    return count;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    FriendGroup *friendGroup = _jiudianDataed[indexPath.section];
//    Friend *friend = friendGroup.friends[indexPath.row];
//    cell.nameLabel.text = friend.name;
    cell.clipsToBounds = YES;
    
    [cell.yesOrNoBtn addTarget:self action:@selector(moreInfo:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    HeadView *headView = [HeadView headViewWithTableView:tableView];
//    headView.delegate = self;
//    headView.friendGroup = _jiudianDataed[section];
    return nil;
}
//设置每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == _section && indexPath.row == _indexPath)
    {
        return 200;
    }
    else
    {
        return 40;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = (int)indexPath.row;
    _section = (int)indexPath.section;

    [self.tableView reloadData];

}


-(void)moreInfo:(UIButton *)btn
{

}

#pragma mark -刷新TableView
- (void)clickHeadView
{
    [self.tableView reloadData];
}

#pragma mark -
-(void)searchprogram
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
