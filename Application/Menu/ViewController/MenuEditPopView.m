//
//  MenuEditPopView.m
//  OrderMeal
//
//  Created by cheng on 15/10/26.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MenuEditPopView.h"

@implementation MenuEditPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)cancleClick:(id)sender {
    [self cancelPicker];
}

- (IBAction)editClick:(id)sender {
    if (_delegate != nil && [self.delegate respondsToSelector:@selector(editMenuClick)]) {
        [_delegate editMenuClick];
    }

}

- (IBAction)delClick:(id)sender {
    if (_delegate != nil && [self.delegate respondsToSelector:@selector(delMenuClick)]) {
        [_delegate delMenuClick];
    }

}
@end
