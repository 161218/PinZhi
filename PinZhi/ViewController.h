//
//  ViewController.h
//  PinZhi
//
//  Created by 刘子阳 on 15/6/30.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+XJY.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MyMD5.h"

#import "ASIHTTPRequest.h"
@protocol LoginViewController <NSObject>

@optional
- (void)loginSuccess;
- (void)loginFail;
@end

@interface ViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate,NSXMLParserDelegate>

@property(nonatomic, strong)NSString *Username;

@property (nonatomic, weak) id<LoginViewController> delegate;

@property(nonatomic,strong)NSXMLParser *xmlParserTwo;

@property(nonatomic,assign)BOOL isFrist;

@property(nonatomic,assign)BOOL isSecend;

@property(nonatomic,assign)BOOL isInfo;

@property(nonatomic,strong)NSMutableArray *infoArray;

@property(nonatomic,strong)NSArray *userInfoArray;


@end

