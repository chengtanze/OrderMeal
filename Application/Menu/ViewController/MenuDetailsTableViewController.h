//
//  MenuDetailsTableViewController.h
//  OrderMeal
//
//  Created by cheng on 15/10/22.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuDetailsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodVauleLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
//@property (weak, nonatomic) IBOutlet UIView *menuImageView;
@property (weak, nonatomic) IBOutlet UIView *menuImageView;

@property (weak, nonatomic) IBOutlet UILabel *foodMakeLabel;
@end
