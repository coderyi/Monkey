//
//  SearchDataSource.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchDataSource : NSObject<UITableViewDataSource>
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;//the users datasource
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;//the repo datasource
@end
