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
- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst  currentIndex:(int)currentIndex firstTableData:(UserRankDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(UserRankDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(UserRankDataSourceModelResponseBlock)thirdCompletionBlock;
@end
