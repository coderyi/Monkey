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


- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst  currentIndex:(int)currentIndex firstTableData:(UserDetailDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(UserDetailDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(UserDetailDataSourceModelResponseBlock)thirdCompletionBlock;
@end
