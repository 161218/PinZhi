//
//  GuoQiTwoViewController.h
//  PinZhi
//
//  Created by 刘子阳 on 15/8/6.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreTableViewCell.h"
#import "AFHTTPRequestOperation.h"
#import "macro.h"
#import "QualityModel.h"

@interface GuoQiTwoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,NSXMLParserDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
{
    UIButton *btnadd;//返回顶部

}
@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)NSString *useInfo;
@property(strong,nonatomic)NSString *useName;
@property(strong,nonatomic)NSMutableArray *qualityArray;
@property(strong,nonatomic)NSMutableArray *btnArray;
@property(retain,nonatomic)NSMutableArray *photoViewArray;

@property(strong,nonatomic)NSMutableArray *indexidsArray;
@property(strong,nonatomic)NSMutableArray *indexvaluesArray;
@property(strong,nonatomic)NSMutableArray *indexmenusArray;
@property(strong,nonatomic)NSMutableArray *imagesArray;

@property(nonatomic,assign)int indexPath;
@property(nonatomic,assign)int section;

@property(nonatomic,assign)int imagesTag;
@property(nonatomic,assign)int indexmenusTag;

@end
