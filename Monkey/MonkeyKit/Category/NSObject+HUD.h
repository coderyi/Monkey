//
//  NSObject+Extend.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HUD)

/**
 *  show progress HUD ,and afer delay time,it will be hided
 *
 *  @param title progress HUD title
 *  @param delay delay seconds
 */
- (void)showYiProgressHUD:(NSString *)title  afterDelay:(NSTimeInterval)delay;

/**
 *  show progress HUD
 *
 *  @param title title progress HUD title
 */
- (void)showYiProgressHUD:(NSString *)title;

/**
 *  hide progress HUD
 */
- (void)hideYiProgressHUD;

@end
