//
//  OrderViewController.m
//  OrderMeal
//
//  Created by cheng on 15/10/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderViewController.h"
#import "UnPaymentViewController.h"
#import "PaymentViewController.h"
#import "SCNavTabBarController.h"


#define ORDERMEAL_ORDER_SPACE 10.0
#define ORDERMEAL_ORDER_HEADIMAGESIZE (30.0)
@interface OrderViewController ()

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViewData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViewData{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.188 green:0.851 blue:0.639 alpha:1];
    
    self.navigationItem.leftBarButtonItem = [self createLeftNaviItem];
    
    [self initNavBar];
    
}

-(void)initNavBar{
    
    UnPaymentViewController * oneViewController = [[UnPaymentViewController alloc]init];
    
    oneViewController.title = @"未买单";
    
    PaymentViewController * twoViewController = [[PaymentViewController alloc]init];
    twoViewController.title = @"已买单";
    
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneViewController, twoViewController];
    navTabBarController.showArrowButton = NO;
    [navTabBarController addParentController:self];
}

-(UIBarButtonItem *)createLeftNaviItem
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    
    UIImageView * imageHeadView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_launcher"]];
    imageHeadView.frame = CGRectMake(0, 0, 40, 40);
    
    imageHeadView.layer.masksToBounds = YES;
    imageHeadView.layer.cornerRadius = imageHeadView.bounds.size.height / 2.0; //设置图片圆角的尺度
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, (44 - ORDERMEAL_ORDER_HEADIMAGESIZE)/ 2.0, ORDERMEAL_ORDER_HEADIMAGESIZE, ORDERMEAL_ORDER_HEADIMAGESIZE)];
    
    
    [btn addTarget:self action:@selector(SingleTap:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"avatar_default"] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.bounds.size.height / 2.0; //设置图片圆角的尺度
    
    
    [view addSubview:btn];
    
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    return backbutton;
}

#pragma mark events
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    NSLog(@"index");
}


- (IBAction)completeClick:(id)sender {
    NSLog(@"completeClick");
    
//    OrderHandlingViewController * viewController = [[OrderHandlingViewController alloc]init];
//    
//    [self.navigationController pushViewController:viewController animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
