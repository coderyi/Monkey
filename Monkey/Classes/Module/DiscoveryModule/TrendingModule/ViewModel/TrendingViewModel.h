//
//  TrendingViewModel.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DataSourceModelResponseBlock)(DataSourceModel* DsOfPageListObject);

@interface TrendingViewModel : NSObject

/**
 *  load TrendingViewController network data
 *
 *  @param isFirst               is the first page data or not
 *  @param currentIndex          current index
 *  @param firstCompletionBlock  return this block to get the daily datasource
 *  @param secondCompletionBlock return this block to get the weekly datasource
 *  @param thirdCompletionBlock  return this block to get the monthly datasource
 *
 *  @return success or fail
 */
- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst currentIndex:(int)currentIndex  firstTableData:(DataSourceModelResponseBlock)firstCompletionBlock secondTableData:(DataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(DataSourceModelResponseBlock)thirdCompletionBlock;

@end
