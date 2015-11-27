//
//  BaseNavigationController.m
//  Monkey
//
//  Created by Jack_iMac on 15/6/30.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.statusBarStyle = UIStatusBarStyleLightContent;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

@end
