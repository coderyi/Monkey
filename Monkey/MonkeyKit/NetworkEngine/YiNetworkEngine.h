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
typedef void (^StringResponseBlock)(NSString* response);

@interface YiNetworkEngine : MKNetworkEngine
#pragma mark - followmodule

//Check if one user follows another
//https://developer.github.com/v3/users/followers/#check-if-one-user-follows-another
- (MKNetworkOperation *)checkFollowStatusWithUsername:(NSString *)username
                                          target_user:(NSString *)target_user
                                    completoinHandler:(UserModelResponseBlock)completionBlock
                                          errorHandel:(MKNKErrorBlock)errorBlock;
#pragma mark - login module
- (MKNetworkOperation *)loginWithCode:(NSString *)code
                    completoinHandler:(StringResponseBlock)completionBlock
                          errorHandel:(MKNKErrorBlock)errorBlock;
- (MKNetworkOperation *)getUserInfoWithToken:(NSString *)token
                           completoinHandler:(UserModelResponseBlock)completionBlock
                                 errorHandel:(MKNKErrorBlock)errorBlock;
#pragma mark - users module


//https://developer.github.com/v3/search/#search-users
//Search users
- (MKNetworkOperation *)searchUsersWithPage:(NSInteger)page q:(NSString *)q sort:(NSString *)sort categoryLocation:(NSString *)categoryLocation categoryLanguage:(NSString *)categoryLanguage completoinHandler:(PageListInfoResponseBlock)completionBlock
                                errorHandel:(MKNKErrorBlock)errorBlock;

//https://developer.github.com/v3/search/#search-users
//Search users
- (MKNetworkOperation *)searchUsersWithPage:(NSInteger)page q:(NSString *)q sort:(NSString *)sort completoinHandler:(PageListInfoResponseBlock)completionBlock
                                errorHandel:(MKNKErrorBlock)errorBlock;


//https://developer.github.com/v3/users/#get-a-single-user
//Get a single user ,GET /users/:username
- (MKNetworkOperation *)userDetailWithUserName:(NSString *)userName
                             completoinHandler:
(UserModelResponseBlock)completionBlock
                                   errorHandel:(MKNKErrorBlock)errorBlock;

//https://developer.github.com/v3/repos/#list-user-repositories
//List user repositories
//GET /users/:username/repos
- (MKNetworkOperation *)userRepositoriesWithPage:(NSInteger)page userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                     errorHandel:(MKNKErrorBlock)errorBlock;

//List users followed by another user
//https://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
//GET /users/:username/following
- (MKNetworkOperation *)userFollowingWithPage:(NSInteger)page userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                  errorHandel:(MKNKErrorBlock)errorBlock;
//List followers of a user
//https://developer.github.com/v3/users/followers/#list-followers-of-a-user
//GET /users/:username/followers
- (MKNetworkOperation *)userFollowersWithPage:(NSInteger)page userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                  errorHandel:(MKNKErrorBlock)errorBlock;

#pragma mark - repositories module

//https://developer.github.com/v3/search/#search-repositories
//Search repositories
- (MKNetworkOperation *)searchRepositoriesWithPage:(NSInteger)page q:(NSString *)q sort:(NSString *)sort completoinHandler:(PageListInfoResponseBlock)completionBlock
                                       errorHandel:(MKNKErrorBlock)errorBlock;

//https://developer.github.com/v3/repos/#get
//Get
//GET /repos/:owner/:repo
- (MKNetworkOperation *)repositoryDetailWithUserName:(NSString *)userName repositoryName:(NSString *)repositoryName
                                   completoinHandler:
(RepositoryModelResponseBlock)completionBlock
                                         errorHandel:(MKNKErrorBlock)errorBlock;

//https://developer.github.com/v3/repos/#list-contributors
//List contributors ,GET /repos/:owner/:repo/contributors

//https://developer.github.com/v3/repos/forks/#list-forks
//List forks ,       GET /repos/:owner/:repo/forks

//https://developer.github.com/v3/activity/starring/#list-stargazers
//List Stargazers ,GET /repos/:owner/:repo/stargazers
- (MKNetworkOperation *)reposDetailCategoryWithPage:(NSInteger)page userName:(NSString *)userName repositoryName:(NSString *)repositoryName category:(NSString *)category completoinHandler:(PageListInfoResponseBlock)completionBlock
                                        errorHandel:(MKNKErrorBlock)errorBlock;

@end
