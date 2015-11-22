//
//  OrderHandCollectionViewCell.m
//  OrderMeal
//
//  Created by cheng on 15/10/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderHandCollectionViewCell.h"





@implementation OrderHandCollectionViewCell
- (void)awakeFromNib {
    // Initialization code
    _bChoice = FALSE;
    
}

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _bChoice = FALSE;
  
    }
    
    return self;
}

-(void)selectMenuCell{
    _bChoice = !_bChoice;
    self.choiceBtn.selected = _bChoice;
}

- (IBAction)choiceClick:(id)sender {
    [self selectMenuCell];
    
    
}
@end
