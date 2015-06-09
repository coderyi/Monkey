//
//  YiRefreshFooter.h
//  YiRefresh
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BeginRefreshingBlock)(void);
@interface YiRefreshFooter : NSObject
@property UIScrollView *scrollView;
@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;


-(void)footer;

-(void)endRefreshing;
-(void)beginRefreshing;
@end
