//
//  LanguageViewController.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LanguageEntranceType) {
    UserLanguageEntranceType = 0,
    RepLanguageEntranceType,
    TrendingLanguageEntranceType,
};

@interface LanguageViewController : UIViewController
@property(nonatomic,assign) LanguageEntranceType languageEntranceType;
@end
