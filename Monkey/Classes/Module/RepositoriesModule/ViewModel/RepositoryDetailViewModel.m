
//
//  RepositoryDetailViewModel.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "RepositoryDetailViewModel.h"
@interface RepositoryDetailViewModel()
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;

@end

@implementation RepositoryDetailViewModel

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.DsOfPageListObject1 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject2 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject3 = [[DataSourceModel alloc]init];
    }
    return self;
}

- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst  currentIndex:(int)currentIndex firstTableData:(RepositoryDetailDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(RepositoryDetailDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(RepositoryDetailDataSourceModelResponseBlock)thirdCompletionBlock
{
    
    if (currentIndex==1) {
        
        NSInteger page = 0;
        
        if (isFirst) {
            page = 1;
            
        }else{
            
            page = self.DsOfPageListObject1.page+1;
        }
        [ApplicationDelegate.apiEngine reposDetailCategoryWithPage:page userName:_model.user.login repositoryName:_model.name category:@"contributors" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            
            if (page<=1) {
                [self.DsOfPageListObject1.dsArray removeAllObjects];
            }
            
            [self.DsOfPageListObject1.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject1.page=page;
            firstCompletionBlock(self.DsOfPageListObject1);

        } errorHandel:^(NSError* error){
            firstCompletionBlock(self.DsOfPageListObject1);

        }];
        
        return YES;
    }else if (currentIndex==2){
        NSInteger page = 0;
        if (isFirst) {
            page = 1;
            
        }else{
            page = self.DsOfPageListObject2.page+1;
        }
        [ApplicationDelegate.apiEngine reposDetailCategoryWithPage:page userName:_model.user.login repositoryName:_model.name category:@"forks" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            
            if (page<=1) {
                [self.DsOfPageListObject2.dsArray removeAllObjects];
            }
            [self.DsOfPageListObject2.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject2.page=page;
            secondCompletionBlock(self.DsOfPageListObject2);
        } errorHandel:^(NSError* error){
            secondCompletionBlock(self.DsOfPageListObject2);
        }];
        return YES;
    }else if (currentIndex==3){
        NSInteger page = 0;
        if (isFirst) {
            page = 1;
        }else{
            page = self.DsOfPageListObject3.page+1;
        }
        [ApplicationDelegate.apiEngine reposDetailCategoryWithPage:page userName:_model.user.login repositoryName:_model.name category:@"stargazers" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            if (page<=1) {
                [self.DsOfPageListObject3.dsArray removeAllObjects];
            }
            [self.DsOfPageListObject3.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject3.page=page;
            thirdCompletionBlock(self.DsOfPageListObject3);
        } errorHandel:^(NSError* error){
            thirdCompletionBlock(self.DsOfPageListObject3);
        }];
        return YES;
    }
    return YES;
}

@end
