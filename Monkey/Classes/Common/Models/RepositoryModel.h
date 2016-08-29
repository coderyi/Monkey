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
@property(nonatomic,assign) int userId;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *full_name;
//@property BOOL isPrivate;
@property(nonatomic,copy) NSString *html_url;
@property(nonatomic,copy) NSString *repositoryDescription;
@property(nonatomic,assign) BOOL isFork;
//@property(nonatomic,strong)NSString *url;
//@property(nonatomic,strong)NSString *forks_url;
//@property(nonatomic,strong)NSString *keys_url;
//@property(nonatomic,strong)NSString *collaborators_url;
@property(nonatomic,copy) NSString *created_at;
//@property(nonatomic,strong)NSString *updated_at;
//@property(nonatomic,strong)NSString *pushed_at;
@property(nonatomic,copy) NSString *homepage;
//@property int size;
@property(nonatomic,assign) int stargazers_count;
//@property int watchers_count;
@property(nonatomic,copy) NSString *language;
@property(nonatomic,assign) int forks_count;
//@property int open_issues_count;
//@property int forks;
//@property int open_issues;
//@property int watchers;
@property(nonatomic,strong) UserModel *user;
@property(nonatomic,copy) NSString *mirror_url;

//detail
@property(nonatomic,copy) NSString *parentOwnerName;

+ (RepositoryModel *)modelWithDict:(NSDictionary *)dict;
@end
