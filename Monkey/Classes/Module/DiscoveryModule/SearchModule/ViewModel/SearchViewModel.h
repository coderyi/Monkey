//
//  SearchViewModel.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SearchDataSourceModelResponseBlock)(DataSourceModel* DsOfPageListObject);

@interface SearchViewModel : NSObject

/**
 *  load SearchViewController network data
 *
 *  @param isFirst               is the first page data or not
 *  @param currentIndex          current index
 *  @param text                  searchBar text
 *  @param firstCompletionBlock  return this block to get the daily datasource
 *  @param secondCompletionBlock return this block to get the daily datasource
 *
 *  @return success or fail
 */
- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst currentIndex:(int)currentIndex searchBarText:(NSString *)text  firstTableData:(SearchDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(SearchDataSourceModelResponseBlock)secondCompletionBlock;

@end
