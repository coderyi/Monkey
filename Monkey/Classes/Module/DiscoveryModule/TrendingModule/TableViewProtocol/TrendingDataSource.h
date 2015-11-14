//
//  TrendingDataSource.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrendingDataSource : NSObject<UITableViewDataSource>

@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;//the daily datasource
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;//the weekly datasource
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;//the monthly datasource

@end
