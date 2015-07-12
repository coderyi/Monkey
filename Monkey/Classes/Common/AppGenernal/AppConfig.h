//
//  AppConfig.h
//  Monkey
//
//  Created by coderyi on 15/7/11.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#ifndef Monkey_AppConfig_h
#define Monkey_AppConfig_h

/**
 *   define
 */

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define iOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//我喜欢的蓝色
#define YiBlue [UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f]
//灰色
#define YiGray [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f]
#define YiTextGray [UIColor colorWithRed:0.54f green:0.54f blue:0.54f alpha:1.00f]

//UM的宏
#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

/**
 *  我的GitHub的信息,这个是不能被您使用的，否则侵权
 */
#define CoderyiClientID @"a8d9c1a366f057a23753"
#define CoderyiClientSecret @"f1e47cd31800a90e517b37731038ae07dca580d2"
#endif
