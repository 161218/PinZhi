//
//  define.h
//  here
//
//  Created by ptmc on 14-8-27.
//  Copyright (c) 2014年 ptmc. All rights reserved.
//

#ifndef here_define_h
#define here_define_h
//平台信息
#define D_HOST          [DynamicParameter sharedDynamicParameter].socketHost //@"192.168.0.42"
#define D_PORT          [[DynamicParameter sharedDynamicParameter].socketPort intValue] //8110
#define D_VERSION       @"1.0.0"
#define D_PLATFORM      2   //平台号
#define D_CHANNEL       0   //渠道号

#define D_URL_ENGINE    [DynamicParameter sharedDynamicParameter].urlEngine //@"http://192.168.0.42/el_sdk/engine.php"
//separate cell高度
#define D_CELL_default_half_height          22
#define D_CELL_default_height               44 //ben

#define D_DATE_BEGIN                            @"2000-01-01"
#define D_DATE_SET                              @"2010-06-15"
//一对一

typedef NS_ENUM(NSInteger, ELSex)
{
    ELSexUnset=0, ELSexMale = 1, ELSexFemale=2
};

#define D_CELL_recent_contacts_height           66

#define D_CELL_default_contacts_height          50 //--联系人,设备,cell高
#define D_VIEW_Contacts_headPortrait_height     38 //--联系人,设备,头像高

#define D_CELL_nearby_contacts_height             80 //附近联系人cell高
#define D_CELL_nearby_contacts_headPortrait_height     64 //附近联系人头像高

#define D_CELL_default_new_friend_height        50 //--新朋友cell高
#define D_VIEW_NewFirend_headPortrait_height    38 //--新朋友头像高

#define D_CELL_headPortrait_height              110 //--查看用户信息,我,个人信息,cell高（头像cell)
#define D_VIEW_headPortrait_height              66 //ben--查看用户信息,我,个人信息,头像高
#define D_FEED_headPortrait_height              50 //--查看用户信息,我,个人信息,头像高
#define D_PRAISE_headPortrait_height             30 //--查看用户信息,我,个人信息,头像高

#define D_CELL_recent_contacts_height                    66 //--设备,cell高
#define D_CELL_recent_contacts_headPortrait_height       50 //--设备,cell高

#define D_CELL_Praise_height                    76 //--设备,cell高
#define D_CELL_Praise_headPortrait_height       50 //--设备,cell高

#define D_CELL_HEAD_default1_height             44 //--发送验证cell高

#define D_CELL_signature_textfield_height       160 //签名textview高

#define D_CELL_chat_height                    50 //--设备,cell高
#define D_CELL_chat_headPortrait_height       40 //--设备,cell高
#define D_CELL_chat_time_height               35 //--paopao,cell高

#define D_CELL_helper_message_height                    66 //--,cell高

//cell head 高度
#define D_CELL_HEAD_default_height        1
#define D_CELL_FOOTER_default_height      5

#define D_CELL_feedback_textfield_height       160 //意见与反馈
#define D_MAX_LEN_FEEDBACK                     200
//标题字体
#define D_FONT_title            12
#define D_FONT_bottom_bar       12

//cell标题字体
#define D_FONT_cell_time        14
#define D_FONT_cell_title       16
#define D_FONT_cell_content     14
#define D_FONT_cell_small       12
#define D_FONT_cell_chat        16
//圆角
#define D_IMAGE_cell_corner_radius 4

#define D_BUTTON_BACKGROUND_COLOR_1        [UIColor colorWithRed:0/255.00f green:106/255.00f blue:0/255.00f alpha:0.8]

#define D_CHAT_BACKGROUND_COLOR_1        [UIColor colorWithRed:235/255.00f green:235/255.00f blue:235/255.00f alpha:1]

#define D_MIN_LEN_PASSWORD              6  //最小

#define D_MAX_LEN_VERIFY_CODE           6  //最大
#define D_MAX_LEN_NAME                  20
#define D_MAX_LEN_ACCOUNT               20
#define D_MAX_LEN_PASSWORD              32
#define D_MAX_LEN_DEVICE_SERIAL         16
#define D_MAX_LEN_DEVICE_NAME           32
#define D_MAX_LEN_DEVICE_DESCRIPTION    128
#define D_MAX_LEN_COUNTRY_CODE          6
#define D_MAX_LEN_CHAT_MESSAGE          1024*1024
#define D_MAX_LEN_CHAT_SIGNATURE        20
#endif
