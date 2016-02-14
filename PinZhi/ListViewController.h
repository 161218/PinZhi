//
//  ListViewController.h
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/24.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UITableViewController

@property(strong,nonatomic)NSArray *jiuidanData;

@property(nonatomic,assign)int indexPath;

@property(nonatomic,assign)int section;


@end
