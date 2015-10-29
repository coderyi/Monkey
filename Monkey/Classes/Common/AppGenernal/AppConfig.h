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
#define iOS7GE [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
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
 *  this is not to be used by you, otherwise infringement
 */
#define CoderyiClientID @"2Abvwo7M117qA6xHhHAg6th+/28YYY4lA7Z23SXxJG8="
#define CoderyiClientSecret @"ZVQguKWUuj7votRcUIhThLhmfbrHytkGByT+OSeXxIPttGpbZd84jh1b/rNdl+ek"

#define RepositoriesTableViewCellheight 95
#define RankTableViewCellHeight 71
#endif

//http://www.jianshu.com/p/3d6c4416db5e
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

