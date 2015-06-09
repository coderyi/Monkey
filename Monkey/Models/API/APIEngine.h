//
//  APIEngine.h
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "UserModel.h"
#import "RepositoryModel.h"
/**
 *   block
 */

typedef void (^MKNKErrorBlock)(NSError* error);

typedef void (^PageListInfoResponseBlock)(NSArray* modelArray,NSInteger page,NSInteger totalCount);
typedef void (^UserModelResponseBlock)(UserModel* model);
typedef void (^RepositoryModelResponseBlock)(RepositoryModel* model);

@interface APIEngine : MKNetworkEngine

- (MKNetworkOperation *)searchUsersWithPage:(NSInteger)page  q:(NSString *)q sort:(NSString *)sort categoryLocation:(NSString *)categoryLocation categoryLanguage:(NSString *)categoryLanguage completoinHandler:(PageListInfoResponseBlock)completionBlock
                                errorHandel:(MKNKErrorBlock)errorBlock;
- (MKNetworkOperation *)searchUsersWithPage:(NSInteger)page  q:(NSString *)q sort:(NSString *)sort completoinHandler:(PageListInfoResponseBlock)completionBlock
                                errorHandel:(MKNKErrorBlock)errorBlock;

- (MKNetworkOperation *)searchRepositoriesWithPage:(NSInteger)page  q:(NSString *)q sort:(NSString *)sort completoinHandler:(PageListInfoResponseBlock)completionBlock
                                       errorHandel:(MKNKErrorBlock)errorBlock;
- (MKNetworkOperation *)userDetailWithUserName:(NSString *)userName
                             completoinHandler:
(UserModelResponseBlock)completionBlock
                                   errorHandel:(MKNKErrorBlock)errorBlock;
- (MKNetworkOperation *)userRepositoriesWithPage:(NSInteger)page  userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                     errorHandel:(MKNKErrorBlock)errorBlock;
- (MKNetworkOperation *)userFollowingWithPage:(NSInteger)page  userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                  errorHandel:(MKNKErrorBlock)errorBlock;
- (MKNetworkOperation *)userFollowersWithPage:(NSInteger)page  userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                  errorHandel:(MKNKErrorBlock)errorBlock;
- (MKNetworkOperation *)repositoryDetailWithUserName:(NSString *)userName repositoryName:(NSString *)repositoryName
                                   completoinHandler:
(RepositoryModelResponseBlock)completionBlock
                                         errorHandel:(MKNKErrorBlock)errorBlock;

- (MKNetworkOperation *)reposDetailCategoryWithPage:(NSInteger)page  userName:(NSString *)userName repositoryName:(NSString *)repositoryName category:(NSString *)category completoinHandler:(PageListInfoResponseBlock)completionBlock
                                        errorHandel:(MKNKErrorBlock)errorBlock;

@end
