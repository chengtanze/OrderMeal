//
//  MenuView.m
//  OrderMeal
//
//  Created by cheng on 15/10/14.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIBarButtonItem *)createRightNaviItem
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    view.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    return backbutton;
}

@end
