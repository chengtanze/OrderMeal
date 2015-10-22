//
//  MenuCollectionViewCell.h
//  OrderMeal
//
//  Created by cheng on 15/10/16.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuCollectionCellDelegate <NSObject>

-(void)selectCellIndex:(NSIndexPath*)indexPath;

@end


@interface MenuCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodValueLable;
@property (weak, nonatomic) id<MenuCollectionCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *choiceBtn;
@property (assign, nonatomic) BOOL bChoice;

- (IBAction)foodChoiceBtn:(id)sender;



-(id)initWithFrame:(CGRect)frame;
-(void)selectMenuCell;
@end
