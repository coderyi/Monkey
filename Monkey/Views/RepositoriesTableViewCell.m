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
        float h=135;
        float orginX=0;
        float w=WScreen-orginX*2;
        float preWidth=15;
        float rankWidth=45;
        float sufRankWidth=10;
        float repositoryLabelWidth=180;
        float sufRepositoryWidth=10;
        float imageViewWidth=30;
        float labelWidth=w-2*preWidth-rankWidth-sufRankWidth;

        float repositoryLabelHeight=20;
        float orginY=5;
        
        self.contentView.backgroundColor=YiGray;
        UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(orginX, 0, w, h)];
        
        [self.contentView addSubview:bgView];
        bgView.backgroundColor=[UIColor whiteColor];
        
        _rankLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, (h-30)/2, rankWidth+preWidth, 30)];
        [bgView addSubview:_rankLabel];
  
        _repositoryLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth, orginY, repositoryLabelWidth, repositoryLabelHeight)];
//        _repositoryLabel.backgroundColor=[UIColor blueColor];
        [bgView addSubview:_repositoryLabel];
        
        _userLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth, orginY+repositoryLabelHeight, repositoryLabelWidth, repositoryLabelHeight)];
        [bgView addSubview:_userLabel];
        
        _descriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth, orginY+repositoryLabelHeight*2, labelWidth, repositoryLabelHeight*2)];
        [bgView addSubview:_descriptionLabel];
        
        _titleImageView=[[UIImageView alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth+repositoryLabelWidth+sufRepositoryWidth, (repositoryLabelHeight*2-imageViewWidth)/2+5, imageViewWidth, imageViewWidth)];
        [bgView addSubview:_titleImageView];
        
        
        _starLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth, orginY+repositoryLabelHeight*5, 70, repositoryLabelHeight)];
        [bgView addSubview:_starLabel];
        
        _forkLabel=[[UILabel alloc] initWithFrame:CGRectMake(preWidth+rankWidth+sufRankWidth+70+10, orginY+repositoryLabelHeight*5, 70, repositoryLabelHeight)];
        [bgView addSubview:_forkLabel];
        
        _homePageBt=[UIButton buttonWithType:UIButtonTypeCustom];
        [bgView addSubview:_homePageBt];
//        _homePageBt.backgroundColor=[UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];
        [_homePageBt setTitleColor:YiBlue forState:UIControlStateNormal];
        [_homePageBt setFont:[UIFont systemFontOfSize:12]];
        _homePageBt.frame=CGRectMake(preWidth+rankWidth+sufRankWidth, orginY+repositoryLabelHeight*4, labelWidth, repositoryLabelHeight);
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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
