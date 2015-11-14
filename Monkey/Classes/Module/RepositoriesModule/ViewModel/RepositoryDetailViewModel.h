//
//  RepositoryDetailViewModel.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RepositoryDetailDataSourceModelResponseBlock)(DataSourceModel* DsOfPageListObject);

@interface RepositoryDetailViewModel : NSObject
@property(nonatomic,strong) RepositoryModel *model;

/**
 *  load RepositoryDetailViewController network data
 *
 *  @param isFirst               is the first page data or not
 *  @param currentIndex          current index
 *  @param firstCompletionBlock  return this block to get the contributors datasource
 *  @param secondCompletionBlock return this block to get the forks datasource
 *  @param thirdCompletionBlock  return this block to get the stargazers datasource
 *
 *  @return success or fail
 */
- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst  currentIndex:(int)currentIndex firstTableData:(RepositoryDetailDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(RepositoryDetailDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(RepositoryDetailDataSourceModelResponseBlock)thirdCompletionBlock;

@end
