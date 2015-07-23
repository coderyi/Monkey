//
//  UserReceivedEventRepoModel.h
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserReceivedEventRepoModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *userReceivedEventRepoID;
@property(nonatomic,strong)NSString *url;
+ (UserReceivedEventRepoModel *)modelWithDict:(NSDictionary *)dict;
@end
