//
//  MenuView.h
//  OrderMeal
//
//  Created by cheng on 15/10/14.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"

@protocol MenuSeleteDelegate <NSObject>

-(void)selectCellIndex:(NSIndexPath*)indexPath;

@end

@interface MenuView : UIView

@property(weak, nonatomic) id<MenuSeleteDelegate> delegate;

@end
