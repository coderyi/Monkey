//
//  SegmentControl.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailSegmentControl : UIView
@property(nonatomic,strong) UILabel *label1;
@property(nonatomic,strong) UILabel *label2;
@property(nonatomic,strong) UILabel *label3;


@property(nonatomic,strong) UIButton *button1;
@property(nonatomic,strong) UIButton *button2;
@property(nonatomic,strong) UIButton *button3;

@property(nonatomic,strong) UILabel *bt1Label;
@property(nonatomic,strong) UILabel *bt2Label;
@property(nonatomic,strong) UILabel *bt3Label;

@property(nonatomic,strong) UILabel *bt1Label1;
@property(nonatomic,strong) UILabel *bt2Label1;
@property(nonatomic,strong) UILabel *bt3Label1;
@property(nonatomic,copy) void (^ButtonActionBlock)(int buttonTag);
-(void)swipeAction:(NSInteger)tag;
@end
