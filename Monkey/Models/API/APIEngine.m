//
//  APIEngine.m
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "APIEngine.h"
#import "RepositoryModel.h"

@implementation APIEngine
//https://developer.github.com/v3/search/#search-users
//Search users
- (MKNetworkOperation *)searchUsersWithPage:(NSInteger)page  q:(NSString *)q sort:(NSString *)sort categoryLocation:(NSString *)categoryLocation categoryLanguage:(NSString *)categoryLanguage completoinHandler:(PageListInfoResponseBlock)completionBlock
                                errorHandel:(MKNKErrorBlock)errorBlock
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    
    [dic setValue:q forKey:@"q"];
    [dic setValue:sort forKey:@"sort"];
    [dic setValue:[NSString stringWithFormat:@"%ld", (long)page] forKey:@"page"];
    
    
    
    //    NSString *getString = [NSString stringWithFormat:@"/search/users"];
    
    NSString *getString = [NSString stringWithFormat:@"/search/users?q=%@&sort=%@&page=%d",q,sort,page];
    
    
    
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    NSLog(@"url is %@",op.url);
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
                        model.rank=(page-1)*30+(i+1);
                        model.categoryLanguage=categoryLanguage;
                        model.categoryLocation=categoryLocation;
                         model.myID=[[NSDate date] timeIntervalSince1970];
                        [listNew addObject:model];
//                        [[UserManager sharedInstance] handleCategoryModel:model];
                        
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
- (MKNetworkOperation *)searchUsersWithPage:(NSInteger)page  q:(NSString *)q sort:(NSString *)sort completoinHandler:(PageListInfoResponseBlock)completionBlock
                                errorHandel:(MKNKErrorBlock)errorBlock
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    
    [dic setValue:q forKey:@"q"];
    [dic setValue:sort forKey:@"sort"];
    [dic setValue:[NSString stringWithFormat:@"%ld", (long)page] forKey:@"page"];

    
    
//    NSString *getString = [NSString stringWithFormat:@"/search/users"];

     NSString *getString = [NSString stringWithFormat:@"/search/users?q=%@&sort=%@&page=%d",q,sort,page];
    
    
    
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    NSLog(@"url is %@",op.url);
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

//https://developer.github.com/v3/search/#search-repositories
//Search repositories
- (MKNetworkOperation *)searchRepositoriesWithPage:(NSInteger)page  q:(NSString *)q sort:(NSString *)sort completoinHandler:(PageListInfoResponseBlock)completionBlock
                                errorHandel:(MKNKErrorBlock)errorBlock
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    
    [dic setValue:q forKey:@"q"];
    [dic setValue:sort forKey:@"sort"];
    [dic setValue:[NSString stringWithFormat:@"%ld", (long)page] forKey:@"page"];
    
    
    
    //    NSString *getString = [NSString stringWithFormat:@"/search/users"];
    
    NSString *getString = [NSString stringWithFormat:@"/search/repositories?q=%@&sort=%@&page=%d",q,sort,page];
    
    
    
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    NSLog(@"url is %@",op.url);
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





//https://developer.github.com/v3/users/#get-a-single-user
//Get a single user ,GET /users/:username
- (MKNetworkOperation *)userDetailWithUserName:(NSString *)userName
                                 completoinHandler:
(UserModelResponseBlock)completionBlock
                                       errorHandel:(MKNKErrorBlock)errorBlock {
   
    NSString *getString = [NSString stringWithFormat:@"/users/%@",userName];

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

//https://developer.github.com/v3/repos/#list-user-repositories
//List user repositories
//GET /users/:username/repos
- (MKNetworkOperation *)userRepositoriesWithPage:(NSInteger)page  userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                       errorHandel:(MKNKErrorBlock)errorBlock
{

    
    
    
    //    NSString *getString = [NSString stringWithFormat:@"/search/users"];
    
    NSString *getString = [NSString stringWithFormat:@"/users/%@/repos?sort=updated&page=%d",userName,page];
    
    
    
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    NSLog(@"url is %@",op.url);
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
- (MKNetworkOperation *)userFollowersWithPage:(NSInteger)page  userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                     errorHandel:(MKNKErrorBlock)errorBlock
{
    
    
    
    
    //    NSString *getString = [NSString stringWithFormat:@"/search/users"];
    
    NSString *getString = [NSString stringWithFormat:@"/users/%@/followers?page=%d",userName,page];
    
    
    
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    NSLog(@"url is %@",op.url);
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
- (MKNetworkOperation *)userFollowingWithPage:(NSInteger)page  userName:(NSString *)userName completoinHandler:(PageListInfoResponseBlock)completionBlock
                                     errorHandel:(MKNKErrorBlock)errorBlock
{
    
    
    
    
    //    NSString *getString = [NSString stringWithFormat:@"/search/users"];
    
    NSString *getString = [NSString stringWithFormat:@"/users/%@/following?page=%d",userName,page];
    
    
    
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    NSLog(@"url is %@",op.url);
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



//https://developer.github.com/v3/repos/#get
//Get
//GET /repos/:owner/:repo
- (MKNetworkOperation *)repositoryDetailWithUserName:(NSString *)userName repositoryName:(NSString *)repositoryName
                             completoinHandler:
(RepositoryModelResponseBlock)completionBlock
                                   errorHandel:(MKNKErrorBlock)errorBlock {
    
    NSString *getString = [NSString stringWithFormat:@"/repos/%@/%@",userName,repositoryName];
    
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    
    NSLog(@"%@", op.url);
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
- (MKNetworkOperation *)reposDetailCategoryWithPage:(NSInteger)page  userName:(NSString *)userName repositoryName:(NSString *)repositoryName category:(NSString *)category completoinHandler:(PageListInfoResponseBlock)completionBlock
                                  errorHandel:(MKNKErrorBlock)errorBlock
{
    
    
    
    
    //    NSString *getString = [NSString stringWithFormat:@"/search/users"];
    
    if ([category isEqualToString:@"forks"]) {
        
        NSString *getString = [NSString stringWithFormat:@"/repos/%@/%@/%@?page=%d",userName,repositoryName,category,page];
        
        
        
        MKNetworkOperation *op =
        [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
        NSLog(@"url is %@",op.url);
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
    
    
    NSString *getString = [NSString stringWithFormat:@"/repos/%@/%@/%@?page=%d",userName,repositoryName,category,page];
    
    
    
    MKNetworkOperation *op =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    NSLog(@"url is %@",op.url);
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
    
    return op;}
    return nil;
}



@end
