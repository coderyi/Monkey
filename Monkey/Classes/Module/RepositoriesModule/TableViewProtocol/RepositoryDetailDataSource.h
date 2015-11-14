//
//  RepositoryDetailDataSource.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryDetailDataSource : NSObject<UITableViewDataSource>
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;//contributors datasource
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;//forks datasource
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;//stargazers datasource
@property(nonatomic,assign) int currentIndex;//current index in RepositoryDetailViewController

@end
