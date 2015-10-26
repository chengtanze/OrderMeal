//
//  MenuDetailsTableViewController.m
//  OrderMeal
//
//  Created by cheng on 15/10/22.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MenuDetailsTableViewController.h"
#import "Custom_ScrollImageView.h"
#import "MenuEditPopView.h"
#import "Media_Photo.h"



@implementation structPhotoInfo


@end

@interface MenuDetailsTableViewController () <getPhotoInfoDelegate, photoGroupDelegate, UITextFieldDelegate, CustromScrollImageViewTapDelegate, MenuDetailEditDelegate>
{
    Media_Photo * mediaPhoto;
    NSInteger selectPhotoIndex;
    
}
@property(strong, nonatomic)Custom_ScrollImageView * srcollImage;
@property(nonatomic, strong)NSMutableArray *imageArray;
@property(strong, nonatomic)UIBarButtonItem *editBarButton;
@property(strong, nonatomic)UIBarButtonItem *completeBarButton;

@end

@implementation MenuDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initLocalData];
    
    [self initLocalView];
    
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

-(void)initLocalView{
    self.editBarButton = [[UIBarButtonItem alloc]
                                 initWithTitle:@"编辑"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(barBtnEditAction:)];
    
    self.completeBarButton= [[UIBarButtonItem alloc]
                             initWithTitle:@"完成"
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(barBtnCompleteAction:)];
    
    self.navigationItem.rightBarButtonItem = self.editBarButton;
}

-(void)showBarButtonWithType:(MenuBarButtonType)type{
    
    if (BarButton_Edit == type) {
        if (self.editBarButton != nil) {
            self.navigationItem.rightBarButtonItem = self.editBarButton;
        }
    }
    else{
        if (self.completeBarButton != nil) {
            self.navigationItem.rightBarButtonItem = self.completeBarButton;
        }
    }
}

-(void)initLocalData{
    selectPhotoIndex = -1;
    self.photoGroupView.delegate = self;
    
    self.imageArray = [[NSMutableArray alloc]initWithCapacity:5];
    for (int index = 0; index < 5; index++) {
        structPhotoInfo * imageInfo = [[structPhotoInfo alloc]init];
        imageInfo.image = nil;
        imageInfo.isPhoto = NO;
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:imageInfo, [NSString stringWithFormat:@"%d", index], nil];
        [self.imageArray addObject:dic];
    }
    
    
    mediaPhoto = [[Media_Photo alloc]init];
    if (mediaPhoto != nil) {
        mediaPhoto.showInViewController = self;
        mediaPhoto.delegate = self;
    }
    
    UITextBorderStyle borderStyle;
    if (MenuModal_Show == _editModal) {
        borderStyle = UITextBorderStyleNone;
    }else{
        borderStyle = UITextBorderStyleRoundedRect;
    }
    
    _foodNameTF.borderStyle = borderStyle;
    _foodVauleTF.borderStyle = borderStyle;
    _foodMakeTF.borderStyle = borderStyle;
    _foodUnitTF.borderStyle = borderStyle;
    
    self.foodNameTF.delegate = self;
    self.foodVauleTF.delegate = self;
    self.foodMakeTF.delegate = self;
    self.foodUnitTF.delegate = self;
}

-(void)setMenuDetailEditModal:(MenuDetailModal)editModal{

    
}

-(void)barBtnEditAction:(id)sender{
    NSLog(@"barBtnAction");
    
    
    MenuEditPopView * pop = [[MenuEditPopView alloc]initWithNibName:@"MenuEditPopView"];
    pop.delegate = self;
    
    [pop showInView:self.view];
    
    
}

-(void)barBtnCompleteAction:(id)sender{
    NSLog(@"barBtnCompleteAction");
    
    [self showBarButtonWithType:BarButton_Edit];
}


-(void)editMenuClick{
    NSLog(@"editMenuClick");
    
    _editModal = MenuModal_Edit;
    _foodNameTF.borderStyle = UITextBorderStyleRoundedRect;
    _foodVauleTF.borderStyle = UITextBorderStyleRoundedRect;
    _foodMakeTF.borderStyle = UITextBorderStyleRoundedRect;
    _foodUnitTF.borderStyle = UITextBorderStyleRoundedRect;
    
    self.photoGroupView.hidden = NO;
    
    [self showBarButtonWithType:BarButton_Complete];
    
}

-(void)delMenuClick{
    NSLog(@"delMenuClick");
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL bRet = YES;
    
    if (MenuModal_Show == _editModal)
        bRet = NO;

    return bRet;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    
    if ([self.foodNameTF isFirstResponder])
    {
        [self.foodVauleTF becomeFirstResponder];
    }
    else if([self.foodVauleTF isFirstResponder])
    {
        [self.foodUnitTF becomeFirstResponder];
    }
    else if([self.foodUnitTF isFirstResponder])
    {
        [self.foodMakeTF becomeFirstResponder];
    }
    else if([self.foodMakeTF isFirstResponder])
    {
        [self.foodMakeTF resignFirstResponder];
    }

    
    return YES;
}

-(void)selectPhotoIndex:(NSInteger)index{
    selectPhotoIndex = index;
    
    NSDictionary * item = self.imageArray[selectPhotoIndex];
    NSString * key = [NSString stringWithFormat:@"%ld", (long)selectPhotoIndex];
    structPhotoInfo * info = [item objectForKey:key];
    BOOL isPhoto = info.isPhoto;
    if (isPhoto) {
        //判断当前控件背景是默认还是用户拍摄的照片
        
//        UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        GoodsPhotoViewController * infoView = [mainStoryboard instantiateViewControllerWithIdentifier:@"GoodsPhotoView"];
//        
//        infoView.photoImage = info.image;
//        
//        
//        [self.navigationController pushViewController:infoView animated:YES];
//        
//        [infoView updatePhoto];
    }
    else{

        
        [mediaPhoto chooseImage];
    }
}

#pragma mark - Media_Photo delegate
-(void)getPhoto:(UIImage *)image{
    
    NSMutableDictionary * item = self.imageArray[selectPhotoIndex];
    NSString * key = [NSString stringWithFormat:@"%ld", (long)selectPhotoIndex];
    structPhotoInfo * info = [item objectForKey:key];
    info.image = image;
    info.isPhoto = YES;
    
    
    //    NSString * key = [NSString stringWithFormat:@"%ld", (long)selectPhotoIndex];
    //    structPhotoInfo * info = [[structPhotoInfo alloc]init];
    //    info.image = image;
    //    info.isPhoto = YES;
    //    NSDictionary * item = [[NSDictionary alloc]initWithObjectsAndKeys:info,key, nil];
    
    
    //    [self.imageArray addObject:item];
    
    [_photoGroupView setPhoto:image byIndex:selectPhotoIndex];
    
    
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
