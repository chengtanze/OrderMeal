//
//  MenuView.m
//  OrderMeal
//
//  Created by cheng on 15/10/14.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MenuView.h"

#import "MenuCollectionViewCell.h"

#define ORDERMEAL_ORDER_SPACE 10.0
#define ORDERMEAL_ORDER_HEADIMAGESIZE (30.0)
#define kcellIdentifier @"identifierMenuCell"


@interface MenuView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView * menuCollectionView;
@property(nonatomic, strong) UIImage * image;
@end


@implementation MenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initLocalView];
        
        //self.image = [UIImage imageNamed:@"ic_launcher.png"];
    }
    
    return self;
}

-(void)initLocalView{
    self.menuCollectionView = [self createCollectionView];
    
    [self addSubview:self.menuCollectionView];
}




-(UICollectionView *)createCollectionView{
    //初始化布局类(UICollectionViewLayout的子类)
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //初始化collectionView
    UICollectionView * menuCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    
    menuCollectionView.delegate = self;
    menuCollectionView.dataSource = self;
    
    //[menuCollectionView registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:kcellIdentifier];
    [menuCollectionView registerNib:[UINib nibWithNibName:@"MenuCollectionCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    
    menuCollectionView.backgroundColor = [UIColor whiteColor];
    return menuCollectionView;
}

#pragma mark events


#pragma mark -CollectionView datasource
//section
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={0,0};
    return size;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[MenuCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    }


    cell.menuImageView.image = [UIImage imageNamed:@"shrimp.jpg"];
    cell.foodNameLabel.text = @"油焖大虾";
    cell.foodValueLable.text = @"100元/份";
    
    return cell;

}

//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    static CGSize size;
    size.width = (self.bounds.size.width - ORDERMEAL_ORDER_SPACE * 3) / 2;
    size.height = size.width;
    
    return size;
}

//设置每组的cell的边界, 具体看下图
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    edgeInsets.top = ORDERMEAL_ORDER_SPACE;
    edgeInsets.left = ORDERMEAL_ORDER_SPACE;
    edgeInsets.right = ORDERMEAL_ORDER_SPACE;
    edgeInsets.bottom = ORDERMEAL_ORDER_SPACE;
    return edgeInsets;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"choice cell index:%ld", indexPath.row);
    if (_delegate != nil && [self.delegate respondsToSelector:@selector(selectCellIndex:)])
    {
        [_delegate selectCellIndex:indexPath];
    }

//    MenuCollectionViewCell * cell = (MenuCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    if (nil != cell) {
//        [cell selectMenuCell];
//    }
}


@end
