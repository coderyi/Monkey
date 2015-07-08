//
//  YiRefreshHeader.h
//  YiRefresh
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//
//YiRefresh is a simple way to use pull-to-refresh.下拉刷新，大道至简，最简单的网络刷新控件
//项目地址在：https://github.com/coderyi/YiRefresh
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BeginRefreshingBlock)(void);



@interface YiRefreshHeader : NSObject
@property(nonatomic,strong) UIScrollView *scrollView;

/**
 *  正在刷新的回调
 */
@property(nonatomic,copy) BeginRefreshingBlock beginRefreshingBlock;

/**
 *  header的初始化
 */
-(void)header;

/**
 *  开始刷新操作  如果正在刷新则不做操作
 */
-(void)beginRefreshing;

/**
 *  关闭刷新操作  请加在UIScrollView数据刷新后，如[tableView reloadData];
 */
-(void)endRefreshing;



@end