//
//  QualityTwoInfoViewController.h
//  PinZhi
//
//  Created by HUPU on 15/7/9.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreTableViewCell.h"
#import "NewButton.h"
#import "AFHTTPRequestOperation.h"
#import "macro.h"
#import "QualityModel.h"
#import "UIWindow+YzdHUD.h"

@interface QualityTwoInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NSXMLParserDelegate,UIAlertViewDelegate>

{
    UIButton *btnadd;//返回顶部
    UIButton *footBtn;
}

@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)NSMutableArray *qualityArray;

@property(strong,nonatomic)NSMutableDictionary *qualityDict;

@property(strong,nonatomic)NSMutableArray *btnArray;

@property(strong,nonatomic)NSMutableDictionary *btnDict;

@property(retain,nonatomic)NSMutableArray *photoViewArray;


@property(strong,nonatomic)NSString *useInfo;
@property(strong,nonatomic)NSString *useName;


@property(nonatomic,assign)int indexPath;

@property(nonatomic,assign)int section;

//        taskformid
//        indexids
//        indexvalues
//        indexmenus
//        images
@property(strong,nonatomic)NSString *taskformid;
@property(strong,nonatomic)NSMutableArray *indexidsArray;
@property(strong,nonatomic)NSMutableArray *indexvaluesArray;
@property(strong,nonatomic)NSMutableArray *indexmenusArray;
@property(strong,nonatomic)NSMutableArray *imagesArray;
@property(nonatomic,assign)int imagesTag;
@property(nonatomic,assign)int indexmenusTag;

@property(nonatomic,assign)BOOL Time;
@end
