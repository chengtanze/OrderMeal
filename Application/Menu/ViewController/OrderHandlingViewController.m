//
//  OrderHandlingViewController.m
//  OrderMeal
//
//  Created by cheng on 15/10/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderHandlingViewController.h"
#import "OrderHandlingView.h"
#import "CommonMacro.h"

#define ORDERMEAL_ORDER_SPACE 10.0
#define ORDERMEAL_ORDER_HEADIMAGESIZE (30.0)


@interface OrderHandlingViewController () <OrderHandlingSeleteDelegate>
@property(strong, nonatomic) OrderHandlingView *orderView;
@end

@implementation OrderHandlingViewController

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

-(void)initViewData{
    [self createMenuView];
}

-(void)createMenuView{
    self.orderView = [[OrderHandlingView alloc]initWithFrame:self.view.bounds];
    self.orderView.delegate = self;
    [self.view addSubview:self.orderView];
}


-(void)selectCellIndex:(NSIndexPath*)indexPath{
    
}

@end
