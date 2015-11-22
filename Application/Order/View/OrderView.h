//
//  OrderView.h
//  OrderMeal
//
//  Created by cheng on 15/10/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol OrderSeleteDelegate <NSObject>

-(void)selectOrderIndex:(NSIndexPath*)indexPath;

@end

@interface OrderView : UIView

@property(weak, nonatomic)id<OrderSeleteDelegate> delegate;
@property(strong, nonatomic)NSArray * ordersArray;

-(void)updateOrdersTableView;
@end
