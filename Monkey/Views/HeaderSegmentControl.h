//
//  HeaderSegmentControl.h
//  Monkey
//
//  Created by apple on 15/2/10.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderSegmentControl : UIView
@property UIButton *button1;
@property UIButton *button2;
@property UIButton *button3;
@property UIButton *button4;
@property ( strong) void (^ButtonActionBlock)(int buttonTag);
@property int buttonCount;
-(void)swipeAction:(int)tag;
@end
