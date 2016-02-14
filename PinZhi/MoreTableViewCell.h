//
//  MoreTableViewCell.h
//  PinZhi
//
//  Created by 刘子阳 on 15/7/5.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewButton.h"

@interface MoreTableViewCell : UITableViewCell

@property (nonatomic,retain)UIImageView *backgroundImageView;
@property (nonatomic,retain)UILabel *nameLabel;
@property (nonatomic,retain)NewButton *yesOrNoBtn;
@property (nonatomic,retain)UILabel *picLabel;
@property (nonatomic,retain)UIButton *picBtn;
@property (nonatomic,retain)UITextView *informationTF;

@end
