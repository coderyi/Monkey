//
//  UserReceivedEventActorModel.h
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserReceivedEventActorModel : NSObject
@property(nonatomic,copy) NSString *actorID;
@property(nonatomic,copy) NSString *login;
@property(nonatomic,copy) NSString *gravatar_id;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *avatar_url;
+ (UserReceivedEventActorModel *)modelWithDict:(NSDictionary *)dict;
@end
