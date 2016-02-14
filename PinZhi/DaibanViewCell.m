
//
//  DaibanViewCell.m
//  PinZhi
//
//  Created by 刘子阳 on 15/9/1.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "DaibanViewCell.h"

@implementation DaibanViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, [[UIScreen mainScreen] applicationFrame].size.width - 100, 44)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:13];
//        _nameLabel.numberOfLines = 0;
        [self addSubview:_nameLabel];
    }
    return self;
}
@end
