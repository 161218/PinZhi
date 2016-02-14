//
//  RSpecialViewController.h
//  PinZhi
//
//  Created by HUPU on 15/7/20.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "macro.h"
#import "SpecialModel.h"

@interface RSpecialViewController : UIViewController

{
    
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
    
    UIImageView *photoImageView;
}

@property(nonatomic,retain)SpecialModel *specialModel;


@end
