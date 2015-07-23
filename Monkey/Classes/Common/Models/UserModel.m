//
//  UserModel.m
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


+ (UserModel *)modelWithDict:(NSDictionary *)dict
{
    if (!dict) {
        return Nil;
    }
    
    UserModel *model = [[UserModel alloc]init];
    
    model.login = [dict objectForKey:@"login"] ;
    model.userId = [[dict objectForKey:@"id"] intValue] ;
    model.avatar_url = [dict objectForKey:@"avatar_url"] ;
    model.gravatar_id = [dict objectForKey:@"gravatar_id"] ;
    model.url = [dict objectForKey:@"url"] ;
    model.html_url = [dict objectForKey:@"html_url"] ;
    model.followers_url = [dict objectForKey:@"followers_url"] ;
    model.following_url = [dict objectForKey:@"following_url"] ;
    model.gists_url = [dict objectForKey:@"gists_url"] ;
    model.starred_url = [dict objectForKey:@"starred_url"] ;
    model.subscriptions_url = [dict objectForKey:@"subscriptions_url"] ;
    model.organizations_url = [dict objectForKey:@"organizations_url"] ;
    model.repos_url = [dict objectForKey:@"repos_url"] ;
    model.events_url = [dict objectForKey:@"events_url"] ;
    model.received_events_url = [dict objectForKey:@"received_events_url"] ;
    model.type = [dict objectForKey:@"type"] ;
    model.site_admin = [[dict objectForKey:@"site_admin"] boolValue] ;
    model.score = [dict objectForKey:@"score"] ;

    model.name = [[dict objectForKey:@"name"] isNull]?@"":[dict objectForKey:@"name"] ;
    model.company = [[dict objectForKey:@"company"] isNull]?@"":[dict objectForKey:@"company"];
    model.blog = [[dict objectForKey:@"blog"] isNull]?@"":[dict objectForKey:@"blog"];
    model.location = [dict objectForKey:@"location"] ;
    model.email = [[dict objectForKey:@"email"] isNull]?@"":[dict objectForKey:@"email"];
    model.public_repos = [[dict objectForKey:@"public_repos"] intValue];
    model.followers = [[dict objectForKey:@"followers"] intValue];
    model.following = [[dict objectForKey:@"following"] intValue];

    model.created_at = [dict objectForKey:@"created_at"] ;

    
    return model;
}

@end
