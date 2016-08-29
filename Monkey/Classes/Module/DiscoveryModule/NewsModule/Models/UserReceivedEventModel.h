//
//  UserReceivedEventModel.h
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserReceivedEventActorModel.h"
#import "UserReceivedEventPayloadModel.h"
#import "UserReceivedEventRepoModel.h"
@interface UserReceivedEventModel : NSObject
@property(nonatomic,copy) NSString *userReceivedEventID;
@property(nonatomic,copy) NSString *type;//WatchEvent(started) CreateEvent ForkEvent
@property(nonatomic,strong) UserReceivedEventActorModel *actor;
@property(nonatomic,strong) UserReceivedEventRepoModel *repo;
@property(nonatomic,strong) UserReceivedEventPayloadModel *payload;
@property(nonatomic,copy) NSString *userReceivedEventPublic;
@property(nonatomic,copy) NSString *created_at;
+ (UserReceivedEventModel *)modelWithDict:(NSDictionary *)dict;
@end
