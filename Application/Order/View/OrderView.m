//
//  OrderView.m
//  OrderMeal
//
//  Created by cheng on 15/10/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderView.h"
#import "OrderDetailTableViewCell.h"

@interface OrderView() <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic)UITableView * orderTableView;

@end

@implementation OrderView

//

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initLocalView];
    }
    
    return self;
}

-(void)initLocalView{
    self.backgroundColor = [UIColor redColor];
    
    self.orderTableView = [self createTableView];
    
    [self addSubview:self.orderTableView];
}

-(UITableView *)createTableView{
    
    UITableViewStyle style = UITableViewStyleGrouped;

    
    UITableView * tableview = [[UITableView alloc]initWithFrame:self.bounds style:style];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [tableview registerNib: [UINib nibWithNibName:@"OrderDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellIndextifier"];
    
    return tableview;
}

-(void)updateOrdersTableView{
    
    [self.orderTableView reloadData];
    
}

#pragma mark tableview delegate
//调用顺序－1 返回节数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // NSLog(@"numberOfSectionsInTableView ;%ld", sectionArray.count);
    return (_ordersArray != nil ? _ordersArray.count : 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * order = _ordersArray[indexPath.section];
    if (order != nil) {
        NSArray * dish = [order valueForKey:@"dish"];
        if ((dish == nil) || ![dish respondsToSelector:@selector(objectAtIndex:)]) {
            return 110;
        }
    }

    return 200;
}

//调用顺序－2 根据section（节数）返回数据个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // NSLog(@"numberOfRowsInSection ;%ld", [sectionArray[section] count]);
    return 1;
}

//调用顺序－3 设置单元格数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"CellIndextifier";
    OrderDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[OrderDetailTableViewCell alloc] init];
    }
    
   
    NSDictionary * order = _ordersArray[indexPath.section];
    if (order != nil) {
        NSArray * dish = [order valueForKey:@"dish"];
        if ((dish == nil) || ![dish respondsToSelector:@selector(objectAtIndex:)]) {
            cell.backImageView.hidden = YES;
            // NSLog(@"index :%ld hide", indexPath.section);
        }
        else{
            cell.backImageView.hidden = NO;
            //NSLog(@"index :%ld show", indexPath.section);
        }
        
        
        NSString * tableNO = [order valueForKey:@"table_num"];
        NSString * orderNO = [order valueForKey:@"order_num"];
        
        NSNumber * adultNum = [order valueForKey:@"adult_num"];
        NSNumber * childNum = [order valueForKey:@"child_num"];
        
        cell.orderIDLabel.text = orderNO;
        cell.tableNumLB.text = tableNO;
        
        cell.teaSiteLB.text = [NSString stringWithFormat:@"%ld", adultNum.integerValue];
        cell.childNumLB.text = [NSString stringWithFormat:@"%ld", childNum.integerValue];
    }
    
    


    return cell;
}

//用户点击单元格，调用该方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"didSelectRowAtIndexPath section:%ld, row:%ld", indexPath.section, indexPath.row);
    
    if (_delegate != nil && [self.delegate respondsToSelector:@selector(selectOrderIndex:)]) {
        [_delegate selectOrderIndex:indexPath];
    }

}

@end
