//
//  CustomBasePopView.h
//  OrderMeal
//
//  Created by cheng on 15/10/26.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBasePopView : UIView


- (void)showInView:(UIView *) view;
- (void)cancelPicker;

@property (strong, nonatomic) UIView * backView;
@property (strong, nonatomic) UIWindow * myWindow;

-(id)initWithNibName:(NSString *)nibName;
@end
