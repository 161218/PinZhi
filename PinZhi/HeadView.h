//
//  HeadView.h
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/24.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//


#import <UIKit/UIKit.h>
@class FriendGroup;

@protocol HeadViewDelegate <NSObject>

@optional
- (void)clickHeadView;

@end

@interface HeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) FriendGroup *friendGroup;

@property (nonatomic, weak) id<HeadViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
