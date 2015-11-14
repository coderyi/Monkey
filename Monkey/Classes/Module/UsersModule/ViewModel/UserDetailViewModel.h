//
//  UserDetailViewModel.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UserDetailDataSourceModelResponseBlock)(DataSourceModel* DsOfPageListObject);

@interface UserDetailViewModel : NSObject
@property(nonatomic,strong) UserModel *userModel;

/**
 *  load UserDetailViewController network data
 *
 *  @param isFirst               is the first page data or not
 *  @param currentIndex          current index
 *  @param firstCompletionBlock  return this block to get the repo datasource
 *  @param secondCompletionBlock return this block to get the following datasource
 *  @param thirdCompletionBlock  return this block to get the follower datasource
 *
 *  @return success or fail
 */
- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst  currentIndex:(int)currentIndex firstTableData:(UserDetailDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(UserDetailDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(UserDetailDataSourceModelResponseBlock)thirdCompletionBlock;

@end
