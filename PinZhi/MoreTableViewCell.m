//
//  MoreTableViewCell.m
//  PinZhi
//
//  Created by 刘子阳 on 15/7/5.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "MoreTableViewCell.h"
#import "macro.h"
@implementation MoreTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, [[UIScreen mainScreen] applicationFrame].size.width - 100, 44)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:13];
        _nameLabel.numberOfLines = 0;
        [self addSubview:_nameLabel];
        
        
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-page"]];
//        self.backgroundView = view;

        
//        _yesOrNoBtn = [UIButton buttonWithType:0];
//        _yesOrNoBtn.backgroundColor = [UIColor colorWithRed:73/255.0 green:169/255.0 blue:104/255.0 alpha:1];
//        [_yesOrNoBtn setFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 80, 3, 60, 34)];
//        [_yesOrNoBtn setTitle:@"合格" forState:0];
//        _yesOrNoBtn.layer.cornerRadius=5.0f;
//        _yesOrNoBtn.layer.masksToBounds=YES;
//        [self addSubview:_yesOrNoBtn];
        
        _picLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 60, 22)];
        _picLabel.text = @"备注：";
        [self addSubview:_picLabel];
        
        _picBtn = [UIButton buttonWithType:0];
        _picBtn.backgroundColor = [UIColor lightGrayColor];
        [_picBtn setTitle:@"选择图片" forState:0];
        _picBtn.frame = CGRectMake(70, 55, 80, 34);
        _picBtn.layer.cornerRadius=5.0f;
        _picBtn.layer.masksToBounds=YES;
        [self addSubview:_picBtn];

        
        
        _informationTF = [[UITextView alloc] initWithFrame:CGRectMake(10, 95, [[UIScreen mainScreen] applicationFrame].size.width - 20, 100)];
        _informationTF.layer.borderColor=[RGBA(220, 212, 197, 1.0) CGColor];
        _informationTF.layer.borderWidth= 1.0f;
        _informationTF.layer.cornerRadius=5.0f;
        _informationTF.layer.masksToBounds=YES;
        _informationTF.backgroundColor = [UIColor whiteColor];
        [self addSubview:_informationTF];
    }
    return self;
}

-(void)moreInfo:(UIButton *)btn
{
//    UIActionSheet *sheet;
//    // 判断是否支持相机
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        
//    {
//        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
//    }
//    else {
//        
//        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
//    }
//    [sheet showInView:self.window.rootViewController.view];
    
    
}

@end
