
//
//  UserDetailDataSource.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserDetailDataSource.h"
#import "RepositoriesTableViewCell.h"
#import "RankTableViewCell.h"
@implementation UserDetailDataSource
@synthesize currentIndex;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (currentIndex==1) {
        return self.DsOfPageListObject1.dsArray.count;
        
    }else if (currentIndex==2){
        
        return self.DsOfPageListObject2.dsArray.count;
        
    }else if (currentIndex==3){
        
        return self.DsOfPageListObject3.dsArray.count;
        
        
    }
    
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex==1) {
        
        
        NSString *cellId=@"CellId";
        RepositoriesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.userLabel.hidden=YES;
            cell.titleImageView.hidden=YES;
            
        }
        RepositoryModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
        //    cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
        //    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url] placeholderImage:nil];
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
    }else if (currentIndex==2){
        
        RankTableViewCell *cell;
        
        NSString *cellId=@"CellId1";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        UserModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.mainLabel.text=[NSString stringWithFormat:@"%@",model.login];
        cell.detailLabel.text=[NSString stringWithFormat:@"id:%d",model.userId];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:nil];
        return cell;
    }else if (currentIndex==3){ RankTableViewCell *cell;
        
        NSString *cellId=@"CellId2";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        UserModel  *model = [(self.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.mainLabel.text=[NSString stringWithFormat:@"%@",model.login];
        cell.detailLabel.text=[NSString stringWithFormat:@"id:%d",model.userId];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:nil];
        return cell;
    }
    return nil;
    
    
}



@end
