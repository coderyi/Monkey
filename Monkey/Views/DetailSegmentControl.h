//
//  SegmentControl.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailSegmentControl : UIView
@property UILabel *label1;
@property UILabel *label2;
@property UILabel *label3;


@property UIButton *button1;
@property UIButton *button2;
@property UIButton *button3;

@property UILabel *bt1Label;
@property UILabel *bt2Label;
@property UILabel *bt3Label;

@property UILabel *bt1Label1;
@property UILabel *bt2Label1;
@property UILabel *bt3Label1;
@property ( strong) void (^ButtonActionBlock)(int buttonTag);
-(void)swipeAction:(int)tag;
@end
