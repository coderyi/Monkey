//
//  UserRankDataSource.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRankDataSource : NSObject<UITableViewDataSource>

@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;//city datasource
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;//country datasource
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;//world datasource

@end
