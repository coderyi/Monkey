//
//  DataSourceModel.m
//  Monkey
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "DataSourceModel.h"

@implementation DataSourceModel

- (id)init
{
    self = [super init];
    if (self) {
        self.dsArray = [[NSMutableArray alloc]initWithCapacity:32];
        
        self.page = 0;
      
        
        
    }
    return self;
}

- (void)reset
{
    self.page=0;
    [self.dsArray removeAllObjects];
}







@end
