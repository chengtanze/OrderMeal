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
#import "HttpProtocolAPI.h"
#import "UserDataInterface.h"

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
static BOOL bFirst = NO;
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

-(void)viewWillDisappear:(BOOL)animated{
    bFirst = NO;
}

-(void)viewDidLayoutSubviews{

    if (!bFirst) {
        bFirst = YES;
        
        NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:5];
        
        NSArray * dicImage = [_dicMenuDetailData valueForKey:@"pic"];
        if (dicImage != nil ) {
            if([dicImage respondsToSelector:@selector(objectAtIndex:)]){
                for (int nIndex = 0; nIndex < dicImage.count; nIndex++) {
                    NSString * strImage =  [dicImage valueForKey:@"url"][nIndex];
                    
                    [array addObject:strImage];
                    NSLog(@"%@", strImage);
                }
            }
        }
        
        
        
        CGRect rect = self.menuImageView.bounds;
        rect.size.width = 320;
        self.srcollImage = [[Custom_ScrollImageView alloc]initWithFrame:rect  picArray:array type:1];
        self.srcollImage.delegate = self;
        [self.menuImageView addSubview:self.srcollImage];
        [_srcollImage upDataScrollViewPoint];
    }

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
    
    
    if (MenuModal_Add == _editModal) {
        [self editMenu];
    }
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
    
    if(_dicMenuDetailData != nil)
    {
        self.foodNameTF.text = [_dicMenuDetailData valueForKey:@"name"];
        self.foodVauleTF.text = [_dicMenuDetailData valueForKey:@"price"];
        self.foodDeclaresTF.text = [_dicMenuDetailData valueForKey:@"declares"];
    }
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

    if (_editModal == MenuModal_Add) {
        //上传数据
        [self upLoadNewMenu];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_editModal == MenuModal_Edit){
        
        //更新数据
        [self updataMenu];
    }
    
    _editModal = MenuModal_Show;
    _foodNameTF.borderStyle = UITextBorderStyleNone;
    _foodVauleTF.borderStyle = UITextBorderStyleNone;
    _foodMakeTF.borderStyle = UITextBorderStyleNone;
    _foodUnitTF.borderStyle = UITextBorderStyleNone;
    
    self.photoGroupView.hidden = YES;
    
    [self showBarButtonWithType:BarButton_Edit];

    
}



-(void)editMenu{
    _foodNameTF.borderStyle = UITextBorderStyleRoundedRect;
    _foodVauleTF.borderStyle = UITextBorderStyleRoundedRect;
    _foodMakeTF.borderStyle = UITextBorderStyleRoundedRect;
    _foodUnitTF.borderStyle = UITextBorderStyleRoundedRect;
    
    self.photoGroupView.hidden = NO;
    
    [self showBarButtonWithType:BarButton_Complete];
}

-(void)editMenuClick{
    NSLog(@"editMenuClick");
    
    _editModal = MenuModal_Edit;
    [self editMenu];
}

-(void)delMenuClick{
    NSLog(@"delMenuClick");
    
    NSNumber * numberID = [_dicMenuDetailData valueForKey:@"id"];
    NSInteger menuID = numberID.integerValue;
    if (menuID < 0) {
        NSLog(@"error menu ID");
    }
    else{
        [[HttpProtocolAPI sharedClient]deleteMenu:menuID setBlock:^(NSDictionary *data, NSError *error) {
            if (data != nil && [self getRetDataState:data]) {
                NSLog(@"deltet menu sucess!");
            }
        }];
    }
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


-(void)upLoadNewMenu{
    
    NSString * foodName = self.foodNameTF.text;
    NSString * foodVaule = self.foodVauleTF.text;
    NSString * foodMake = self.foodMakeTF.text;
    NSString * foodDeclares = self.foodDeclaresTF.text;
    
    CGFloat fFoodPrice = [foodVaule floatValue];
    
    NSMutableDictionary * paramDic = [[NSMutableDictionary alloc]initWithCapacity:5];
    
    
    NSNumber * userID = [[NSNumber alloc]initWithInt:(int)[UserDataInterface sharedClient].userID_Int];
    [paramDic setObject: [NSNumber numberWithInt:1] forKey:@"store_id"];
    [paramDic setObject: userID forKey:@"creator_id"];
    [paramDic setObject: [NSNumber numberWithInt:1] forKey:@"is_user"];
    [paramDic setObject: foodName forKey:@"name"];
    [paramDic setObject: [NSNumber numberWithFloat:fFoodPrice] forKey:@"price"];
    [paramDic setObject: [NSNumber numberWithInt:0] forKey:@"unit_id"];
    [paramDic setObject: [NSNumber numberWithInt:0] forKey:@"cooking_method_id"];
    [paramDic setObject: [NSNumber numberWithFloat:fFoodPrice] forKey:@"market_price"];
    [paramDic setObject: [NSNumber numberWithInt:1] forKey:@"is_market_price"];
    [paramDic setObject: foodDeclares forKey:@"declares"];
    [paramDic setObject: [NSNumber numberWithInt:0] forKey:@"is_other"];
    
    [[HttpProtocolAPI sharedClient]addNewMenu:paramDic setBlock:^(NSDictionary *data, NSError *error) {
        
        if (data != nil && [self getRetDataState:data]) {
            
            //创建新菜单成功，判断是否有图片并上传图片
            NSDictionary * dic = [data valueForKey:@"data"];
            NSNumber * numberState = [dic valueForKey:@"id"];
            NSInteger state = numberState.integerValue;
            if (state > 0) {
                [self upLoadMenuPic:state];
            }
        }
        
        
    }];
}



-(void)upLoadMenuPic:(NSInteger)menuID{
    
    NSMutableArray * imageArrar = [[NSMutableArray alloc]initWithCapacity:6];
    
    for (int nIndex = 0; nIndex < self.imageArray.count; nIndex++) {
        NSMutableDictionary * item = self.imageArray[nIndex];
        NSString * key = [NSString stringWithFormat:@"%ld", (long)nIndex];
        structPhotoInfo * info = [item objectForKey:key];
        if (info.image != nil) {
            [imageArrar addObject:info.image];
        }
    }
    
    if (imageArrar.count > 0) {
        [[HttpProtocolAPI sharedClient]addNewMenuPic:menuID images:imageArrar setBlock:^(NSDictionary *data, NSError *error) {
            if (data != nil && [self getRetDataState:data]) {
                
                //图片上传完成
                
            }
        }];
    }
}

-(void)updataMenu{
    
    NSString * foodName = self.foodNameTF.text;
    NSString * foodVaule = self.foodVauleTF.text;
    NSString * foodMake = self.foodMakeTF.text;
    NSString * foodDeclares = self.foodDeclaresTF.text;
    
    CGFloat fFoodPrice = [foodVaule floatValue];
    
    NSMutableDictionary * paramDic = [[NSMutableDictionary alloc]initWithCapacity:5];
    
    
    //NSNumber * userID = [[NSNumber alloc]initWithInt:(int)[UserDataInterface sharedClient].userID_Int];
     NSNumber * numberID = [_dicMenuDetailData valueForKey:@"id"];
    
    [paramDic setObject: numberID forKey:@"dish_id"];
    [paramDic setObject: foodName forKey:@"name"];
    [paramDic setObject: [NSNumber numberWithFloat:fFoodPrice] forKey:@"price"];
    [paramDic setObject: [NSNumber numberWithInt:0] forKey:@"unit_id"];
    [paramDic setObject: [NSNumber numberWithInt:0] forKey:@"cooking_method_id"];
    [paramDic setObject: [NSNumber numberWithFloat:fFoodPrice] forKey:@"market_price"];
    [paramDic setObject: [NSNumber numberWithInt:1] forKey:@"is_market_price"];
    [paramDic setObject: foodDeclares forKey:@"declares"];
    [paramDic setObject: [NSNumber numberWithInt:0] forKey:@"is_other"];
    
    [[HttpProtocolAPI sharedClient]updateMenu:paramDic setBlock:^(NSDictionary *data, NSError *error) {
        
        if (data != nil && [self getRetDataState:data]) {
            
            //创建新菜单成功，判断是否有图片并上传图片
            NSDictionary * dic = [data valueForKey:@"data"];
            NSNumber * numberState = [dic valueForKey:@"id"];
            NSInteger state = numberState.integerValue;
            if (state > 0) {
                [self upLoadMenuPic:state];
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
