//
//  LoginViewController.m
//  OrderMeal
//
//  Created by cheng on 15/9/15.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userPassWordTF;
- (IBAction)loginClick:(id)sender;

- (IBAction)registerClick:(id)sender;

- (IBAction)findPassWordClick:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)loginClick:(id)sender {
}

- (IBAction)registerClick:(id)sender {
}

- (IBAction)findPassWordClick:(id)sender {
}
@end
