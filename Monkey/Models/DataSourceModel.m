//
//  DataSourceModel.m
//  shouyoutv
//
//  Created by apple on 13-12-25.
//  Copyright (c) 2013年 hm. All rights reserved.
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

-(void)reset
{
    self.page=0;
    [self.dsArray removeAllObjects];
}







@end
