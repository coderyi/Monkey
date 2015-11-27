//
//  APIEngine.m
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "YiNetworkEngine.h"
#import "RepositoryModel.h"
#import "ShowcasesModel.h"
#import "UserReceivedEventModel.h"
#import "AESCrypt.h"
@implementation YiNetworkEngine

#pragma mark - login module
//GitHub redirects back to your site
//https://developer.github.com/v3/oauth/#github-redirects-back-to-your-site
//POST https://github.com/login/oauth/access_token
- (MKNetworkOperation *)loginWithCode:(NSString *)code
                    completoinHandler:(StringResponseBlock)completionBlock
                          errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/login/oauth/access_token/"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[[AESCrypt decrypt:CoderyiClientID password:@"xxxsd-sdsd*sd672323q___---_w.."] substringFromIndex:1] forKey:@"client_id"];
    [dic setValue:[[AESCrypt decrypt:CoderyiClientSecret password:@"xx3xc45sqvzupb4xsd-sdsd*sd672323q___---_w.."] substringFromIndex:1] forKey:@"client_secret"];
    [dic setValue:code forKey:@"code"];
    [dic setValue:@"1995" forKey:@"state"];
    [dic setValue:@"https://github.com/coderyi/monkey" forKey:@"redirect_uri"];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:dic httpMethod:@"POST" ssl:YES];
    NSLog(@"%@", op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        completionBlock([completedOperation responseString]);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

//https://developer.github.com/v3/oauth/#use-the-access-token-to-access-the-api
- (MKNetworkOperation *)getUserInfoWithToken:(NSString *)token
                           completoinHandler:(UserModelResponseBlock)completionBlock
                                 errorHandel:(MKNKErrorBlock)errorBlock
{
    if (token.length<1 || !token) {
        token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    }
    NSString *getString = [NSString stringWithFormat:@"/user?access_token=%@",token];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
        NSLog(@"%@", op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            UserModel *model = [UserModel modelWithDict:resultDictionary];
            completionBlock(model);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

#pragma mark - event 、news
- (MKNetworkOperation *)repositoriesTrendingWithPage:(NSInteger)page login:(NSString *)login
                                    completoinHandler:(PageListInfoResponseBlock)completionBlock
                                          errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/users/%@/received_events?&page=%ld",login,(long)page];
        MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSArray class]]) {
            NSArray *list = [completedOperation responseJSON];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        UserReceivedEventModel *model = [UserReceivedEventModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, page,1);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

#pragma mark - trending

- (MKNetworkOperation *)showcasesDetailListWithShowcase:(NSString *)showcase completoinHandler:(PageListInfoResponseBlock)completionBlock
                                       errorHandel:(MKNKErrorBlock)errorBlock
{
    
    NSString *getString = [NSString stringWithFormat:@"/v2/showcases/%@",showcase];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            NSArray *list = [resultDictionary objectForKey:@"repositories"];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        RepositoryModel *model = [RepositoryModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, 1,1);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)repositoriesTrendingWithType:(NSString *)type language:(NSString *)language
                                 completoinHandler:(PageListInfoResponseBlock)completionBlock
                                       errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString ;
    if (language.length<1 || !language || [language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
        getString = [NSString stringWithFormat:@"/v2/trending?since=%@",type];
    }else{
        getString = [NSString stringWithFormat:@"/v2/trending?since=%@&language=%@",type,language];
    }
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSArray class]]) {
            NSArray *list = [completedOperation responseJSON];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        RepositoryModel *model = [RepositoryModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, 0,1);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)showcasesWithCompletoinHandler:(PageListInfoResponseBlock)completionBlock
                                         errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/v2/showcases"];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSArray class]]) {
            NSArray *list = [completedOperation responseJSON];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        ShowcasesModel *model = [ShowcasesModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, 0,1);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

#pragma mark - starmodule
- (MKNetworkOperation *)checkStarStatusWithOwner:(NSString *)owner
                                            repo:(NSString *)repo
                               completoinHandler:(void (^)(BOOL isStarring))completionBlock
                                     errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *getString = [NSString stringWithFormat:@"/user/starred/%@/%@?access_token=%@",owner,repo,access_token];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode==404){
            completionBlock(NO);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        if (errorOp.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (errorOp.HTTPStatusCode==404){
            completionBlock(NO);
        }else{
            errorBlock(error);
        }
    }];
    [self enqueueOperation:op];
    return op;
}

//Star a repository
//PUT /user/starred/:owner/:repo
- (MKNetworkOperation *)starRepoWithOwner:(NSString *)owner
                                   repo:(NSString *)repo
                             completoinHandler:(void (^)(BOOL isSuccess))completionBlock
                                   errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *getString = [NSString stringWithFormat:@"/user/starred/%@/%@?access_token=%@",owner,repo,access_token];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"PUT" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode==404){
            completionBlock(NO);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        if (errorOp.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (errorOp.HTTPStatusCode==404){
            completionBlock(NO);
        }else{
            errorBlock(error);
        }
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)unStarRepoWithOwner:(NSString *)owner
                                     repo:(NSString *)repo
                        completoinHandler:(void (^)(BOOL isSuccess))completionBlock
                              errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *getString = [NSString stringWithFormat:@"/user/starred/%@/%@?access_token=%@",owner,repo,access_token];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"DELETE" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode==404){
            completionBlock(NO);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        if (errorOp.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (errorOp.HTTPStatusCode==404){
            completionBlock(NO);
        }else{
            errorBlock(error);
        }
    }];
    [self enqueueOperation:op];
    return op;
}

#pragma mark - followmodule
//Check if one user follows another
//https://developer.github.com/v3/users/followers/#check-if-one-user-follows-another
- (MKNetworkOperation *)checkFollowStatusWithUsername:(NSString *)username
                                          target_user:(NSString *)target_user
                           completoinHandler:(void (^)(BOOL isFollowing))completionBlock
                                 errorHandel:(MKNKErrorBlock)errorBlock
{
    if (username.length<1) {
        username=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
    }
    NSString *getString = [NSString stringWithFormat:@"/users/%@/following/%@",username,target_user];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode==404){
            completionBlock(NO);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        if (errorOp.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (errorOp.HTTPStatusCode==404){
            completionBlock(NO);
        }else{
            errorBlock(error);
        }
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)followUserWithUsername:(NSString *)username
                                          target_user:(NSString *)target_user
                                    completoinHandler:(void (^)(BOOL isSuccess))completionBlock
                                          errorHandel:(MKNKErrorBlock)errorBlock
{
    if (username.length<1) {
        username=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
    }
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *getString = [NSString stringWithFormat:@"/user/following/%@?access_token=%@",target_user,access_token];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"PUT" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode==404){
            completionBlock(NO);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        if (errorOp.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (errorOp.HTTPStatusCode==404){
            completionBlock(NO);
        }else{
            errorBlock(error);
        }
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)unfollowUserWithUsername:(NSString *)username
                                   target_user:(NSString *)target_user
                             completoinHandler:(void (^)(BOOL isSuccess))completionBlock
                                   errorHandel:(MKNKErrorBlock)errorBlock
{
    if (username.length<1) {
        username=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
    }
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *getString = [NSString stringWithFormat:@"/user/following/%@?access_token=%@",target_user,access_token];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"DELETE" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode==404){
            completionBlock(NO);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        if (errorOp.HTTPStatusCode==204) {
            completionBlock(YES);
        }else if (errorOp.HTTPStatusCode==404){
            completionBlock(NO);
        }else{
            errorBlock(error);
        }
    }];
    [self enqueueOperation:op];
    return op;
}

#pragma mark - users module
//https://developer.github.com/v3/search/#search-users
//Search users
- (MKNetworkOperation *)searchUsersWithPage:(NSInteger)page q:(NSString *)q sort:(NSString *)sort categoryLocation:(NSString *)categoryLocation categoryLanguage:(NSString *)categoryLanguage completoinHandler:(PageListInfoResponseBlock)completionBlock
                                errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/search/users?q=%@&sort=%@&page=%li",q,sort,(long)page];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            NSInteger totalCount=[[resultDictionary objectForKey:@"total_count"] intValue];
            NSArray *list = [resultDictionary objectForKey:@"items"];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        UserModel *model = [UserModel modelWithDict:dict];
                        model.rank=(int)((page-1)*30+(i+1));
                        model.categoryLanguage=categoryLanguage;
                        model.categoryLocation=categoryLocation;
                        model.myID=[[NSDate date] timeIntervalSince1970];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, page,totalCount);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

//https://developer.github.com/v3/search/#search-users
//Search users
- (MKNetworkOperation *)searchUsersWithPage:(NSInteger)page q:(NSString *)q sort:(NSString *)sort completoinHandler:(PageListInfoResponseBlock)completionBlock
                                errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/search/users?q=%@&sort=%@&page=%ld",q,sort,(long)page];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            NSInteger totalCount=[[resultDictionary objectForKey:@"total_count"] intValue];
            NSArray *list = [resultDictionary objectForKey:@"items"];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        UserModel *model = [UserModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, page,totalCount);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

//https://developer.github.com/v3/users/#get-a-single-user
//Get a single user ,GET /users/:username
- (MKNetworkOperation *)userDetailWithUserName:(NSString *)userName
                                 completoinHandler:
(UserModelResponseBlock)completionBlock
                                       errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/users/%@",userName];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            UserModel *model = [UserModel modelWithDict:resultDictionary];
            completionBlock(model);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

//https://developer.github.com/v3/repos/#list-user-repositories
//List user repositories
//GET /users/:username/repos
- (MKNetworkOperation *)userRepositoriesWithPage:(NSInteger)page userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                       errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/users/%@/repos?sort=updated&page=%ld",userName,(long)page];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSArray class]]) {
            NSArray *list = [completedOperation responseJSON];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        RepositoryModel *model = [RepositoryModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, page,0);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

//List followers of a user
//https://developer.github.com/v3/users/followers/#list-followers-of-a-user
//GET /users/:username/followers
- (MKNetworkOperation *)userFollowersWithPage:(NSInteger)page userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                     errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/users/%@/followers?page=%ld",userName,(long)page];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSArray class]]) {
            NSArray *list = [completedOperation responseJSON];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        UserModel *model = [UserModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, page,0);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

//List users followed by another user
//https://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
//GET /users/:username/following
- (MKNetworkOperation *)userFollowingWithPage:(NSInteger)page userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                     errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/users/%@/following?page=%ld",userName,(long)page];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSArray class]]) {
            NSArray *list = [completedOperation responseJSON];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        UserModel *model = [UserModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, page,0);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

#pragma mark - repositories module
//https://developer.github.com/v3/search/#search-repositories
//Search repositories
- (MKNetworkOperation *)searchRepositoriesWithPage:(NSInteger)page q:(NSString *)q sort:(NSString *)sort completoinHandler:(PageListInfoResponseBlock)completionBlock
                                       errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/search/repositories?q=%@&sort=%@&page=%ld",q,sort,(long)page];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            NSInteger totalCount=[[resultDictionary objectForKey:@"total_count"] intValue];
            NSArray *list = [resultDictionary objectForKey:@"items"];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count > 0) {
                    NSMutableArray *listNew =
                    [[NSMutableArray alloc] initWithCapacity:32];
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = [list objectAtIndex:i];
                        RepositoryModel *model = [RepositoryModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew, page,totalCount);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

//https://developer.github.com/v3/repos/#get
//Get
//GET /repos/:owner/:repo
- (MKNetworkOperation *)repositoryDetailWithUserName:(NSString *)userName repositoryName:(NSString *)repositoryName
                             completoinHandler:
(RepositoryModelResponseBlock)completionBlock
                                   errorHandel:(MKNKErrorBlock)errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/repos/%@/%@",userName,repositoryName];
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            RepositoryModel *model = [RepositoryModel modelWithDict:resultDictionary];
            completionBlock(model);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

//https://developer.github.com/v3/repos/#list-contributors
//List contributors ,GET /repos/:owner/:repo/contributors

//https://developer.github.com/v3/repos/forks/#list-forks
//List forks ,       GET /repos/:owner/:repo/forks

//https://developer.github.com/v3/activity/starring/#list-stargazers
//List Stargazers ,GET /repos/:owner/:repo/stargazers
- (MKNetworkOperation *)reposDetailCategoryWithPage:(NSInteger)page userName:(NSString *)userName repositoryName:(NSString *)repositoryName category:(NSString *)category completoinHandler:(PageListInfoResponseBlock)completionBlock
                                  errorHandel:(MKNKErrorBlock)errorBlock
{
    if ([category isEqualToString:@"forks"]) {
        NSString *getString = [NSString stringWithFormat:@"/repos/%@/%@/%@?page=%ld",userName,repositoryName,category,(long)page];
        MKNetworkOperation *op =
        [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            if ([[completedOperation responseJSON]
                 isKindOfClass:[NSArray class]]) {
                NSArray *list = [completedOperation responseJSON];
                if ([list isKindOfClass:[NSArray class]]) {
                    if (list.count > 0) {
                        NSMutableArray *listNew =
                        [[NSMutableArray alloc] initWithCapacity:32];
                        for (NSInteger i = 0; i < list.count; i++) {
                            NSDictionary *dict = [list objectAtIndex:i];
                            RepositoryModel *model = [RepositoryModel modelWithDict:dict];
                            [listNew addObject:model];
                        }
                        completionBlock(listNew, page,0);
                    }
                }
            }
        } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
            errorBlock(error);
        }];
        [self enqueueOperation:op];
        return op;
    }else{
        NSString *getString = [NSString stringWithFormat:@"/repos/%@/%@/%@?page=%ld",userName,repositoryName,category,(long)page];
        MKNetworkOperation *op =
        [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            if ([[completedOperation responseJSON]
                 isKindOfClass:[NSArray class]]) {
                NSArray *list = [completedOperation responseJSON];
                if ([list isKindOfClass:[NSArray class]]) {
                    if (list.count > 0) {
                        NSMutableArray *listNew =
                        [[NSMutableArray alloc] initWithCapacity:32];
                        for (NSInteger i = 0; i < list.count; i++) {
                            NSDictionary *dict = [list objectAtIndex:i];
                            UserModel *model = [UserModel modelWithDict:dict];
                            [listNew addObject:model];
                        }
                        completionBlock(listNew, page,0);
                    }
                }
            }
        } errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
            errorBlock(error);
        }];
        [self enqueueOperation:op];
        return op;
    }
    return nil;
}

@end
