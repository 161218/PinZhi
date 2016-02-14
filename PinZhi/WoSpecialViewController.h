//
//  WoSpecialViewController.h
//  PinZhi
//
//  Created by 刘子阳 on 15/7/20.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialModel.h"
#import "RSpecialViewController.h"


@interface WoSpecialViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
//    UIPickerView *_pickerView;
//    UIPickerView *_pickerViewTwo;
    
//    BOOL _isOpen;
//    BOOL _isOpenTwo;
    
    UIButton *btnadd;//返回顶部
    
    UILabel *jinri;
    NSString *_proNameStr;
    
    BOOL isFrist;
}
@end
