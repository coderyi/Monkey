//
//  UserDetailViewController.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@import SafariServices;

@interface UserDetailViewController : UIViewController
@property(nonatomic,strong) UserModel *userModel;
@end
