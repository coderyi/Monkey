
//
//  SearchDataSource.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "SearchDataSource.h"

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
    UITableViewCell *cell;
    if (tableView.tag==11) {
        NSString *cellId=@"CellId1";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        UserModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        cell.textLabel.text=model.login;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
        cell.imageView.layer.masksToBounds=YES;
        cell.imageView.layer.cornerRadius=8;
        return cell;
        
    }else if (tableView.tag==12){
        
        NSString *cellId=@"CellId2";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        RepositoryModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@",model.full_name];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@  %@",model.language,model.repositoryDescription];
        cell.detailTextLabel.textColor=YiTextGray;
        return cell;
    }
    return cell;
  
}

@end
