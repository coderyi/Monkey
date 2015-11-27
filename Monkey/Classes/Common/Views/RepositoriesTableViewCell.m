//
//  RepositoriesTableViewCell.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "RepositoriesTableViewCell.h"

@implementation RepositoriesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        float h=94.5; //orginY*2+repositoryLabelHeight*4+spacce*2=96
        float heightSpace=2;
        float orginX=0;
        float w=ScreenWidth-orginX*2;
        float preWidth=10;
        float rankWidth=40;
        float sufRankWidth=10;
        float repositoryLabelWidth=180;
        float userLabelWidth=110;
        float imageViewWidth=30;
        float labelWidth=w-2*preWidth-rankWidth-sufRankWidth;

        float repositoryLabelHeight=20;
        float orginY=5;
        
        self.contentView.backgroundColor=YiGray;
        UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(orginX, 0, w, h)];
        
        [self.contentView addSubview:bgView];
        bgView.backgroundColor=[UIColor whiteColor];
        
        _rankLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth, orginY, rankWidth, repositoryLabelHeight)];
        [bgView addSubview:_rankLabel];
  
        _repositoryLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth, orginY, repositoryLabelWidth, repositoryLabelHeight)];
//        _repositoryLabel.backgroundColor=[UIColor blueColor];
        [bgView addSubview:_repositoryLabel];
        
        _userLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth, orginY+repositoryLabelHeight+heightSpace, userLabelWidth, repositoryLabelHeight)];
        [bgView addSubview:_userLabel];
        
        _descriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth, orginY+repositoryLabelHeight*2+heightSpace*2, labelWidth, repositoryLabelHeight*2)];
        [bgView addSubview:_descriptionLabel];
        
        //todo
        _titleImageView=[[UIImageView alloc] initWithFrame:CGRectMake(preWidth+(rankWidth - imageViewWidth)/2, orginY+30+heightSpace, imageViewWidth, imageViewWidth)];
        [bgView addSubview:_titleImageView];
        
        
        _starLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth+repositoryLabelWidth, orginY, 65, repositoryLabelHeight)];
        [bgView addSubview:_starLabel];
        
        _forkLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth+65+5+repositoryLabelWidth, orginY, 65, repositoryLabelHeight)];
//        [bgView addSubview:_forkLabel];
        
        _homePageBt=[UIButton buttonWithType:UIButtonTypeCustom];
        [bgView addSubview:_homePageBt];
        [_homePageBt setTitleColor:YiBlue forState:UIControlStateNormal];
        _homePageBt.titleLabel.font=[UIFont systemFontOfSize:12];
        _homePageBt.frame=CGRectMake(preWidth+rankWidth+sufRankWidth+userLabelWidth, orginY+repositoryLabelHeight+heightSpace, labelWidth-userLabelWidth, repositoryLabelHeight);
        _homePageBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _homePageBt.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _descriptionLabel.numberOfLines=0;
        _userLabel.font=[UIFont systemFontOfSize:12];
        _userLabel.textColor=YiTextGray;
        
        
        _titleImageView.layer.cornerRadius=5;
        _titleImageView.layer.borderColor=YiGray.CGColor;
        _titleImageView.layer.borderWidth=0.2;
        _titleImageView.layer.masksToBounds=YES;
        
        _descriptionLabel.font=[UIFont systemFontOfSize:13];

        _starLabel.font=[UIFont systemFontOfSize:12];
        _starLabel.textColor=YiTextGray;
        
        _forkLabel.font=[UIFont systemFontOfSize:12];
        _forkLabel.textColor=YiTextGray;
        
        _rankLabel.textColor=YiBlue;
        _rankLabel.textAlignment=NSTextAlignmentCenter;
        _repositoryLabel.textColor=YiBlue;
    }
    return self;
}

@end
