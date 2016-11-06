
//
//  SearchDataSource.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "SearchDataSource.h"
#import "RankTableViewCell.h"
#import "RepositoriesTableViewCell.h"

@implementation SearchDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==11) {
        return self.DsOfPageListObject1.dsArray.count;
    }else if (tableView.tag==12){
        return self.DsOfPageListObject2.dsArray.count;
    }
    return self.DsOfPageListObject1.dsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==11) {
        RankTableViewCell *cell;
        NSString *cellId=@"CellId1";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        UserModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        cell.mainLabel.text=model.login;
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
        return cell;
        
    }else if (tableView.tag==12){
        RepositoriesTableViewCell *cell;

        NSString *cellId=@"CellId2";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        RepositoryModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        
        cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
        cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url]];
        cell.descriptionLabel.text=[NSString stringWithFormat:@"%@",model.repositoryDescription];
        [cell.homePageBt setTitle:model.homepage forState:UIControlStateNormal];
        cell.starLabel.text=[NSString stringWithFormat:@"Star:%d",model.stargazers_count];
        cell.forkLabel.text=[NSString stringWithFormat:@"Fork:%d",model.forks_count];
        return cell;
    }
    return nil;
  
}

@end
