//
//  OrderHandlingViewController.h
//  OrderMeal
//
//  Created by cheng on 15/10/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"

@interface OrderHandlingViewController : UIViewController

//订单ID列表
@property(strong, nonatomic)NSArray * selectOrderMenuList;
@property(strong, nonatomic) NSMutableArray * arrayTableNum;

@end
