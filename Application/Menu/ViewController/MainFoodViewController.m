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
#import "HttpProtocolAPI.h"
#import "MenuViewController.h"
#import "OrderHandlingViewController.h"

@interface MainFoodViewController () <MenuSeleteDelegate, mainButtonSeleteDelegate>
@property(strong, nonatomic) MenuView *menuView;
@end

@implementation MainFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViewData];
    
    [self downLoadMenuList];
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
    
    self.arrayChoiceMenuListData = [[NSMutableArray alloc]initWithCapacity:10];
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
    
    showViewController.editModal = MenuModal_Show;
    showViewController.dicMenuDetailData = self.arrayMenuListData[indexPath.row];
    
    [self.navigationController pushViewController:showViewController animated:YES];
    
}

-(void)downLoadMenuList{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithCapacity:10];
    [[HttpProtocolAPI sharedClient]getMenuList:dic menuType:0 setBlock:^(NSDictionary *data, NSError *error) {
        if (data != nil && [self getRetDataState:data]) {
            
            self.menuView.arrayMenuListData = self.arrayMenuListData = [data valueForKey:@"data"];
            
            if(![_arrayMenuListData respondsToSelector:@selector(objectAtIndex:)])
            {
                NSLog(@"is null");
                _arrayMenuListData = nil;
            }
            
            [self.menuView upDateCollectionView];
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

-(void)selectButtonType:(eButtonType)type{
    
    if (type == MainMenu_OrderComplete) {
        
        //服务员权限 点餐完成
        OrderHandlingViewController * viewController = [[OrderHandlingViewController alloc]init];
        
        //将索引转换成菜单ID
   
        viewController.selectOrderMenuList = [self getSelectMenuList];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (type == MainMenu_AddNewMenu){
        
    }
    
}

-(NSArray *)getSelectMenuList{
    
    NSMutableArray * select = [[NSMutableArray alloc]initWithCapacity:10];
    
    for (int nIndex = 0; nIndex < self.menuView.userSelectMenuList.count; nIndex++) {
        NSIndexPath * path = self.menuView.userSelectMenuList[nIndex];
        NSLog(@"select index :%ld", path.row);
        
        if (self.arrayMenuListData != nil) {
            
            NSDictionary * dic = self.arrayMenuListData[path.row];
            
            NSNumber * numberID = [dic valueForKey:@"id"];
            
            if (numberID.integerValue > 0) {
                [select addObject:numberID];
            }
            
        }
        
        
    }
    
    return select;
    
}


@end
