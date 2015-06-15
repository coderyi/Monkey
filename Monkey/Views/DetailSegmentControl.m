//
//  SegmentControl.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "DetailSegmentControl.h"

@implementation DetailSegmentControl
int currentTag;

@synthesize label1,label2,label3,bt1Label,bt2Label,bt3Label,bt1Label1,bt2Label1,bt3Label1;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //float h=60; 30 28 2
        UIColor *black=[UIColor blackColor];
        //   float fontSize=15;
        UIFont *myFont=[UIFont boldSystemFontOfSize:16];
        float w=WScreen-10;
        //        self.backgroundColor=[UIColor colorWithHexString:BackgroudViewStyleColor];
        _button1=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button1];
        _button1.frame=CGRectMake(0, 0, w/3, 58);
        bt1Label=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, w/3, 23)];
        [_button1 addSubview:bt1Label];
        bt1Label.textColor=YiBlue;
        bt1Label.font=myFont;
//        bt1Label.text=@"12121";
        bt1Label.textAlignment=NSTextAlignmentCenter;
//        bt1Label.backgroundColor=[UIColor darkGrayColor];
        
        bt1Label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 28, w/3, 23)];
        [_button1 addSubview:bt1Label1];
        bt1Label1.textColor=YiBlue;
        bt1Label1.font=myFont;
        bt1Label1.text=@"Repositories";
        bt1Label1.textAlignment=NSTextAlignmentCenter;
//        bt1Label1.backgroundColor=[UIColor redColor];
        
//        _button1.backgroundColor=[UIColor redColor];
//        [_button1 setTitle:@"Repositories" forState:UIControlStateNormal];
        //  [_button1 setFont:[UIFont systemFontOfSize:12]];
        _button1.titleLabel.font = myFont;
        [_button1 setTitleColor:black forState:UIControlStateNormal];
        _button1.tag=101;
        [_button1 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _button2=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button2];
        _button2.frame=CGRectMake(w/3, 0, w/3, 58);
//        [_button2 setTitle:@"Following" forState:UIControlStateNormal];
        _button2.titleLabel.font = myFont;
        // [_button2 setFont:[UIFont systemFontOfSize:12]];
        [_button2 setTitleColor:black forState:UIControlStateNormal];
        _button2.tag=102;
        [_button2 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _button3=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button3];
        _button3.frame=CGRectMake(w/3+w/3, 0, w/3, 58);
//        [_button3 setTitle:@"Follower" forState:UIControlStateNormal];
        // [_button3 setFont:[UIFont systemFontOfSize:12]];
        _button3.titleLabel.font = myFont;
        [_button3 setTitleColor:black forState:UIControlStateNormal];
        _button3.tag=103;
        [_button3 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        bt2Label=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, w/3, 23)];
        [_button2 addSubview:bt2Label];
        bt2Label.textColor=black;
        bt2Label.font=myFont;
//        bt2Label.text=@"12121";
        bt2Label.textAlignment=NSTextAlignmentCenter;
        //        bt1Label.backgroundColor=[UIColor darkGrayColor];
        
        bt2Label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 28, w/3, 23)];
        [_button2 addSubview:bt2Label1];
        bt2Label1.textColor=black;
        bt2Label1.font=myFont;
        bt2Label1.text=@"Following";
        bt2Label1.textAlignment=NSTextAlignmentCenter;
        
        bt3Label=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, w/3, 23)];
        [_button3 addSubview:bt3Label];
        bt3Label.textColor=black;
        bt3Label.font=myFont;
//        bt3Label.text=@"12121";
        bt3Label.textAlignment=NSTextAlignmentCenter;
        //        bt1Label.backgroundColor=[UIColor darkGrayColor];
        
        bt3Label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 28, w/3, 23)];
        [_button3 addSubview:bt3Label1];
        bt3Label1.textColor=black;
        bt3Label1.font=myFont;
        bt3Label1.text=@"Follower";
        bt3Label1.textAlignment=NSTextAlignmentCenter;
        
        
        //        #F1A042
        label1=[[UILabel alloc] initWithFrame:CGRectMake(0+(w/3-50)/2, 58, 50, 2)];
        [self addSubview:label1];
        label1.backgroundColor=YiBlue;
        
        label2=[[UILabel alloc] initWithFrame:CGRectMake(w/3+(w/3-50)/2, 58, 50, 2)];
        [self addSubview:label2];
        label2.backgroundColor=YiBlue;
        
        label3=[[UILabel alloc] initWithFrame:CGRectMake(w/3+w/3+(w/3-50)/2, 58, 50, 2)];
        [self addSubview:label3];
        label3.backgroundColor=YiBlue;
        
       
        
        
        label1.hidden=YES;
        label2.hidden=YES;
        label3.hidden=YES;
        
        
        //        默认情况
        currentTag=101;
        label1.hidden=NO;
        [_button1 setTitleColor:YiBlue forState:UIControlStateNormal];
    }
    return self;
}
-(void)swipeAction:(int)tag{
    UIColor *black=[UIColor blackColor];
    switch (tag) {
        case 101:
            label1.hidden=NO;
            label2.hidden=YES;
            label3.hidden=YES;
            currentTag=101;
            [_button1 setTitleColor:YiBlue forState:UIControlStateNormal];
            [_button2 setTitleColor:black forState:UIControlStateNormal];
            [_button3 setTitleColor:black forState:UIControlStateNormal];
            
            bt1Label.textColor=YiBlue;
            bt2Label.textColor=black;
            bt3Label.textColor=black;
            
            bt1Label1.textColor=YiBlue;
            bt2Label1.textColor=black;
            bt3Label1.textColor=black;
            
            break;
        case 102:
            label1.hidden=YES;
            label2.hidden=NO;
            label3.hidden=YES;
            currentTag=102;
            [_button1 setTitleColor:black forState:UIControlStateNormal];
            [_button2 setTitleColor:YiBlue forState:UIControlStateNormal];
            [_button3 setTitleColor:black forState:UIControlStateNormal];
            
            bt1Label.textColor=black;
            bt2Label.textColor=YiBlue;
            bt3Label.textColor=black;
            bt1Label1.textColor=black;
            bt2Label1.textColor=YiBlue;
            bt3Label1.textColor=black;
            break;
        case 103:
            label1.hidden=YES;
            label2.hidden=YES;
            label3.hidden=NO;
            currentTag=103;
            [_button1 setTitleColor:black forState:UIControlStateNormal];
            [_button2 setTitleColor:black forState:UIControlStateNormal];
            [_button3 setTitleColor:YiBlue forState:UIControlStateNormal];
            bt1Label.textColor=black;
            bt2Label.textColor=black;
            bt3Label.textColor=YiBlue;
            bt1Label1.textColor=black;
            bt2Label1.textColor=black;
            bt3Label1.textColor=YiBlue;
            break;
        
        default:
            break;
    }
    if (_ButtonActionBlock) {
        _ButtonActionBlock(currentTag);
    }
    
}
-(void)btAction:(UIButton *)button{
    [self swipeAction:button.tag];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
