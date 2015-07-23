//
//  DiscoveryViewController.m
//  Monkey
//
//  Created by coderyi on 15/7/13.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "SearchViewController.h"
#import "TrendingViewController.h"
#import "ShowcasesViewController.h"
#import "NewsViewController.h"
#import "WebViewController.h"
#import "GitHubRankingViewController.h"
#import "GitHubAwardsViewController.h"
@interface DiscoveryViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView;
}

@end

@implementation DiscoveryViewController
#pragma mark -Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake((ScreenWidth-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    titleText.text=NSLocalizedString(@"Discovery", @"");
    self.view.backgroundColor=[UIColor whiteColor];
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped ];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    NSString *cellId=@"CellId";
    cell=[tableView1 dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section==0) {
        
            cell.textLabel.text=@"trending";
        
        
    }else if (indexPath.section==1){
        cell.textLabel.text=@"showcases";
        
        
    }else if (indexPath.section==2){
        
        cell.textLabel.text=@"news";
        
        
    }else if (indexPath.section==3){
        cell.textLabel.text=NSLocalizedString(@"search", @"");
    }else if (indexPath.section==4){
        
        
        cell.textLabel.text=@"githubranking";
        
    }else if (indexPath.section==5){
        cell.textLabel.text=@"github-awards";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TrendingViewController *viewController=[[TrendingViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];

    }else if (indexPath.section==1){
        ShowcasesViewController *viewController=[[ShowcasesViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (indexPath.section==2){
        NewsViewController *viewController=[[NewsViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (indexPath.section==3){
        
        SearchViewController *viewController=[[SearchViewController alloc] init];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
        
    }else if (indexPath.section==4){
        
        GitHubRankingViewController *viewController=[[GitHubRankingViewController alloc] init];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if (indexPath.section==5){
        
        GitHubAwardsViewController *viewController=[[GitHubAwardsViewController alloc] init];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    
    
    
    
}


@end
