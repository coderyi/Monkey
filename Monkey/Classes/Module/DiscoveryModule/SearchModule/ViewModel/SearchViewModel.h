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
- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst currentIndex:(int)currentIndex searchBarText:(NSString *)text  firstTableData:(SearchDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(SearchDataSourceModelResponseBlock)secondCompletionBlock;
@end
