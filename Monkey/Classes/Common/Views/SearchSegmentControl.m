//
//  SearchSegmentControl.m
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "SearchSegmentControl.h"

@interface SearchSegmentControl () {
    int currentTag;
}
@end

@implementation SearchSegmentControl


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //float h=30;
        UIColor *black=[UIColor blackColor];
        //float fontSize=15;
        UIFont *myFont=[UIFont boldSystemFontOfSize:16];
        float w=ScreenWidth-10;
        //        self.backgroundColor=[UIColor colorWithHexString:BackgroudViewStyleColor];
        _button1=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button1];
        _button1.frame=CGRectMake(0, 0, w/2, 28);
        [_button1 setTitle:@"Users" forState:UIControlStateNormal];
        //  [_button1 setFont:[UIFont systemFontOfSize:12]];
        _button1.titleLabel.font = myFont;
        [_button1 setTitleColor:black forState:UIControlStateNormal];
        _button1.tag=101;
        [_button1 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _button2=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button2];
        _button2.frame=CGRectMake(w/2, 0, w/2, 28);
        [_button2 setTitle:@"Repositories" forState:UIControlStateNormal];
        _button2.titleLabel.font = myFont;
        // [_button2 setFont:[UIFont systemFontOfSize:12]];
        [_button2 setTitleColor:black forState:UIControlStateNormal];
        _button2.tag=102;
        [_button2 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //        #F1A042
        label1=[[UILabel alloc] initWithFrame:CGRectMake(0+(w/2-50)/2, 28, 50, 2)];
        [self addSubview:label1];
        label1.backgroundColor=YiBlue;
        
        label2=[[UILabel alloc] initWithFrame:CGRectMake(w/2+(w/2-50)/2, 28, 50, 2)];
        [self addSubview:label2];
        label2.backgroundColor=YiBlue;
        
        label1.hidden=YES;
        label2.hidden=YES;
        
        //        默认情况
        currentTag=101;
        label1.hidden=NO;
        [_button1 setTitleColor:YiBlue forState:UIControlStateNormal];
    }
    return self;
}

-(void)btAction:(UIButton *)button
{
    UIColor *black=[UIColor blackColor];
    switch (button.tag) {
        case 101:
            label1.hidden=NO;
            label2.hidden=YES;
            currentTag=101;
            [_button1 setTitleColor:YiBlue forState:UIControlStateNormal];
            [_button2 setTitleColor:black forState:UIControlStateNormal];
            break;
        case 102:
            label1.hidden=YES;
            label2.hidden=NO;
            currentTag=102;
            [_button1 setTitleColor:black forState:UIControlStateNormal];
            [_button2 setTitleColor:YiBlue forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    if (_ButtonActionBlock) {
        _ButtonActionBlock(currentTag);
    }
}

@end
