//
//  QualityViewController.h
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/23.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QualityInfoViewController.h"
#import "QualityModel.h"
#import "PinZhiDAO.h"
#import "DaibanViewCell.h"

@interface QualityViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *_pickerView;
    UIPickerView *_pickerViewTwo;

    BOOL _isOpen;
    BOOL _isOpenTwo;
    
     UIButton *btnadd;//返回顶部
    
    UILabel *jinri;
    NSString *_proNameStr;
    
    BOOL isFrist;
    
    
    UILabel *labelBlack;
}

@property(strong,nonatomic)UIButton *pickerbtn;

@property(strong,nonatomic)NSString *timeString;

@end
