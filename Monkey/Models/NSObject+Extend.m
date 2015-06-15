//
//  NSObject+Extend.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "NSObject+Extend.h"
UIAlertView *alertView;
@implementation NSObject (Extend)
//判断对象是否为空
-(BOOL)isNull
{
    if ([self isEqual:[NSNull null]])
    {
        return YES;
    }
    else
    {
        if ([self isKindOfClass:[NSNull class]])
        {
            return YES;
        }
        else
        {
            if (self==nil)
            {
                return YES;
            }
        }
    }
    if ([self isKindOfClass:[NSString class]]) {
        if ([((NSString *)self) isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    return NO;
}
- (void)showYiProgressHUD:(NSString *)title  afterDelay:(NSTimeInterval)delay{
    [self showYiProgressHUD:title];
    
    [NSTimer scheduledTimerWithTimeInterval:delay
                                     target:self
                                   selector:@selector(hideYiProgressHUD:)
                                   userInfo:nil
                                    repeats:NO];
    
    
}
- (void)showYiProgressHUD:(NSString *)title{
    alertView = [[UIAlertView alloc] initWithTitle:@""
                                           message:title
                                          delegate:nil
                                 cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    
    
    [alertView show];
}
- (void)hideYiProgressHUD{
    [self hideYiProgressHUD:nil];
    
}
- (void)hideYiProgressHUD:(NSTimer*)timer {
    NSLog(@"Dismiss alert view");
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}
@end
