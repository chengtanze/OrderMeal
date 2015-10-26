//
//  MainFoodViewController.m
//  OrderMeal
//
//  Created by cheng on 15/10/22.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MainFoodViewController.h"
#import "MenuDetailsTableViewController.h"
#import "MenuView.h"
#import "CommonMacro.h"

@interface MainFoodViewController () <MenuSeleteDelegate>
@property(strong, nonatomic) MenuView *menuView;
@end

@implementation MainFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Init View

-(void)initViewData{
    [self createMenuView];
}


-(void)createMenuView{

    CGFloat fHeight = self.view.bounds.size.height - (UIKIT_TABBAR_HEIGHT + NAV_TAB_BAR_HEIGHT + UIKIT_NAVIANDSTATUS_HEIGHT);
    CGRect rect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, fHeight);
    self.menuView = [[MenuView alloc]initWithFrame:rect];
    self.menuView.delegate = self;
    [self.view addSubview:self.menuView];
}

-(void)selectCellIndex:(NSIndexPath*)indexPath{
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuDetailsTableViewController * showViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuDetailsTableViewController"];
    
    showViewController.editModal = MenuModal_Show;//UITextBorderStyleRoundedRect;
    [self.navigationController pushViewController:showViewController animated:YES];
    
}

@end
