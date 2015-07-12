//
//  WebViewController.h
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginWebViewController : UIViewController
@property(nonatomic,strong) NSString *urlString;
@property(nonatomic,copy) void (^callback) (NSString* code);
@end
