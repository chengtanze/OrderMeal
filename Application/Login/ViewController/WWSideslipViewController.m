//
//  WWSideslipViewController.m
//  WWSideslipViewControllerSample
//
//  Created by 王维 on 14-8-26.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "WWSideslipViewController.h"

static WWSideslipViewController *sharedObj = nil;

@interface WWSideslipViewController ()

@end

@implementation WWSideslipViewController
@synthesize speedf,sideslipTapGes;
//@synthesize righControl = _righControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.view addSubview:mainControl.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(instancetype)sharedInstance:(UIViewController *)LeftView
                  andMainView:(UIViewController *)MainView
                 andRightView:(UIViewController *)RighView
           andBackgroundImage:(UIImage *)image;
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] initWithLeftView:LeftView andMainView:MainView andRightView:RighView andBackgroundImage:image];
        }
    }
    return sharedObj;
}

-(instancetype)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
                   andRightView:(UIViewController *)RighView
                        andBackgroundImage:(UIImage *)image;
{
    if(self){
        speedf = 0.5;
        
        leftControl = LeftView;
        mainControl = MainView;
        righControl = RighView;
        
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [imgview setImage:image];
        [self.view addSubview:imgview];
        
        //滑动手势
        self.sidesPanGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];

        //[mainControl.view addGestureRecognizer:pan];
        
        
        //单击手势
        sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [sideslipTapGes setNumberOfTapsRequired:1];
        
       // [mainControl.view addGestureRecognizer:sideslipTapGes];
        
        leftControl.view.hidden = YES;
        righControl.view.hidden = YES;
        
        CGRect rect = righControl.view.frame;
        rect.origin.x = mainControl.view.frame.size.width;
        righControl.view.frame = rect;
        
        [self.view addSubview:leftControl.view];
        [self.view addSubview:righControl.view];
        
        [self.view addSubview:mainControl.view];
        

        
    }
    return self;
}

-(void)addPanGsetureToHomeView{
    if (_sidesPanGes != nil) {
        [mainControl.view addGestureRecognizer:_sidesPanGes];
    }
    
}

-(void)removeGestureToHomeView{
    if (_sidesPanGes != nil) {
        [mainControl.view removeGestureRecognizer:_sidesPanGes];
    }
    
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"touchesCancelled");
}

#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    CGPoint point = [rec translationInView:self.view];

    scalef = (point.x * speedf+ scalef);
    
    //根据视图位置判断是左滑还是右边滑动
    if (rec.view.frame.origin.x>=0){
        rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1-scalef/1000,1-scalef/1000);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        righControl.view.hidden = YES;
        leftControl.view.hidden = NO;

    }
    else
    {
        rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1+scalef/1000,1+scalef/1000);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
    
        
        righControl.view.hidden = NO;
        leftControl.view.hidden = YES;
        
        CGRect rect = righControl.view.frame;
        rect.origin.x = rec.view.frame.origin.x + rec.view.frame.size.width;
        righControl.view.frame = rect;
    }

    //手势结束后修正位置
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (scalef>250*speedf){
            [self showLeftView];
        }
        else if (scalef<-140*speedf) {
            [mainControl.view addGestureRecognizer:sideslipTapGes];
            
            [self showRighView];
            
            [UIView beginAnimations:nil context:nil];
            CGRect rect = righControl.view.frame;
            rect.origin.x = rec.view.frame.origin.x + rec.view.frame.size.width;
            righControl.view.frame = rect;
            [UIView commitAnimations];
        }
        else
        {
            [self showMainView];
            
            scalef = 0;
            
            [UIView beginAnimations:nil context:nil];
            CGRect rect = righControl.view.frame;
            rect.origin.x = rec.view.frame.origin.x + rec.view.frame.size.width;
            righControl.view.frame = rect;
            [UIView commitAnimations];
        }
    }

}

-(void)restoreViewState{
    //[UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    //[UIView commitAnimations];
    scalef = 0;
    
    //[UIView beginAnimations:nil context:nil];
    CGRect rect = righControl.view.frame;
    rect.origin.x = mainControl.view.frame.origin.x + mainControl.view.frame.size.width;
    righControl.view.frame = rect;
    //[UIView commitAnimations];
    
    [mainControl.view removeGestureRecognizer:sideslipTapGes];
}

#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        [UIView commitAnimations];
        scalef = 0;
        
        [UIView beginAnimations:nil context:nil];
        CGRect rect = righControl.view.frame;
        rect.origin.x = tap.view.frame.origin.x + tap.view.frame.size.width;
        righControl.view.frame = rect;
        [UIView commitAnimations];
    }
    
    [mainControl.view removeGestureRecognizer:sideslipTapGes];
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    //mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView{
    [UIView beginAnimations:nil context:nil];
    //mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainControl.view.center = CGPointMake(340,[UIScreen mainScreen].bounds.size.height/2);
    
    
    leftControl.view.hidden = NO;
    [UIView commitAnimations];

}

//显示右视图
-(void)showRighView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
    mainControl.view.center = CGPointMake(-[UIScreen mainScreen].bounds.size.width / 4.0, [UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

#warning 为了界面美观，所以隐藏了状态栏。如果需要显示则去掉此代码
//- (BOOL)prefersStatusBarHidden
//{
//    return YES; //返回NO表示要显示，返回YES将hiden
//}

@end
