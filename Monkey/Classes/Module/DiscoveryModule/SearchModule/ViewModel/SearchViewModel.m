
//
//  SearchViewModel.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "SearchViewModel.h"
@interface SearchViewModel()
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@end

@implementation SearchViewModel

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.DsOfPageListObject1 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject2 = [[DataSourceModel alloc]init];
    }
    return self;
}

- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst currentIndex:(int)currentIndex searchBarText:(NSString *)text  firstTableData:(SearchDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(SearchDataSourceModelResponseBlock)secondCompletionBlock
{
    
    if (text!=nil) {
        
        if (currentIndex==1){
            
            NSInteger page = 0;
            
            if (isFirst) {
                page = 1;
                
            }else{
                page = self.DsOfPageListObject1.page+1;
            }
            [ApplicationDelegate.apiEngine searchUsersWithPage:page  q:text sort:@"followers" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
                self.DsOfPageListObject1.totalCount=totalCount;
                
                if (page<=1) {
                    [self.DsOfPageListObject1.dsArray removeAllObjects];
                }
     
                [self.DsOfPageListObject1.dsArray addObjectsFromArray:modelArray];
                self.DsOfPageListObject1.page=page;
                firstCompletionBlock(self.DsOfPageListObject1);
            }
                                                   errorHandel:^(NSError* error){
                                                       firstCompletionBlock(self.DsOfPageListObject1);

                                                   }];
            return YES;
            
        }else if (currentIndex==2) {
            
            NSInteger page = 0;
            
            if (isFirst) {
                page = 1;
            }else{
                page = self.DsOfPageListObject2.page+1;
            }
            
            [ApplicationDelegate.apiEngine searchRepositoriesWithPage:page  q:text sort:@"stars" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            
                if (page<=1) {
                    [self.DsOfPageListObject2.dsArray removeAllObjects];
                }
                
                [self.DsOfPageListObject2.dsArray addObjectsFromArray:modelArray];
                self.DsOfPageListObject2.page=page;
                secondCompletionBlock(self.DsOfPageListObject2);

            }
                                                          errorHandel:^(NSError* error){
                                                              secondCompletionBlock(self.DsOfPageListObject2);
     
                                                          }];
            return YES;
        }
    }
    return YES;
    
}

@end
