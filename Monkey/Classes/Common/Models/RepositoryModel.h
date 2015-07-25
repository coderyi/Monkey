//
//  RepositoryModel.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface RepositoryModel : NSObject
@property int userId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *full_name;
//@property BOOL isPrivate;
@property(nonatomic,strong)NSString *html_url;
@property(nonatomic,strong)NSString *repositoryDescription;
@property(nonatomic,assign)BOOL isFork;
//@property(nonatomic,strong)NSString *url;

//@property(nonatomic,strong)NSString *forks_url;
//@property(nonatomic,strong)NSString *keys_url;
//@property(nonatomic,strong)NSString *collaborators_url;
@property(nonatomic,strong)NSString *created_at;
//@property(nonatomic,strong)NSString *updated_at;
//@property(nonatomic,strong)NSString *pushed_at;
@property(nonatomic,strong)NSString *homepage;
//@property int size;
@property(nonatomic,assign) int stargazers_count;
//@property int watchers_count;
@property(nonatomic,strong)NSString *language;
@property(nonatomic,assign) int forks_count;
//@property int open_issues_count;
//@property int forks;
//@property int open_issues;
//@property int watchers;
@property(nonatomic,strong) UserModel *user;

//detail
@property(nonatomic,strong) NSString *parentOwnerName;

+ (RepositoryModel *)modelWithDict:(NSDictionary *)dict;
@end
