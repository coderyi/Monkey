
//
//  UserRankDataSource.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserRankDataSource.h"
#import "RankTableViewCell.h"
@implementation UserRankDataSource

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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankTableViewCell *cell;
    if (tableView.tag==11) {
        NSString *cellId=@"CellId1";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        UserModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
        cell.mainLabel.text=[NSString stringWithFormat:@"%@",model.login];
        cell.detailLabel.text=[NSString stringWithFormat:@"id:%d",model.userId];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
        return cell;
        
    }else if (tableView.tag==12){
        
        NSString *cellId=@"CellId2";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        UserModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
        cell.mainLabel.text=[NSString stringWithFormat:@"%@",model.login];
        cell.detailLabel.text=[NSString stringWithFormat:@"id:%d",model.userId];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
        return cell;
        
    }else if (tableView.tag==13){
        
        NSString *cellId=@"CellId3";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        UserModel  *model = [(self.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
        cell.mainLabel.text=[NSString stringWithFormat:@"%@",model.login];
        cell.detailLabel.text=[NSString stringWithFormat:@"id:%d",model.userId];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
        return cell;
        
    }
    return cell;
    
    
}
@end
