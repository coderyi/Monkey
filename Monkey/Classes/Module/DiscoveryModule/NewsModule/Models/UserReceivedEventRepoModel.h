//
//  UserReceivedEventRepoModel.h
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserReceivedEventRepoModel : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *userReceivedEventRepoID;
@property(nonatomic,copy) NSString *url;
+ (UserReceivedEventRepoModel *)modelWithDict:(NSDictionary *)dict;
@end
