//
//  HeaderSegmentControl.h
//  Monkey
//
//  Created by apple on 15/2/10.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderSegmentControl : UIView
@property(nonatomic,strong) UIButton *button1;
@property(nonatomic,strong) UIButton *button2;
@property(nonatomic,strong) UIButton *button3;
@property(nonatomic,strong) UIButton *button4;
@property(nonatomic,copy) void (^ButtonActionBlock)(int buttonTag);
@property(nonatomic,assign) int buttonCount;
-(void)swipeAction:(NSInteger)tag;
@end
