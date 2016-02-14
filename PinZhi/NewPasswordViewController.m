//
//  NewPasswordViewController.m
//  PinZhi
//
//  Created by 刘子阳 on 15/7/6.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "NewPasswordViewController.h"
#import "macro.h"
@interface NewPasswordViewController ()
{

}
@property(nonatomic, strong)UITextField *OldpasswordTextField;
@property(nonatomic, strong)UITextField *NewpasswordTextField;
@property(nonatomic, strong)UITextField *QuerenNewpasswordTextField;
@end

@implementation NewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"修改密码";
    
    CGRect framed=CGRectMake(0, 64, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 44);
    
    UIButton *backgroundBtn = [UIButton buttonWithType:0];
    backgroundBtn.frame = framed;
    [backgroundBtn addTarget:self action:@selector(firstBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backgroundBtn];
    //
    CGRect frame1=CGRectMake((FULL_WIDTH-80)/2,(FULL_HEIGHT-1000)/10, 80, 80);
    //旧密码输入框
    CGRect frame2=CGRectMake(30,frame1.origin.y+frame1.size.height+20, FULL_WIDTH-30*2, 40);
    //新密码输入框
    CGRect frame3=CGRectMake(30,frame2.origin.y+frame2.size.height+5, FULL_WIDTH-30*2, 40);
    //确认新密码输入框
    CGRect frame4=CGRectMake(30,frame3.origin.y+frame3.size.height+5, FULL_WIDTH-30*2, 40);
    //确认修改按钮
    CGRect frame5=CGRectMake(30,frame4.origin.y+frame4.size.height+10, FULL_WIDTH-30*2, 30);
    
    _OldpasswordTextField = [[UITextField alloc] initWithFrame:frame2];
    _OldpasswordTextField.placeholder = @"旧密码";
    _OldpasswordTextField.secureTextEntry = YES;
    _OldpasswordTextField.delegate=self;
    _OldpasswordTextField.layer.cornerRadius=0.0f;
    _OldpasswordTextField.layer.masksToBounds=YES;
    _OldpasswordTextField.layer.borderColor=[RGBA(0, 114, 199, 1.0)CGColor];
    _OldpasswordTextField.layer.borderWidth= 1.0f;
    [self.view addSubview:_OldpasswordTextField];
    
    _NewpasswordTextField = [[UITextField alloc] initWithFrame:frame3];
    _NewpasswordTextField.placeholder = @"新密码";
    _NewpasswordTextField.secureTextEntry = YES;
    _NewpasswordTextField.delegate=self;
    _NewpasswordTextField.layer.cornerRadius=0.0f;
    _NewpasswordTextField.layer.masksToBounds=YES;
    _NewpasswordTextField.layer.borderColor=[RGBA(0, 114, 199, 1.0)CGColor];
    _NewpasswordTextField.layer.borderWidth= 1.0f;
    [self.view addSubview:_NewpasswordTextField];
    
    _QuerenNewpasswordTextField = [[UITextField alloc] initWithFrame:frame4];
    _QuerenNewpasswordTextField.placeholder = @"确认密码";
    _QuerenNewpasswordTextField.secureTextEntry = YES;
    _QuerenNewpasswordTextField.delegate=self;
    _QuerenNewpasswordTextField.layer.cornerRadius=0.0f;
    _QuerenNewpasswordTextField.layer.masksToBounds=YES;
    _QuerenNewpasswordTextField.layer.borderColor=[RGBA(0, 114, 199, 1.0)CGColor];
    _QuerenNewpasswordTextField.layer.borderWidth= 1.0f;
    [self.view addSubview:_QuerenNewpasswordTextField];
    
    UIButton *QuerenPasswordBtn = [[UIButton alloc] initWithFrame:frame5];
    [QuerenPasswordBtn addTarget:self action:@selector(QuerenPasswordbtn) forControlEvents:UIControlEventTouchUpInside];
    QuerenPasswordBtn.backgroundColor=RGBA(0, 114, 199, 0.8);
    [QuerenPasswordBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [QuerenPasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:QuerenPasswordBtn];
}
#pragma mark -viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
     self.tabBarController.tabBar.frame = CGRectMake(FULL_WIDTH+10,FULL_HEIGHT+10,0, 0);
}
-(void)QuerenPasswordbtn{
    
}
-(void)firstBtn
{
    [_OldpasswordTextField resignFirstResponder];
    [_NewpasswordTextField resignFirstResponder];
    [_QuerenNewpasswordTextField resignFirstResponder];
}
@end
