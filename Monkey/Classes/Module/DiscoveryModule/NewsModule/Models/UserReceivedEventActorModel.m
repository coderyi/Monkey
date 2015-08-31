//
//  UserReceivedEventActorModel.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserReceivedEventActorModel.h"

@implementation UserReceivedEventActorModel
+ (UserReceivedEventActorModel *)modelWithDict:(NSDictionary *)dict
{
    if (!dict) {
        return Nil;
    }
    
    UserReceivedEventActorModel *model = [[UserReceivedEventActorModel alloc]init];
    
    model.actorID = [dict objectForKey:@"id"] ;
    model.login = [dict objectForKey:@"login"] ;
    model.gravatar_id = [dict objectForKey:@"gravatar_id"] ;
    model.url = [dict objectForKey:@"url"] ;
    model.avatar_url = [dict objectForKey:@"avatar_url"] ;

    return model;
}
@end
