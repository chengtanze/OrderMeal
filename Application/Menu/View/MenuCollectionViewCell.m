//
//  MenuCollectionViewCell.m
//  OrderMeal
//
//  Created by cheng on 15/10/16.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MenuCollectionViewCell.h"

#define ORDERMEAL_MENU_COLLECTIONCELL_BOTTOMHEIGHT 30.0

@interface MenuCollectionViewCell()

@property(strong, nonatomic)UIImage *checkImage;
@property(strong, nonatomic)UIImage *unCheckImage;
@end


@implementation MenuCollectionViewCell

//-(id)init{
//    if (self = [super init]) {
//        self.backImageView = [[UIImageView alloc]initWithFrame:frame];
//        self.backImageView.image = [UIImage imageNamed:@"shrimp"];
//        
//        self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - ORDERMEAL_MENU_COLLECTIONCELL_BOTTOMHEIGHT, frame.size.width, ORDERMEAL_MENU_COLLECTIONCELL_BOTTOMHEIGHT)];
//        
//        self.bottomView.backgroundColor = [UIColor blackColor];
//        self.bottomView.alpha = 0.3;
//        
//        [self addSubview:self.backImageView];
//        [self addSubview:self.bottomView];
//    }
//    
//    return self;
//}
- (void)awakeFromNib {
    // Initialization code
    _bChoice = FALSE;
    
    self.checkImage = [UIImage imageNamed:@"checkbox1_checked@2x.png"];
    self.unCheckImage = [UIImage imageNamed:@"checkbox1_unchecked@2x.png"];
}

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _bChoice = FALSE;
        
        self.checkImage = [UIImage imageNamed:@"checkbox1_checked.png"];
        self.unCheckImage = [UIImage imageNamed:@"checkbox1_unchecked.png"];
        
//        if (nil == self.backImageView) {
//            
//            CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
//            
//            self.backImageView = [[UIImageView alloc]initWithFrame:rect];
//            self.backImageView.tag = 1;
//            [self addSubview:self.backImageView];
//        }
//
//        self.contentView.backgroundColor = [UIColor brownColor];
//        
//        if (nil == self.bottomView){
//            self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - ORDERMEAL_MENU_COLLECTIONCELL_BOTTOMHEIGHT, frame.size.width, ORDERMEAL_MENU_COLLECTIONCELL_BOTTOMHEIGHT)];
//            
//            self.bottomView.backgroundColor = [UIColor blackColor];
//            self.bottomView.alpha = 0.5;
//            
//            self.foodName = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 35)];
//            self.foodName.text = @"油焖大虾";
//            //self.foodName.
//            //self.foodName.backgroundColor = [UIColor redColor];
//            [self.bottomView addSubview:self.foodName];
//            
//            [self addSubview:self.bottomView];
//        }
    }
    
    return self;
}

-(void)selectMenuCell{
    _bChoice = !_bChoice;
    self.choiceBtn.selected = _bChoice;
}

- (IBAction)foodChoiceBtn:(id)sender {
    NSLog(@"btn");
}
@end
