//
//  RankTableViewCell.m
//  GitHubYi
//
//  Created by coderyi on 15/3/23.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "RankTableViewCell.h"

@implementation RankTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        float h=70.5;
        float orginX=0;
        float w=ScreenWidth-orginX*2;
        float preWidth=15;
        float rankWidth=45;
        float sufRankWidth=10;
        float imageViewWidth=50;
        float sufImageViewWidth=25;
        float labelWidth=w-2*preWidth-rankWidth-sufRankWidth-imageViewWidth-sufImageViewWidth;
        
        self.contentView.backgroundColor=YiGray;
        UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(orginX, 0, w, h)];
        
        [self.contentView addSubview:bgView];
        bgView.backgroundColor=[UIColor whiteColor];
        
        _rankLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, (h-30)/2, rankWidth+preWidth, 30)];
        [bgView addSubview:_rankLabel];
        
        _titleImageView=[[UIImageView alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth, (h-imageViewWidth)/2, imageViewWidth, imageViewWidth)];
        [bgView addSubview:_titleImageView];
        
        _mainLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth+imageViewWidth+sufImageViewWidth, (h-imageViewWidth)/2, labelWidth, imageViewWidth)];
        [bgView addSubview:_mainLabel];
        
        
        _detailLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth+imageViewWidth+sufImageViewWidth, (h-imageViewWidth)/2+imageViewWidth/2, labelWidth, imageViewWidth/2)];
//        [self.contentView addSubview:_detailLabel];
        _mainLabel.numberOfLines=0;
        _rankLabel.textColor=YiBlue;
        _mainLabel.textColor=YiBlue;
        _detailLabel.textColor=YiGray;
        _rankLabel.textAlignment=NSTextAlignmentCenter;
        _mainLabel.font=[UIFont systemFontOfSize:18];
        _detailLabel.font=[UIFont systemFontOfSize:13];
        _mainLabel.textAlignment=NSTextAlignmentLeft;
        _detailLabel.textAlignment=NSTextAlignmentLeft;
        
        _titleImageView.layer.cornerRadius=10;
        _titleImageView.layer.borderColor=YiGray.CGColor;
        _titleImageView.layer.borderWidth=0.3;
        _titleImageView.layer.masksToBounds=YES;

    }
    return self;
}

@end
