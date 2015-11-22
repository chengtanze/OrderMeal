//
//  OrderDetailTableViewCell.h
//  OrderMeal
//
//  Created by cheng on 15/10/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *tableNumLB;
@property (weak, nonatomic) IBOutlet UILabel *teaSiteLB;
@property (weak, nonatomic) IBOutlet UILabel *childNumLB;
@property (weak, nonatomic) IBOutlet UILabel *teaLB;


@property (weak, nonatomic) IBOutlet UIView *backGroupView;
@property(strong, nonatomic) UIView * backImageView;

-(void)createOrderBackViewImage;
@end
