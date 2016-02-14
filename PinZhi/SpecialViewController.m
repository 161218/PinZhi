//
//  SpecialViewController.m
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/24.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "SpecialViewController.h"
#import "macro.h"
#import "Util.h"
#import "UIWindow+YzdHUD.h"
#import <ASIFormDataRequest.h>
#import "WoXMLRequest.h"

#define Alter0 @"无网络"
#define Alter1 @"当前为2G网络,确认提交？"
#define Alter2 @"当前为3G网络,确认提交？"
#define Alter3 @"当前为4G网络,确认提交？"
#define Alter5 @"当前为WIfi网络,确认提交？"
@interface SpecialViewController ()

@property(nonatomic,strong)ASIFormDataRequest *request;


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

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.navigationItem.title = @"上    报";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    //去除下个页面系统导航自带的文字并显示为白色
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = item;
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    //    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,20)];
    //    [rightButton setImage:[UIImage imageNamed:@"arrow-back.png"]forState:UIControlStateNormal];
    //    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    //    self.navigationItem.leftBarButtonItem= rightItem;
    
    _jdArray = [[NSMutableArray alloc] init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhied:) name:@"RELOADVOEWNOTIFICATIINN" object:nil];
    
    
    CGRect framedd=CGRectMake(0, 64, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 44);
    //
    UIButton *backgroundBtn = [UIButton buttonWithType:0];
    backgroundBtn.frame = framedd;
    [backgroundBtn addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
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
    //提交
    CGRect frame7=CGRectMake(15,frame6.origin.y+85, FULL_WIDTH-15*2, 40);
    
    //text
    //标题
    CGRect framet2=CGRectMake(90,framed.origin.y-5, FULL_WIDTH-58*2, 40);
    //投诉人
    CGRect framet3=CGRectMake(90,framet2.origin.y+45, FULL_WIDTH-58*2, 40);
    //被投诉人
    CGRect framet4=CGRectMake(90,framet3.origin.y+45, FULL_WIDTH-58*2, 40);
    //详细信息
    CGRect framet5=CGRectMake(90,framet4.origin.y+45, FULL_WIDTH-58*2, 70);
    //图片上传
    CGRect framet6=CGRectMake(90,framet5.origin.y+75, FULL_WIDTH-58*2, 30);
    //添加图片
    CGRect framet7=CGRectMake(90,framet5.origin.y+90,100, 40);
    //显示选择照片状态
//    CGRect framet8=CGRectMake(220,framet5.origin.y+90, FULL_WIDTH-100*2, 30);
    
    //
    CGRect frame2s=CGRectMake(10,framed.origin.y-10, FULL_WIDTH-15*2, 40);
    // 人/部门
    CGRect frame3s=CGRectMake(18,frame2s.origin.y+60, FULL_WIDTH-15*2, 40);
    //被投诉人 人/部门
    CGRect frame4s=CGRectMake(18,frame3.origin.y+60, FULL_WIDTH-15*2, 40);
    
    //背景
    bgview=[[UIButton alloc]initWithFrame:framed];
    [bgview addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    bgview.backgroundColor=RGBA(255, 255, 255,0);
    [self.view addSubview:bgview];
    
    // 人/部门
    tousubm=[[UIButton alloc]initWithFrame:frame3s];
    tousubm.backgroundColor=RGBA(240, 240, 240,0);
    [tousubm addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    tousubm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [tousubm setTitleColor:RGBA(212, 202, 179, 1) forState:UIControlStateNormal];
    [tousubm setTitle:@"人/部门" forState:UIControlStateNormal];
    [tousubm setFont:[UIFont systemFontOfSize:12.0f]];
    [bgview addSubview:tousubm];
    
    // 人/部门
    btousubm=[[UIButton alloc]initWithFrame:frame4s];
    btousubm.backgroundColor=RGBA(240, 240, 240,0);
    [btousubm addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    btousubm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btousubm setTitleColor:RGBA(212, 202, 179, 1) forState:UIControlStateNormal];
    [btousubm setTitle:@"人/部门" forState:UIControlStateNormal];
    [btousubm setFont:[UIFont systemFontOfSize:12.0f]];
    [bgview addSubview:btousubm];
    
    //标题
    bname=[[UIButton alloc]initWithFrame:frame2];
    bname.backgroundColor=RGBA(240, 240, 240,0);
    [bname addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    bname.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bname setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bname setTitle:@"  标   题:" forState:UIControlStateNormal];
    [bname setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:bname];
    //标题text
    _bnametext=[[UITextField alloc]initWithFrame:framet2];
    _bnametext.backgroundColor=[UIColor whiteColor];
    _bnametext.delegate = self;
    _bnametext.layer.cornerRadius=5.0f;
    _bnametext.layer.masksToBounds=YES;
    _bnametext.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    _bnametext.layer.borderWidth= 1.0f;
    _bnametext.placeholder=@"   请输入标题";
    [bgview addSubview:_bnametext];
    
    //投诉人
    btousu=[[UIButton alloc]initWithFrame:frame3];
    btousu.backgroundColor=RGBA(240, 240, 240,0);
    [btousu addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    btousu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btousu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btousu setTitle:@"  投   诉:" forState:UIControlStateNormal];
    [btousu setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:btousu];
    //投诉人text
    _btousutext=[[UITextField alloc]initWithFrame:framet3];
    _btousutext.backgroundColor=[UIColor whiteColor];
    _btousutext.delegate = self;
    _btousutext.layer.cornerRadius=5.0f;
    _btousutext.layer.masksToBounds=YES;
    _btousutext.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    _btousutext.layer.borderWidth= 1.0f;
    _btousutext.placeholder=@"   请输入投诉人";
    [bgview addSubview:_btousutext];
    
    //被投诉人
    bbtousu=[[UIButton alloc]initWithFrame:frame4];
    bbtousu.backgroundColor=RGBA(240, 240, 240,0);
    [bbtousu addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    bbtousu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bbtousu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bbtousu setTitle:@"  被投诉:" forState:UIControlStateNormal];
    [bbtousu setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:bbtousu];
    
    //被投诉人text
    _bbtousutext=[[UITextField alloc]initWithFrame:framet4];
    _bbtousutext.backgroundColor=[UIColor whiteColor];
    _bbtousutext.layer.cornerRadius=5.0f;
    _bbtousutext.layer.masksToBounds=YES;
    _bbtousutext.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    _bbtousutext.layer.borderWidth= 1.0f;
//    _bbtousutext.text = @"信息部";
    _bbtousutext.placeholder=@"   请选择部门";
    [bgview addSubview:_bbtousutext];
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(_bbtousutext.frame.origin.x, _bbtousutext.frame.origin.y + 20, _bbtousutext.frame.size.width +20, _bbtousutext.frame.size.height);
    [btn addTarget:self action:@selector(bbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    //详细信息
    bxmessage=[[UIButton alloc]initWithFrame:frame5];
    bxmessage.backgroundColor=RGBA(240, 240, 240,0);
    [bxmessage addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    bxmessage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bxmessage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bxmessage setTitle:@"  详细信息:" forState:UIControlStateNormal];
    [bxmessage setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:bxmessage];
    
    //详细信息text
    _bxmessagetext=[[UITextView alloc]initWithFrame:framet5];
    _bxmessagetext.backgroundColor=[UIColor whiteColor];
    _bxmessagetext.delegate = self;
    _bxmessagetext.layer.cornerRadius=5.0f;
    _bxmessagetext.layer.masksToBounds=YES;
    _bxmessagetext.layer.borderColor=[RGBA(220, 212, 197, 1.0)CGColor];
    _bxmessagetext.layer.borderWidth= 1.0f;
//    _bxmessagetext.text=@"002";
    [bgview addSubview:_bxmessagetext];
    
    //图片上传
    btimage=[[UIButton alloc]initWithFrame:frame6];
    btimage.backgroundColor=RGBA(240, 240, 240,0);
    [btimage addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    btimage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btimage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btimage setTitle:@"  图片上传:" forState:UIControlStateNormal];
    [btimage setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:btimage];
    //图片上传text  //暂时放着  没有用
    UITextField *bxtimagetext=[[UITextField alloc]initWithFrame:framet6];
    bxtimagetext.backgroundColor=[UIColor clearColor];
    bxtimagetext.enabled=NO;
    [bgview addSubview:bxtimagetext];
    
    //选择文件
    _baddimage=[[UIButton alloc]initWithFrame:framet7];
    _baddimage.backgroundColor=RGBA(187,187, 187, 1.0);
    _baddimage.layer.masksToBounds=YES;
    _baddimage.layer.cornerRadius=5;
    [_baddimage setTitle:@" 选择图片" forState:UIControlStateNormal];
    [_baddimage addTarget:self action:@selector(addbtn) forControlEvents:UIControlEventTouchUpInside];
    //图片待添加
     _baddimage.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    [_baddimage setFont:[UIFont systemFontOfSize:14.0f]];
    [bgview addSubview:_baddimage];
    
    UIImageView *baddimageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-upload"]];
    baddimageview.frame = CGRectMake(5, 5, 30, 30);
    [_baddimage addSubview:baddimageview];
    //选择文件状态
//    baddzt=[[UIButton alloc]initWithFrame:framet8];
//    [baddzt addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
//    baddzt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [baddzt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [baddzt setTitle:@"未选择文件" forState:UIControlStateNormal];
//    [baddzt setFont:[UIFont systemFontOfSize:14.0f]];
//    [bgview addSubview:baddzt];
    
    //提交
    btj=[[UIButton alloc]initWithFrame:frame7];
    btj.backgroundColor=RGBA(251, 93, 10, 1);
    btj.layer.masksToBounds=YES;
    btj.layer.cornerRadius=5;
    [btj setTitle:@"提  交" forState:UIControlStateNormal];
    [btj addTarget:self action:@selector(tijiao:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btj];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg-page"]];
    self.scImageArray=[[NSMutableArray alloc]init];
    
    
     _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,  [[UIScreen mainScreen] applicationFrame].size.height-304, [[UIScreen mainScreen] applicationFrame].size.width, 300)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    
    _pickerbtn = [UIButton buttonWithType:0];
    [_pickerbtn addTarget:self action:@selector(pickerDismiss) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma mark －pickerview
-(void)viewWillAppear:(BOOL)animated{
    WoXMLRequest *Woxml = [[WoXMLRequest alloc] init];
    [Woxml returnMoreInfo];
}
#pragma make -- tongzhi
- (void)tongzhied:(NSNotification *)sender
{
    _jdArray = sender.object;
    NSLog(@"Pickerarray:%@", _jdArray);


}
#pragma mark -
-(void)searchprogram{
    [self.navigationController popViewControllerAnimated:NO];
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
#pragma mark - 提交
-(void)tijiao:(UIButton *)btn{
    /*
     employeeid 10003473 员工id
     employeesn CCH-IT-0006 员工账号
     employeename 盛磊 员工姓名
     mobile 18957113301 手机号
     departmentid 10030 部门
     hotelid 1009 酒店编号
     */
    NSLog(@"提交");
    
    if ([self userDefault]==YES) {
        ViewController *tvc= [[ViewController alloc]init];
        UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:tvc];
        [self.navigationController presentViewController:homeNav animated:YES completion:nil];
        
        //终止请求
        [self.request clearDelegatesAndCancel];
        self.request=nil;
        return;
    }
    
    
    if (_bnametext.text==nil||[_bnametext.text isEqual:@""]||[[_bnametext.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0
) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"标题不能为空或有空格!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        alertView.tag=101;
        [alertView show];
        return;
    };
    

    
    if (_btousutext.text==nil||[_btousutext.text isEqual:@""]||[[_btousutext.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"投诉不能为空或有空格!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        alertView.tag=101;
        [alertView show];
        return;
    };
    
    if (_nameStr==nil||[_nameStr isEqual:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"被投诉不能为空!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        alertView.tag=101;
        [alertView show];
        return;
    };
    
    if (_bxmessagetext.text==nil||[_bxmessagetext.text isEqual:@""]||[[_bxmessagetext.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"详细信息不能为空或有空格!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        alertView.tag=101;
        [alertView show];
        return;
    };
    
    
    if (_bnametext.text.length >32)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"详细信息字数不能超过32!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
//    [_bnametext resignFirstResponder];
//    [_btousutext resignFirstResponder];
//    [_bbtousutext resignFirstResponder];
//    [_bxmessagetext resignFirstResponder];
//    ([_bnametext.text isEqual:@""][_btousutext.text isEqual:@""][_bxmessagetext.text isEqual:@""])
    

    
    
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
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示:" message:Alter0 delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        [alter show];
    }else if (type==1){
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示:" message:Alter1 delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        [alter show];
    }else if (type==2){
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示:" message:Alter2 delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        [alter show];
    }else if (type==3){
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示:" message:Alter3 delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        [alter show];
    }else{
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示:" message:Alter5 delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        [alter show];
    }
}
#pragma mark -键盘下去
-(void)firstBtn
{
    [_bnametext resignFirstResponder];
    [_btousutext resignFirstResponder];
    [_bbtousutext resignFirstResponder];
    [_bxmessagetext resignFirstResponder];
    
    _pickerView.frame = CGRectMake(0, 1000, 0, 0);
    _pickerbtn.frame = CGRectMake(1000, 0, 40, 40);

}
#pragma mark-选择文件  相机和相册
-(void)addbtn{
    NSLog(@"点击了选择文件按钮");
    [self showMenu];
}
#pragma mark - MBButtonMenuViewControllerDelegate
- (void) showMenu
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"相册",@"拍照",nil];
    actionSheet.tag=0;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}
#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==0)
    {
        //呼出的菜单按钮点击后的响应
        if (buttonIndex == actionSheet.cancelButtonIndex)
        {
            NSLog(@"取消");
        }
        switch (buttonIndex)
        {
            case 0://打开本地相册
                [self LocalPhoto];
                break;
                
                case 1://打开照相机拍照
                
                [self takePhoto];
                break;
        }
    }
}
//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }
    else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示:" message:@"模拟其中无法打开照相机,请在真机中使用." delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        alter.tag=102;
        [alter show];
    }
}
//打开本地相册
-(void)LocalPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.photoUrlPicker  = [[UIImagePickerController alloc] init];
        _photoUrlPicker.delegate = self;
        _photoUrlPicker.allowsEditing = NO;
        _photoUrlPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.photoUrlPicker animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"访问相册错误"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        alert.tag=103;
        [alert show];
    }
}
//再调用以下委托选择从相册获取的图片：
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 260, 80, 40)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    _photoString = encodedImageStr;
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark -确认提交表单
#pragma mark-UIalterviewdelegte
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==101) {
        if (buttonIndex==0) {
            
        }else{
            
        }
    }else if (alertView.tag==102){
        if (buttonIndex==0) {
            
        }else{
            
        }
    }else if (alertView.tag==103){
        if (buttonIndex==0) {
            
        }else{
            
        }
    }
    else{
        if (buttonIndex==0) {
            //提交
            btj.userInteractionEnabled=NO;
            [self.view.window showHUDWithText:@"正在提交" Type:ShowLoading Enabled:YES];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSString *employeeid = [userDefault objectForKey:@"employeeid"];
            
            NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 "<soap:Body>"
                                 
                                 "<n:tswtsb xmlns:n=\"http://www.apl.com/webservice/upload\">"
                                 "<employeeid>%@</employeeid>"
                                 "<name>%@</name>"
                                 "<menu>%@</menu>"
                                 "<menufile>%@</menufile>"
                                 "<tspeople>%@</tspeople>"
                                 "<tsdepartmentid>%@</tsdepartmentid>"
                                 "</n:tswtsb>"
                                 
                                 "</soap:Body>"
                                 "</soap:Envelope>",employeeid,_bnametext.text,_bxmessagetext.text,_photoString,_btousutext.text,_nameStr
                                 ];
            NSLog(@"soapMsg===%@",soapMsg);
            
            NSString *space=@"http://www.apl.com/webservice/upload";
            NSString *methodname=@"tswtsb";
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
            
            btj.userInteractionEnabled=YES;
            [self.view.window showHUDWithText:@"提交成功" Type:ShowPhotoYes Enabled:YES];
            //提交成功 按钮不可点击
//            btj.userInteractionEnabled=NO;
            _bnametext.text=@"";
            _btousutext.text=@"";
            _bbtousutext.text=@"";
            _bxmessagetext.text=@"";
            _nameStr=@"";
            [imageView removeFromSuperview];
            
        }else{
            btj.userInteractionEnabled=YES;
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
        NSLog(@"新增array---%lu",(unsigned long)_infoArray.count);
        NSLog(@"新增array---%@",_infoArray);
}

-(void)bbtnclick
{
    NSLog(@"新增array");
    
    [_bnametext resignFirstResponder];
    [_btousutext resignFirstResponder];
    [_bbtousutext resignFirstResponder];
    [_bxmessagetext resignFirstResponder];
    
    _pickerbtn.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    [self.view addSubview:_pickerbtn];
    
    _pickerView.frame = CGRectMake(0,  [[UIScreen mainScreen] applicationFrame].size.height-304, [[UIScreen mainScreen] applicationFrame].size.width, 300);
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    
    



}

#pragma mark- UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return _jdArray.count/2;

}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _nameStr = [_jdArray objectAtIndex:row*2];
    
    _bbtousutext.text = [_jdArray objectAtIndex:row*2 +1];
    
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return _jdArray[row*2 +1];
}

-(void)pickerDismiss
{
    _pickerView.frame = CGRectMake(0, 1000, 0, 0);
    _pickerbtn.frame = CGRectMake(1000, 0, 40, 40);

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    _bnametext _btousutext _bxmessagetext

    if ([textField isEqual:_bnametext] && textField.text.length>31)
    {
        return NO;
    }
    
    if ([textField isEqual:_btousutext] && textField.text.length>31)
    {
        return NO;
    }
    
    if ([textField isEqual:_bxmessagetext] && textField.text.length>255)
    {
        return NO;
    }
    
    return YES;
}


@end
