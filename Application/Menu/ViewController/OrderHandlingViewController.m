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
#import "HttpProtocolAPI.h"
#import "UserDataInterface.h"

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
    
    self.arrayTableNum = [[NSMutableArray alloc]initWithCapacity:10];
    for (NSUInteger nIndex = 0; nIndex < 20; nIndex++) {
        [self.arrayTableNum addObject:[NSNumber numberWithUnsignedInteger:nIndex]];
    }
    
    
    self.orderView.arrayTableNum = self.arrayTableNum;
}

-(void)createMenuView{
    self.orderView = [[OrderHandlingView alloc]initWithFrame:self.view.bounds];
    self.orderView.delegate = self;
    [self.view addSubview:self.orderView];
}


-(void)selectCellIndex:(NSIndexPath*)indexPath{
    
    
    NSString * selectIndex = [NSString stringWithFormat:@"@ld", indexPath.row];
    [self createOrder:selectIndex];
    
    
}

-(void)createOrder:(NSString *)tableID{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]initWithCapacity:10];
    
    [params setObject:tableID forKey:@"table_num"];
    [params setObject: [NSNumber numberWithInteger:[UserDataInterface sharedClient].storeID_Int] forKey:@"store_id"];
//    [params setObject: [NSNumber numberWithInteger:1] forKey:@"store_id"];
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInt:(int)uid];
    [params setObject: userID forKey:@"waiter_id"];
    [params setObject: [NSNumber numberWithInteger:1] forKey:@"adult_num"];
    [params setObject: [NSNumber numberWithInteger:1] forKey:@"child_num"];
    
    [[HttpProtocolAPI sharedClient]createOrder:params setBlock:^(NSDictionary *data, NSError *error) {
        if (data != nil && [self getRetDataState:data]) {
            
            NSDictionary * orderData = [data valueForKey:@"data"];
            
            if (orderData != nil) {
                NSNumber * numberState = [orderData valueForKey:@"id"];
                NSInteger orderID = numberState.integerValue;
                
                if (orderID > 0) {
                    //创建订单成功，上传菜单id
                    [self addNewMenu:orderID];
                }
            }
        }
        
    }];
    
}

-(void)addNewMenu:(NSUInteger)orderID{
    
    if (self.selectOrderMenuList != nil && self.selectOrderMenuList.count > 0) {
        for (NSUInteger nIndex = 0; nIndex < self.selectOrderMenuList.count; nIndex++) {
            
            NSMutableDictionary * params = [[NSMutableDictionary alloc]initWithCapacity:10];
            
            NSNumber * numberID = self.selectOrderMenuList[nIndex];
            [params setObject:[NSNumber numberWithInteger:numberID.integerValue] forKey:@"dish_id"];
            [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"order_id"];
            [params setObject:[NSNumber numberWithInteger:1] forKey:@"count"];
            [params setObject:@"" forKey:@"declares"];
            
            [[HttpProtocolAPI sharedClient]addMenuInOrder:params setBlock:^(NSDictionary *data, NSError *error) {
                
            }];
        }
    }
    
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

//-(void)

@end
