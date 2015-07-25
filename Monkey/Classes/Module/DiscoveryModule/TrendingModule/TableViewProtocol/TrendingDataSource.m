//
//  TrendingDataSource.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "TrendingDataSource.h"
#import "RepositoriesTableViewCell.h"
@implementation TrendingDataSource
//@synthesize tableView1,tableView2,tableView3;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==11) {
        
        
        return self.DsOfPageListObject1.dsArray.count;
        
    }else if (tableView.tag==12){
        
        
        return self.DsOfPageListObject2.dsArray.count;
    }else if (tableView.tag==13){
        
        
        return self.DsOfPageListObject3.dsArray.count;
    }
    
    return self.DsOfPageListObject1.dsArray.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoriesTableViewCell *cell;
    if (tableView.tag==11) {
        
        
        NSString *cellId=@"CellId1";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        RepositoryModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
        cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url] placeholderImage:nil];
        cell.descriptionLabel.text=[NSString stringWithFormat:@"%@",model.repositoryDescription];
        
        [cell.homePageBt setTitle:model.homepage forState:UIControlStateNormal];
        if (model.homepage.length<1) {
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 85, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 85, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }else{
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 105, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 105, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }
        cell.starLabel.text=[NSString stringWithFormat:@"Star:%d",model.stargazers_count];
        cell.forkLabel.text=[NSString stringWithFormat:@"Fork:%d",model.forks_count];
        return cell;
        
        
        
    }else if (tableView.tag==12){
        
        
        NSString *cellId=@"CellId2";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        RepositoryModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
        cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url] placeholderImage:nil];
        cell.descriptionLabel.text=[NSString stringWithFormat:@"%@",model.repositoryDescription];
        
        [cell.homePageBt setTitle:model.homepage forState:UIControlStateNormal];
        if (model.homepage.length<1) {
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 85, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 85, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }else{
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 105, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 105, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }
        cell.starLabel.text=[NSString stringWithFormat:@"Star:%d",model.stargazers_count];
        cell.forkLabel.text=[NSString stringWithFormat:@"Fork:%d",model.forks_count];
        return cell;
        
    }else if (tableView.tag==13){
        
        NSString *cellId=@"CellId3";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        RepositoryModel  *model = [(self.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
        cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url] placeholderImage:nil];
        cell.descriptionLabel.text=[NSString stringWithFormat:@"%@",model.repositoryDescription];
        
        [cell.homePageBt setTitle:model.homepage forState:UIControlStateNormal];
        if (model.homepage.length<1) {
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 85, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 85, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }else{
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 105, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 105, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }
        cell.starLabel.text=[NSString stringWithFormat:@"Star:%d",model.stargazers_count];
        cell.forkLabel.text=[NSString stringWithFormat:@"Fork:%d",model.forks_count];
        return cell;
        
    }
    return cell;
    
    
}

@end
