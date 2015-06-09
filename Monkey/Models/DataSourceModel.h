//
//  DataSourceModel.h
//  shouyoutv
//
//  Created by apple on 13-12-25.
//  Copyright (c) 2013年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DataSourceModel : NSObject

@property(nonatomic,strong)NSMutableArray *dsArray;
@property(nonatomic)NSInteger page;
@property(nonatomic)NSInteger totalCount;

-(void)reset;






@end
