//
//  OrderHandlingView.h
//  OrderMeal
//
//  Created by cheng on 15/10/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderHandlingSeleteDelegate <NSObject>

-(void)selectCellIndex:(NSIndexPath*)indexPath;

@end

@interface OrderHandlingView : UIView
@property(weak, nonatomic) id<OrderHandlingSeleteDelegate> delegate;
@property(strong, nonatomic) NSArray * arrayTableNum;
@end
