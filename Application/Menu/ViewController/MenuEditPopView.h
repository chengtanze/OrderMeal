//
//  MenuEditPopView.h
//  OrderMeal
//
//  Created by cheng on 15/10/26.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "CustomBasePopView.h"

@protocol MenuDetailEditDelegate <NSObject>

-(void)editMenuClick;
-(void)delMenuClick;

@end

@interface MenuEditPopView : CustomBasePopView

@property(weak, nonatomic) id<MenuDetailEditDelegate> delegate;
- (IBAction)cancleClick:(id)sender;
- (IBAction)editClick:(id)sender;
- (IBAction)delClick:(id)sender;

@end
