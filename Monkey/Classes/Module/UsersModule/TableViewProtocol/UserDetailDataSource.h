//
//  UserDetailDataSource.h
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetailDataSource : NSObject<UITableViewDataSource>

@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;//repo datasource
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;//following datasource
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;//follower datasource
@property(nonatomic,assign) int currentIndex;//current index in UserDetailViewController

@end
