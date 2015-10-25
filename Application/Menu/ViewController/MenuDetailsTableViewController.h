//
//  MenuDetailsTableViewController.h
//  OrderMeal
//
//  Created by cheng on 15/10/22.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    MenuModal_Show = 0,
    MenuModal_Edit,
}MenuDetailModal;

@interface MenuDetailsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIView *menuImageView;

@property (weak, nonatomic) IBOutlet UITextField *foodNameTF;
@property (weak, nonatomic) IBOutlet UITextField *foodVauleTF;
@property (weak, nonatomic) IBOutlet UITextField *foodMakeTF;
@property (weak, nonatomic) IBOutlet UITextField *foodUnitTF;
@property(assign, nonatomic) MenuDetailModal editModal;

-(void)setMenuDetailEditModal:(MenuDetailModal)editModal;

@end
