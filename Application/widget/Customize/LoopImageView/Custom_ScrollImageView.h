//
//  Custom_ScrollImageView.h
//  tmpScrollView
//
//  Created by wangsl-iMac on 15/1/29.
//  Copyright (c) 2015年 chengtz-iMac. All rights reserved.
//  图片浏览




#import <UIKit/UIKit.h>

@protocol CustromScrollImageViewTapDelegate <NSObject>

-(void)ScrollImageViewdidSelectRowAtIndexPath:(NSInteger)index;

@end



@interface Custom_ScrollImageView : UIView<UIScrollViewDelegate>

//设置图片路径
@property(nonatomic, strong)NSMutableArray * picPathArray;
@property(nonatomic, strong)id<CustromScrollImageViewTapDelegate> delegate;
@property(nonatomic, assign)NSInteger picType;

-(id)initWithFrame:(CGRect)frame;
-(id)initWithFrame:(CGRect)frame picArray:(NSArray *)array;
-(id)initWithFrame:(CGRect)frame picArray:(NSArray *)array type:(NSUInteger)picType; //(0:本地 1:网络)
-(void)upDataScrollViewPoint;

@end
