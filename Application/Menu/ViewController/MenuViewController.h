//
//  MenuViewController.h
//  OrderMeal
//
//  Created by cheng on 15/10/14.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MainMenu_OrderComplete,
    MainMenu_AddNewMenu,

} eButtonType;

@protocol mainButtonSeleteDelegate <NSObject>

-(void)selectButtonType:(eButtonType)type;

@end


@interface MenuViewController : UIViewController
- (IBAction)completeClick:(id)sender;
@property(weak, nonatomic)id<mainButtonSeleteDelegate> delegate;

@end
