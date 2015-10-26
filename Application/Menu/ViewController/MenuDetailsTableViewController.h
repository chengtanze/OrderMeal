//
//  MenuDetailsTableViewController.h
//  OrderMeal
//
//  Created by cheng on 15/10/22.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoGroupTableViewCell.h"

typedef enum {
    MenuModal_Show = 0,
    MenuModal_Edit,
}MenuDetailModal;

typedef enum {
    BarButton_Edit = 0,
    BarButton_Complete,
}MenuBarButtonType;

@interface structPhotoInfo : NSObject

@property(nonatomic, assign)BOOL isPhoto;
@property(nonatomic, strong)UIImage * image;

@end

@interface MenuDetailsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIView *menuImageView;
@property (weak, nonatomic) IBOutlet UITextField *foodNameTF;
@property (weak, nonatomic) IBOutlet UITextField *foodVauleTF;
@property (weak, nonatomic) IBOutlet UITextField *foodMakeTF;
@property (weak, nonatomic) IBOutlet UITextField *foodUnitTF;
@property (weak, nonatomic) IBOutlet PhotoGroupTableViewCell *photoGroupView;
@property(assign, nonatomic) MenuDetailModal editModal;

-(void)setMenuDetailEditModal:(MenuDetailModal)editModal;


@end
