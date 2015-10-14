//
//  MenuViewController.m
//  OrderMeal
//
//  Created by cheng on 15/10/14.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuView.h"

@interface MenuViewController ()
@property(nonatomic, strong)MenuView * menuView;


- (IBAction)completeClick:(id)sender;


@end

@implementation MenuViewController

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
    self.menuView = [[MenuView alloc]init];
    
    if (nil != self.menuView) {
        self.navigationItem.leftBarButtonItem = [self.menuView createRightNaviItem];
    }
    
}

- (IBAction)completeClick:(id)sender {
    NSLog(@"completeClick");
}
@end
