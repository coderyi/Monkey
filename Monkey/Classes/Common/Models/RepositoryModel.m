//
//  RepositoryModel.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "RepositoryModel.h"
#import "UserModel.h"
@implementation RepositoryModel

+ (RepositoryModel *)modelWithDict:(NSDictionary *)dict
{
    if (!dict) {
        return Nil;
    }
    
    RepositoryModel *model = [[RepositoryModel alloc]init];
    
    model.userId = [[dict objectForKey:@"id"] intValue] ;
    model.name = [dict objectForKey:@"name"] ;
    model.full_name = [dict objectForKey:@"full_name"] ;
//    model.isPrivate = [[dict objectForKey:@"isPrivate"] boolValue] ;

    model.html_url = [[dict objectForKey:@"html_url"] isNull]?@"":[dict objectForKey:@"html_url"] ;
    model.repositoryDescription = [dict objectForKey:@"description"] ;
  
    model.isFork = [[dict objectForKey:@"fork"] boolValue] ;
//    model.url = [dict objectForKey:@"url"] ;
//    model.forks_url = [dict objectForKey:@"forks_url"] ;
//    model.keys_url = [dict objectForKey:@"keys_url"] ;
//    model.collaborators_url = [dict objectForKey:@"collaborators_url"] ;
    model.created_at = [dict objectForKey:@"created_at"] ;
//    model.updated_at = [dict objectForKey:@"updated_at"] ;
//    model.pushed_at = [dict objectForKey:@"pushed_at"] ;
    model.homepage =[[dict objectForKey:@"homepage"] isNull]?@"":[dict objectForKey:@"homepage"] ;
//    model.size = [[dict objectForKey:@"size"] intValue];
    model.stargazers_count = [[dict objectForKey:@"stargazers_count"] intValue] ;
//    model.watchers_count = [[dict objectForKey:@"watchers_count"] intValue] ;
     model.language =[[dict objectForKey:@"language"] isNull]?@"":[dict objectForKey:@"language"] ;
    model.forks_count = [[dict objectForKey:@"forks_count"] intValue] ;
//    model.open_issues_count = [[dict objectForKey:@"open_issues_count"] intValue] ;
//    model.forks = [[dict objectForKey:@"forks"] intValue] ;
//    model.open_issues = [[dict objectForKey:@"open_issues"] intValue] ;
//    model.watchers = [[dict objectForKey:@"watchers"] intValue] ;

    
    NSDictionary *owner=[dict objectForKey:@"owner"];
    
    model.user=[UserModel modelWithDict:owner];
    
    NSDictionary *parent=[dict objectForKey:@"parent"];
    NSDictionary *parentOwner=[parent objectForKey:@"owner"];
    model.parentOwnerName=[parentOwner objectForKey:@"login"];
    
    return model;
}


@end
