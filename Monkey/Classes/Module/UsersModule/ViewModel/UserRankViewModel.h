//
//  UserRankViewModel.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UserRankDataSourceModelResponseBlock)(DataSourceModel* DsOfPageListObject);

@interface UserRankViewModel : NSObject

/**
 *  load UserRankViewController network data
 *
 *  @param isFirst               is the first page data or not
 *  @param currentIndex          current index
 *  @param firstCompletionBlock  return this block to get the city datasource
 *  @param secondCompletionBlock return this block to get the country datasource
 *  @param thirdCompletionBlock  return this block to get the world datasource
 *
 *  @return success or fail
 */
- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst  currentIndex:(int)currentIndex firstTableData:(UserRankDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(UserRankDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(UserRankDataSourceModelResponseBlock)thirdCompletionBlock;

@end
