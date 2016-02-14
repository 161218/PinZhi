//
//  HeadView.m
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/24.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import "HeadView.h"
#import "FriendGroup.h"

@interface HeadView()
{
    UIButton *_bgButton;
    UIButton *_bg2Button;
    UILabel *_numLabel;
}
@end

@implementation HeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    HeadView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        bgButton.backgroundColor=[UIColor whiteColor];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *bgButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton2 setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [bgButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton2.imageView.contentMode = UIViewContentModeCenter;
        bgButton2.imageView.clipsToBounds = NO;
        bgButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        bgButton2.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [self addSubview:bgButton];
        [self addSubview:bgButton2];
        
        _bg2Button=bgButton2;
        _bgButton = bgButton;
    }
    return self;
}

- (void)headBtnClick
{
    _friendGroup.opened = !_friendGroup.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
        [_delegate clickHeadView];
    }
}

- (void)setFriendGroup:(FriendGroup *)friendGroup
{
    _friendGroup = friendGroup;
    [_bgButton setTitle:friendGroup.name forState:UIControlStateNormal];
}

- (void)didMoveToSuperview
{
    _bg2Button.imageView.transform = _friendGroup.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _bgButton.frame=CGRectMake(5,0,self.frame.size.width-10,50);
    _bg2Button.frame=CGRectMake(self.frame.size.width - 70, 0, 60, self.frame.size.height-5);
}
@end
