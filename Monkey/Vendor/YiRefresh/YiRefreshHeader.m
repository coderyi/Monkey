//
//  YiRefreshHeader.m
//  YiRefresh
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//
//YiRefresh is a simple way to use pull-to-refresh.下拉刷新，大道至简，最简单的网络刷新控件
//项目地址在：https://github.com/coderyi/YiRefresh
//

#import "YiRefreshHeader.h"
@interface YiRefreshHeader (){
    
    float lastPosition;
    
    float contentHeight;
    float headerHeight;
    BOOL isRefresh;//是否正在刷新,默认是NO
    
    
    UILabel *headerLabel;
    UIView *headerView;
    UIImageView *headerIV;
    UIActivityIndicatorView *activityView;
    
}

@end
@implementation YiRefreshHeader
- (void)header{
    isRefresh=NO;
    lastPosition=0;
    headerHeight=35;
    float scrollWidth=_scrollView.frame.size.width;
    float imageWidth=13;
    float imageHeight=headerHeight;
    float labelWidth=130;
    float labelHeight=headerHeight;

    
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, -headerHeight-10, _scrollView.frame.size.width, headerHeight)];
      [_scrollView addSubview:headerView];
    
    
    
    headerLabel=[[UILabel alloc] initWithFrame:CGRectMake((scrollWidth-labelWidth)/2, 0, labelWidth, labelHeight)];
    [headerView addSubview:headerLabel];
    headerLabel.textAlignment=NSTextAlignmentCenter;
    headerLabel.text=NSLocalizedString(@"pull down", nil);
    headerLabel.font=[UIFont systemFontOfSize:14];
    
    
    headerIV=[[UIImageView alloc] initWithFrame:CGRectMake((scrollWidth-labelWidth)/2-imageWidth, 0, imageWidth, imageHeight)];
    [headerView addSubview:headerIV];
    headerIV.image=[UIImage imageNamed:@"down"];

   
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame=CGRectMake((scrollWidth-labelWidth)/2-imageWidth, 0, imageWidth, imageHeight);
    [headerView addSubview:activityView];
    
    
    
    activityView.hidden=YES;
    headerIV.hidden=NO;

    
    // 为_scrollView设置KVO的观察者对象，keyPath为contentOffset属性
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    
}


/**
 *  当属性的值发生变化时，自动调用此方法
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![@"contentOffset" isEqualToString:keyPath]) return;
    // 获取_scrollView的contentSize
    contentHeight=_scrollView.contentSize.height;

    // 判断是否在拖动_scrollView
    if (_scrollView.dragging) {
   
        int currentPostion = _scrollView.contentOffset.y;
        // 判断是否正在刷新  否则不做任何操作
        if (!isRefresh) {
            [UIView animateWithDuration:0.3 animations:^{
                
                
                
                // 当currentPostion 小于某个值时 变换状态
                if (currentPostion<-headerHeight*1.5) {
                    
                    headerLabel.text=NSLocalizedString(@"release", nil);
                    headerIV.transform = CGAffineTransformMakeRotation(M_PI);
                    
                }else{
                    
                    
                    int currentPostion = _scrollView.contentOffset.y;
                    // 判断滑动方向 以让“松开以刷新”变回“下拉可刷新”状态
                    if (currentPostion - lastPosition > 5) {
                        lastPosition = currentPostion;
                        headerIV.transform = CGAffineTransformMakeRotation(M_PI*2);
                        
                        headerLabel.text=NSLocalizedString(@"pull down", nil);
                    }else if (lastPosition - currentPostion > 5)
                    {
                        lastPosition = currentPostion;
                    }
                    
                }
                
                
            }];
      
          
        }
        
    }else{
        
        // 进入刷新状态
        if ([headerLabel.text isEqualToString:NSLocalizedString(@"release", nil)]) {
            [self beginRefreshing];
        }
        
        
    }
    
    
}


/**
 *  开始刷新操作  如果正在刷新则不做操作
 */
- (void)beginRefreshing{
    if (!isRefresh) {
        
        isRefresh=YES;
        headerLabel.text=NSLocalizedString(@"loading", nil);
        headerIV.hidden=YES;
        activityView.hidden=NO;
        [activityView startAnimating];
        
        // 设置刷新状态_scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            
            //修改有时候refresh contentOffset 还在0，0的情况 20150723
            CGPoint point= _scrollView.contentOffset;
            if (point.y>-headerHeight*1.5) {
                _scrollView.contentOffset=CGPointMake(0, point.y-headerHeight*1.5);
            }
            //
            _scrollView.contentInset=UIEdgeInsetsMake(headerHeight*1.5, 0, 0, 0);
        }];
        
        // block回调
        _beginRefreshingBlock();
    }

}


/**
 *  关闭刷新操作  请加在UIScrollView数据刷新后，如[tableView reloadData];
 */
- (void)endRefreshing{
    isRefresh=NO;

    dispatch_async(dispatch_get_main_queue(), ^{

        [UIView animateWithDuration:0.3 animations:^{
            CGPoint point= _scrollView.contentOffset;
            if (point.y!=0) {
                _scrollView.contentOffset=CGPointMake(0, point.y+headerHeight*1.5);
            }
            headerLabel.text=NSLocalizedString(@"pull down", nil);
            _scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
            headerIV.hidden=NO;
            headerIV.transform = CGAffineTransformMakeRotation(M_PI*2);
            [activityView stopAnimating];
            activityView.hidden=YES;
        }];
    });
}


- (void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    
}

@end
