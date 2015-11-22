//
//  LoginViewController.m
//  Post
//
//  Created by cheng on 15/2/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "LoginViewController.h"
#import "HttpProtocolAPI.h"
#import "PublicFunction.h"
#import "UserDataInterface.h"
#import "SVProgressHUD.h"
#import "RootTabBarViewController.h"
#import "RegisterViewController.h"
#import "WWSideslipViewController.h"



@interface LoginViewController ()<UIAlertViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showLoginInfo];
    
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

//#define USERTEST

- (IBAction)loginClick:(id)sender {

    
#ifdef USERTEST
    _userName = self.phoneNumber.text;
    _userPW = self.userPassWord.text;
#else
    _userName = @"13691790130";//@"18576430783";//
    _userPW = @"123456";
#endif
   // [[UserDataInterface sharedClient] saveLoginInfo:_userName passWord:_userPW];
    [self login:_userName passWord:_userPW loginType:0];
}

- (IBAction)registerClick:(id)sender {
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self presentViewController:info animated:NO completion:^{
        
    }];
}

-(void)login:(NSString *)strUserName passWord:(NSString *)strUserPassWord loginType:(NSInteger)type{
    
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: strUserName forKey:@"phone_num"];
    
    NSString * md5_PassWord = [PublicFunction md5:strUserPassWord];
    [params setObject: md5_PassWord forKey:@"password"];
    
    [[HttpProtocolAPI sharedClient] login:params setBlock:^void(NSDictionary *data, NSError *error) {
        
        //登陆请求返回处理
        [self responseNetWorkData:data errorCode:error loginType:type];
    }];
}

-(void)responseNetWorkData:(NSDictionary *)data errorCode:(NSError *)error loginType:(NSInteger)type{
    if (data != nil) {
        
        //解析数据
        NSNumber * state = [data valueForKey:@"state"];
        if (state.intValue == 0) {
            //登陆成功
            NSDictionary * dataArray = [data valueForKey:@"data"];
            
            if (dataArray != nil) {
//                NSString *id = [dataArray valueForKey:@"id"];
//                NSString *nickName = [dataArray valueForKey:@"nickName"];
//                NSString *phoneNum = [dataArray valueForKey:@"phoneNum"];
//                NSString *honestRank = [dataArray valueForKey:@"honestRank"];   //诚信指数
//                NSString *avator = [dataArray valueForKey:@"avatar"];           //头像链接
//                NSString *rank = [dataArray valueForKey:@"rank"];               //用户等级，0普通用户，1快递人，默认为0
//                NSString *sid = [dataArray valueForKey:@"sid"];                 //sessionId
//                NSString *key = [dataArray valueForKey:@"key"];
                
                //NSLog(@"pw:%@", _userPW);
                [UserDataInterface sharedClient].bLogin = YES;
                [UserDataInterface sharedClient].dicUserInfo = dataArray;
                if (type == 0) {

                    [self succeedLoginDoThing];
                }
                
                [self showStoreView];
                //[SVProgressHUD showSuccessWithStatus:@"登陆成功"];

            }
        }
        else if(state.intValue == 1){
            //登陆失败
            [SVProgressHUD showSuccessWithStatus:@"密码错误"];
        }
        
    }else{
        //网络错误
        [SVProgressHUD showSuccessWithStatus:@"登陆失败"];
        
    }
}


-(BOOL)showLoginInfo{
    
    NSArray * userInfo = [[UserDataInterface sharedClient] loadLoginInfo];
    BOOL bShow = NO;
    if (userInfo != nil && ![userInfo isKindOfClass:[NSNull class]] && userInfo.count > 0) {
        NSString * userName = userInfo[0];
        NSString * userPW = userInfo[1];
        
        if (![userName isEqualToString:@""] && ![userPW isEqualToString:@""]) {
            
            _userName = userName;
            _userPW = userPW;
            [self login:userName passWord:userPW loginType:0];
            bShow = NO;
        }
        else{
            bShow = YES;
        }
       
    }
    return bShow;
}

-(UIViewController *)setRootViewControllerToLogin{
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController * loginViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    return loginViewController;
}


-(void)succeedLoginDoThing{
    
    [[UserDataInterface sharedClient] saveLoginInfo:_userName passWord:_userPW];
    
//    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    RootTabBarViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"RootTabBarViewController"];
//    [self presentViewController:info animated:NO completion:^{
//        
//    }];
    
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * MainViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"RootTabBarViewController"];
    
    UIViewController * rightViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PersonalDataController"];
    
    WWSideslipViewController * slide = [WWSideslipViewController sharedInstance:rightViewController andMainView:MainViewController andRightView:nil andBackgroundImage:[UIImage imageNamed:@"bg.png"]];
    
    //滑动速度系数
    //[slide setSpeedf:0.8];
    
    //点击视图是是否恢复位置
    slide.sideslipTapGes.enabled = YES;
    
    [self presentViewController:slide animated:NO completion:^{
        
    }];
    
    
    
}

-(void)showStoreView{
    if ([UserDataInterface sharedClient].storeID_Int > 0) {
        
    }
    else{
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"提示" message:@"该账号尚未认证，认证通过可使用全部功能。" delegate:self cancelButtonTitle:@"去认证" otherButtonTitles:@"取消", nil];
        
        [alert show];
    }
    
    

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    switch (buttonIndex) {
        case 0: //YES应该做的事
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showApplyController" object:nil];
        }
        break;
            
        case 1://NO应该做的事
        {
            
        }
        break;
    }
}



@end
