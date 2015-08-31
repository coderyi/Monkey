//
//  UserReceivedEventRepoModel.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserReceivedEventRepoModel.h"

@implementation UserReceivedEventRepoModel
+ (UserReceivedEventRepoModel *)modelWithDict:(NSDictionary *)dict
{
    if (!dict) {
        return Nil;
    }
    
    UserReceivedEventRepoModel *model = [[UserReceivedEventRepoModel alloc]init];

    model.name = [dict objectForKey:@"name"] ;
    model.userReceivedEventRepoID = [dict objectForKey:@"id"] ;
    model.url = [dict objectForKey:@"url"] ;
    
    return model;
}
@end
