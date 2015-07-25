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
- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst  currentIndex:(int)currentIndex firstTableData:(RepositoryDetailDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(RepositoryDetailDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(RepositoryDetailDataSourceModelResponseBlock)thirdCompletionBlock;
@end
