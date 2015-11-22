//
//  OrderDetailTableViewCell.m
//  OrderMeal
//
//  Created by cheng on 15/10/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self createOrderBackViewImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)createOrderBackViewImage{
    self.backImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.bounds.size.width, 100)];
    
    self.backImageView.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:self.backImageView];
}


@end
