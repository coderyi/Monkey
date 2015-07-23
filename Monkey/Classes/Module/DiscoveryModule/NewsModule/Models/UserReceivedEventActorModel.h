//
//  UserReceivedEventActorModel.h
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserReceivedEventActorModel : NSObject
@property(nonatomic,strong)NSString *actorID;
@property(nonatomic,strong)NSString *login;
@property(nonatomic,strong)NSString *gravatar_id;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *avatar_url;
+ (UserReceivedEventActorModel *)modelWithDict:(NSDictionary *)dict;
@end
