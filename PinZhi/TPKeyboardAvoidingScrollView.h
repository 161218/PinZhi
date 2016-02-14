//
//  TPKeyboardAvoidingScrollView.h
//  AnPuLiHotel
//
//  Created by 刘子阳 on 15/6/23.
//  Copyright (c) 2015年 刘子阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPKeyboardAvoidingScrollView : UIScrollView{
    UIEdgeInsets    _priorInset;
    BOOL            _priorInsetSaved;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    CGSize          _originalContentSize;
}

- (void)adjustOffsetToIdealIfNeeded;

@end

