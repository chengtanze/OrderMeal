//
//  CustomBasePopView.m
//  OrderMeal
//
//  Created by cheng on 15/10/26.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "CustomBasePopView.h"

@implementation CustomBasePopView


-(id)initWithNibName:(NSString *)nibName{
    self = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, view.frame.size.height);
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];

    
    self.myWindow = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    [_myWindow addSubview:self];
    
    [_myWindow makeKeyAndVisible];

    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow makeKeyAndVisible];
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         //[self.backView removeFromSuperview];
                     }];
    
}

@end
