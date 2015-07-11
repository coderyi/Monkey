//
//  RepositoriesTableViewCell.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepositoriesTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel *rankLabel;
@property(nonatomic,strong) UILabel *repositoryLabel;
@property(nonatomic,strong) UILabel *userLabel;
@property(nonatomic,strong) UILabel *descriptionLabel;
@property(nonatomic,strong) UILabel *starLabel;
@property(nonatomic,strong) UILabel *forkLabel;
@property(nonatomic,strong) UIImageView *titleImageView;
@property(nonatomic,strong) UIButton *homePageBt;
@end
