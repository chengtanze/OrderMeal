//
//  UnPaymentViewController.m
//  OrderMeal
//
//  Created by cheng on 15/10/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "UnPaymentViewController.h"
#import "OrderView.h"
#import "OrderDetailViewController.h"
#import "HttpProtocolAPI.h"
#import "UserDataInterface.h"

@interface UnPaymentViewController ()<OrderSeleteDelegate>

@property(strong, nonatomic)OrderView *orderView;

@end

@implementation UnPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLocalView];
    
    [self initNetWorkData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLocalView{
    
    self.orderView = [[OrderView alloc]initWithFrame:self.view.bounds];
    _orderView.delegate = self;
    [self.view addSubview:self.orderView];
}

-(void)initNetWorkData{
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]initWithCapacity:10];
    [params setObject: [NSNumber numberWithInteger:[UserDataInterface sharedClient].storeID_Int] forKey:@"store_id"];
    [params setObject: [NSNumber numberWithInteger:20] forKey:@"size"];
    [params setObject: [NSNumber numberWithInteger:1] forKey:@"page"];
    [params setObject: [NSNumber numberWithInteger:0] forKey:@"pay_state"];
    
    [[HttpProtocolAPI sharedClient]getOrdersByPayState:0 orderParams:params setBlock:^(NSDictionary *data, NSError *error) {
        if (data != nil && [self getRetDataState:data]) {
            NSArray * orders = [data valueForKey:@"data"];
            if(![orders respondsToSelector:@selector(objectAtIndex:)]){
                NSLog(@"data is null");
            }
            else{
                self.orderView.ordersArray = self.ordersArray = [data valueForKey:@"data"];
                [self.orderView updateOrdersTableView];
            }
        }
    }];
    
}

-(BOOL)getRetDataState:(NSDictionary *)data{
    BOOL ret = NO;
    if (data != nil) {
        NSNumber * numberState = [data valueForKey:@"state"];
        NSInteger state = numberState.integerValue;
        if (state == 0) {
            ret = YES;
        }
    }
    
    return ret;
}

#pragma mark delegate
-(void)selectOrderIndex:(NSIndexPath*)indexPath{
    
    OrderDetailViewController * orderDetail = [[OrderDetailViewController alloc]init];
    
    [self.navigationController pushViewController:orderDetail animated:YES];
    
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
