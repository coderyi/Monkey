//
//  UserReceivedEventPayloadModel.h
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepositoryModel.h"
@interface UserReceivedEventPayloadModel : NSObject
//started
@property(nonatomic,strong)NSString *action;

//create
@property(nonatomic,strong)NSString *ref;
@property(nonatomic,strong)NSString *ref_type;
@property(nonatomic,strong)NSString *master_branch;
@property(nonatomic,strong)NSString *payloadDescription;
@property(nonatomic,strong)NSString *pusher_type;

//fork
@property(nonatomic,strong)RepositoryModel *forkee;
+ (UserReceivedEventPayloadModel *)modelWithDict:(NSDictionary *)dict;
@end
