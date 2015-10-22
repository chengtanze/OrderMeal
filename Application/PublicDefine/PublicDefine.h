//
//  PublicDefine.h
//  OrderMeal
//
//  Created by cheng on 15/10/17.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#ifndef OrderMeal_PublicDefine_h
#define OrderMeal_PublicDefine_h


#define UIKIT_STATUSBARFRAME_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define UIKIT_NAVIGATIONBAR_HEIGHT (self.navigationController != nil ? self.navigationController.navigationBar.frame.size.height : 44)

#define UIKIT_NAVIANDSTATUS_HEIGHT (UIKIT_STATUSBARFRAME_HEIGHT + UIKIT_NAVIGATIONBAR_HEIGHT)

#define UIKIT_TABBAR_HEIGHT (49.0)

#define UIKIT_UISCREEN_BOUNDS  ([UIScreen mainScreen].bounds)

#endif
