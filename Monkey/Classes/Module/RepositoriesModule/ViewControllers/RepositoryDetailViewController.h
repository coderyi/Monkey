//
//  RepositoryDetailViewController.h
//  GitHubYi
//
//  Created by coderyi on 15/4/3.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositoryModel.h"

@import SafariServices;

@interface RepositoryDetailViewController : UIViewController
@property(nonatomic,strong) RepositoryModel *model;
@end
