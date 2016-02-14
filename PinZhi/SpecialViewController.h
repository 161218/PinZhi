//
//  SpecialViewController.h
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/24.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "UIWindow+YzdHUD.h"

@interface SpecialViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate,LoginViewController,UIAlertViewDelegate,NSXMLParserDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UITextFieldDelegate>{
    
    UIPickerView *_pickerView;

    
    UITextField *_bnametext;
    UITextField *_btousutext;
    UITextField *_bbtousutext;
    UITextView *_bxmessagetext;
    
    UIButton *baddzt;
    UIButton *bgview;
    UIButton *bname;
    UIButton *btousu;
    UIButton *bbtousu;
    UIButton *bxmessage;
    UIButton *btimage;
    
    UIButton *tousubm;
    UIButton *btousubm;
    
    UIButton *btj;
    
    UIImageView *imageView;
}
//访问相册的图片相册控制器
@property (nonatomic,retain) UIImagePickerController *photoUrlPicker;
@property(nonatomic,retain)UIButton *baddimage;
@property(nonatomic,retain)NSMutableArray *scImageArray;

@property(strong,nonatomic)NSString *photoString;

@property(strong,nonatomic)NSMutableArray *jdArray;

@property(strong,nonatomic)NSString *nameStr;

@property(strong,nonatomic)UIButton *pickerbtn;

#pragma mark-

@end
