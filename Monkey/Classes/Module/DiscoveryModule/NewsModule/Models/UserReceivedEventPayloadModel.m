
//
//  UserReceivedEventPayloadModel.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserReceivedEventPayloadModel.h"

@implementation UserReceivedEventPayloadModel
+ (UserReceivedEventPayloadModel *)modelWithDict:(NSDictionary *)dict
{
    if (!dict) {
        return Nil;
    }
    
    UserReceivedEventPayloadModel *model = [[UserReceivedEventPayloadModel alloc]init];
    
    model.action = [dict objectForKey:@"action"] ;
    model.ref = [dict objectForKey:@"ref"] ;
    model.ref_type = [dict objectForKey:@"ref_type"] ;
    model.master_branch = [dict objectForKey:@"master_branch"] ;
    model.payloadDescription = [dict objectForKey:@"description"] ;
    model.pusher_type = [dict objectForKey:@"pusher_type"] ;

    NSDictionary *forkee=[dict objectForKey:@"forkee"];
    model.forkee=[RepositoryModel modelWithDict:forkee];

    return model;
}

@end
