//
//  AutoLayoutTableViewCell.m
//  AutoLayoutDemo
//
//  Created by coderyi on 15/6/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ShowcasesTableViewCell.h"

@implementation ShowcasesTableViewCell
@synthesize titleLabel,descriptionLabel,logoImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        titleLabel=[[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textColor=YiBlue;
        
        descriptionLabel=[[UILabel alloc] init];
        [self.contentView addSubview:descriptionLabel];
        descriptionLabel.backgroundColor=[UIColor clearColor];
        descriptionLabel.numberOfLines=0;
        descriptionLabel.textColor=YiTextGray;
        logoImageView=[[UIImageView alloc] init];
        logoImageView.layer.masksToBounds=YES;
        logoImageView.layer.cornerRadius=20;
        [self.contentView addSubview:logoImageView];
        titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
        descriptionLabel.translatesAutoresizingMaskIntoConstraints=NO;
        logoImageView.translatesAutoresizingMaskIntoConstraints=NO;
        
        NSArray *constraints1=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[logoImageView(==40)]-8-[titleLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(logoImageView,titleLabel)];
        NSArray *constraints2=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[logoImageView(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(logoImageView)];
         NSArray *constraints3=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLabel(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)];
        NSArray *constraints4=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-58-[descriptionLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(descriptionLabel)];
        NSArray *constraints5=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[descriptionLabel]-(>=20)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(descriptionLabel)];
        [self.contentView addConstraints:constraints1];
        [self.contentView addConstraints:constraints2];
        [self.contentView addConstraints:constraints3];
        [self.contentView addConstraints:constraints4];
        [self.contentView addConstraints:constraints5];
        
    }
    return self;
}

-(CGFloat)calulateHeightWithtTitle:(NSString*)title desrip:(NSString*)descrip
{
    //这里非常重要
    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-108;
    [self.descriptionLabel setPreferredMaxLayoutWidth:preMaxWaith];
    [self.titleLabel setText:title];
    //这也很重要
    [self.descriptionLabel layoutIfNeeded];
    [self.descriptionLabel setText:descrip];
    [self.contentView layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //加1是关键
    return size.height+1.0f;
}

@end
