//
//  RootTabBarViewController.m
//  OrderMeal
//
//  Created by cheng on 15/9/14.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "LoginViewController.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController * LoginViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    
//    UITabBarItem * baritem1 = [[UITabBarItem alloc]initWithTitle:@"" image:nil selectedImage:nil];
//    LoginViewController.tabBarItem = baritem1;
//    
//    NSArray * array = @[LoginViewController];
//    
//    self.viewControllers = array;
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

@end
