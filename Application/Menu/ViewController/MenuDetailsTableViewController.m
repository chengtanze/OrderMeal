//
//  MenuDetailsTableViewController.m
//  OrderMeal
//
//  Created by cheng on 15/10/22.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MenuDetailsTableViewController.h"
#import "Custom_ScrollImageView.h"

@interface MenuDetailsTableViewController () <CustromScrollImageViewTapDelegate>
@property(strong, nonatomic)Custom_ScrollImageView * srcollImage;
@end

@implementation MenuDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initLocalData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{

    static BOOL bFirst = NO;
    //if (!bFirst) {
        bFirst = YES;
        
        NSString *str1 = @"potato.jpg";
        NSString *str2 = @"fish.jpg";
        NSString *str3 = @"shrimp.jpg";
        
        
        NSArray * array = @[str1, str2, str3];
        CGRect rect = self.menuImageView.bounds;
        rect.size.width = 320;
        self.srcollImage = [[Custom_ScrollImageView alloc]initWithFrame:rect  picArray:array];
        self.srcollImage.delegate = self;
        [self.menuImageView addSubview:self.srcollImage];
        [_srcollImage upDataScrollViewPoint];
   // }

}

-(void)ScrollImageViewdidSelectRowAtIndexPath:(NSInteger)index{
    
}

-(void)initLocalData{
    UITextBorderStyle borderStyle;
    if (MenuModal_Show == _editModal) {
        borderStyle = UITextBorderStyleNone;
    }else{
        borderStyle = UITextBorderStyleBezel;
    }
    
    _foodNameTF.borderStyle = borderStyle;
    _foodVauleTF.borderStyle = borderStyle;
    _foodMakeTF.borderStyle = borderStyle;
    _foodUnitTF.borderStyle = borderStyle;
}

-(void)setMenuDetailEditModal:(MenuDetailModal)editModal{

    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
