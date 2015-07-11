//
//  NSObject+Extend.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HUD)

- (void)showYiProgressHUD:(NSString *)title  afterDelay:(NSTimeInterval)delay;
- (void)showYiProgressHUD:(NSString *)title;
- (void)hideYiProgressHUD;

@end
