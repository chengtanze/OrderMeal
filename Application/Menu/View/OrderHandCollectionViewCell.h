//
//  OrderHandCollectionViewCell.h
//  OrderMeal
//
//  Created by cheng on 15/10/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHandCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backGroupView;

@property (weak, nonatomic) IBOutlet UILabel *orderIndexLable;
- (IBAction)choiceClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *choiceBtn;


@property (assign, nonatomic) BOOL bChoice;
@end
