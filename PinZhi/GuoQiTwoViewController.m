//
//  GuoQiTwoViewController.m
//  PinZhi
//
//  Created by 刘子阳 on 15/8/6.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "GuoQiTwoViewController.h"

@interface GuoQiTwoViewController ()

@end

@implementation GuoQiTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indexidsArray = [[NSMutableArray alloc] init];
    _indexvaluesArray = [[NSMutableArray alloc] init];
    _indexmenusArray = [[NSMutableArray alloc] init];
    _imagesArray = [[NSMutableArray alloc] init];
    _photoViewArray = [[NSMutableArray alloc] init];

    _qualityArray = [[NSMutableArray alloc] init];
    _btnArray = [[NSMutableArray alloc] init];

    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,20)];
    [rightButton setImage:[UIImage imageNamed:@"arrow-back.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
    self.title = self.useName;
    
     CGRect fhamed=CGRectMake([[UIScreen mainScreen] applicationFrame].size.width-65,[[UIScreen mainScreen] applicationFrame].size.height-150, 50,50);
    
    btnadd=[[UIButton alloc]initWithFrame:fhamed];
    [btnadd setBackgroundImage:[UIImage imageNamed:@"back_top_icon"] forState:UIControlStateNormal];
    [btnadd addTarget:self action:@selector(dingbubtn) forControlEvents:UIControlEventTouchUpInside];
    

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 93) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, 40)];
    self.tableView.rowHeight = 40;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self useAFNetWorking];

    
    // Do any additional setup after loading the view.
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
            
            
            [_btnArray addObject:[NSString stringWithFormat:@"%@",quality.Value]];

            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(160, 40, 60, 40)];
            [_photoViewArray addObject:imageview];
            
            [_qualityArray addObject:quality];
            
            NewButton* yesOrNoBtn = [NewButton buttonWithType:0];
            [yesOrNoBtn setFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 80, 10, 60, 34)];
//            [yesOrNoBtn addTarget:self action:@selector(moreInfo:) forControlEvents:UIControlEventTouchUpInside];
            yesOrNoBtn.layer.cornerRadius=5.0f;
            yesOrNoBtn.layer.masksToBounds=YES;
            [_indexvaluesArray addObject:yesOrNoBtn];
            
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
    cell.nameLabel.adjustsFontSizeToFitWidth = YES;
    
    cell.clipsToBounds = YES;
    
    cell.informationTF.tag = 2000 + indexPath.row;
    cell.informationTF.delegate = self;
    
    
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

    yesOrNoBtn.tag = indexPath.row +100;
    [cell addSubview:yesOrNoBtn];
    
    UIImageView *imageView = _photoViewArray[indexPath.row];
    imageView.frame = CGRectMake(170, 55, 80, 40);
    [cell addSubview:imageView];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = (int)indexPath.row;
    _section = (int)indexPath.section;
    
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
//-(void)moreInfo:(NewButton *)btn
//{
//    NSLog(@"btn -- %ld",(long)btn.tag);
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
//}


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


-(void)dingbubtn{
    NSLog(@"点击了返回顶部");
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
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
#pragma mark-
-(void)searchprogram{
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
