//
//  QualityTwoViewController.h
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WancViewCell.h"

@interface QualityTwoViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *_pickerView;
    UIPickerView *_pickerViewTwo;
    
    BOOL _isOpen;
    BOOL _isOpenTwo;
    
    UIButton *btnadd;//返回顶部
    
    NSString *_proNameStr;
    
    UILabel *jinri;
    BOOL isFrist;

    UILabel *labelBlack;
}

@property(strong,nonatomic)NSString *timeString;

@property(strong,nonatomic)NSMutableArray *qualityArray;

@property(strong,nonatomic)UIButton *pickerbtn;

@end
