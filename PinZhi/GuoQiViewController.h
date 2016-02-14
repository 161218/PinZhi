//
//  GuoQiViewController.h
//  PinZhi
//
//  Created by 刘子阳 on 15/8/6.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "macro.h"
#import "QualityModel.h"
#import "GuoQiTwoViewController.h"
#import "GuoqiViewCell.h"
@interface GuoQiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIButton *btnadd;
    UIButton *_ywcbtn;
    UIButton *_wwcbtn;
    UILabel *jinri;
    UIPickerView *_pickerView;
    UIPickerView *_pickerViewTwo;
    NSString *_proNameStr;
    
    BOOL isFrist;
    
    
    UILabel *labelBlack;
}

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *qualityArray;


@property(strong,nonatomic)UIButton *pickerbtn;
@property(strong,nonatomic)NSString *timeString;
@end
