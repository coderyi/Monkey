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


- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst currentIndex:(int)currentIndex  firstTableData:(DataSourceModelResponseBlock)firstCompletionBlock secondTableData:(DataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(DataSourceModelResponseBlock)thirdCompletionBlock;
@end
