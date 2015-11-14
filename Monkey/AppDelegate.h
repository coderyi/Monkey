//
//  AppDelegate.h
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YiNetworkEngine.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) YiNetworkEngine *apiEngine;//a api engine

@end
