//
//  AdminService.h
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/24.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AdminService : NSObject

//验证用户名和密码，返回验证结果
-(NSString *) CheckLoginUser:(NSString *) username Pass:(NSString *) password;

@end
