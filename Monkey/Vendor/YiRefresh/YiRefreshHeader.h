//
//  YiRefreshHeader.h
//  YiRefresh
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//YiRefresh is a simple way to use pull-to-refresh.下拉刷新，大道至简，最简单的网络刷新控件 
//项目地址在：https://github.com/coderyi/YiRefresh

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BeginRefreshingBlock)(void);



@interface YiRefreshHeader : NSObject
@property UIScrollView *scrollView;
@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;

-(void)header;


-(void)endRefreshing;
-(void)beginRefreshing;

@end
