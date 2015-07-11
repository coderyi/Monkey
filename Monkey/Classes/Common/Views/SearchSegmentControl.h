//
//  SearchSegmentControl.h
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchSegmentControl : UIView
{
    UILabel *label1;
    UILabel *label2;
}
@property(nonatomic,strong) UIButton *button1;
@property(nonatomic,strong) UIButton *button2;
@property(nonatomic,copy) void (^ButtonActionBlock)(int buttonTag);
@end
