//
//  OrderDetailView.m
//  OrderMeal
//
//  Created by cheng on 15/11/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initLocalView];
    }
    
    return self;
}

-(void)initLocalView{
    
    //self.orderTableView = [self createTableView];
    
    //[self addSubview:self.orderTableView];
}

@end
