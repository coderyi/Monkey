//
//  UserReceivedEventModel.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserReceivedEventModel.h"

@implementation UserReceivedEventModel

+ (UserReceivedEventModel *)modelWithDict:(NSDictionary *)dict
{
    if (!dict) {
        return Nil;
    }
    
    UserReceivedEventModel *model = [[UserReceivedEventModel alloc]init];
    
    model.userReceivedEventID = [dict objectForKey:@"id"] ;
    model.type = [dict objectForKey:@"type"] ;
   
    NSDictionary *actor=[dict objectForKey:@"actor"];
    model.actor=[UserReceivedEventActorModel modelWithDict:actor];
    
    NSDictionary *repo=[dict objectForKey:@"repo"];
    model.repo=[UserReceivedEventRepoModel modelWithDict:repo];
    
    NSDictionary *payload=[dict objectForKey:@"payload"];
    model.payload=[UserReceivedEventPayloadModel modelWithDict:payload];
    model.userReceivedEventPublic = [dict objectForKey:@"public"] ;
    model.created_at = [dict objectForKey:@"created_at"] ;
   
    return model;
}

@end
