
//
//  GitHubAwardsViewController.m
//  Monkey
//
//  Created by coderyi on 15/7/23.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "GitHubAwardsViewController.h"

@interface GitHubAwardsViewController ()<UITableViewDataSource,UITableViewDelegate, SFSafariViewControllerDelegate> {
    UITableView *tableView1;
    NSArray *rankCategorys;
}

@end

@implementation GitHubAwardsViewController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.title=@"github-awards";
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView1];
    tableView1.dataSource=self;
    tableView1.delegate=self;
    
    rankCategorys=@[@"users ranking world",@"users ranking country",@"users ranking city"];
    
    UILabel *headerLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    tableView1.tableHeaderView=headerLabel;
    headerLabel.textAlignment=NSTextAlignmentCenter;
    headerLabel.text=@"developers ranking by stars";
    headerLabel.textColor=YiTextGray;
    
    UIButton *footerButton=[UIButton buttonWithType:UIButtonTypeCustom];
    footerButton.frame=CGRectMake(0, 0, ScreenWidth, 30);
    tableView1.tableFooterView=footerButton;
    [footerButton setTitle:@"data come from github-awards.com" forState:UIControlStateNormal];
    [footerButton setTitleColor:YiBlue forState:UIControlStateNormal];
    footerButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [footerButton addTarget:self action:@selector(footerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)footerButtonAction
{    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://github-awards.com/"]];
    if ([[UIDevice currentDevice].systemVersion hasPrefix:@"9"]) {
        SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:URL];
        [self presentViewController:sfvc animated:YES completion:nil];
    } else {
        [[UIApplication sharedApplication] openURL:URL];
    }
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return rankCategorys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *cellId=@"CellId1";
    cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text=(rankCategorys)[indexPath.section];
    return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *webViewRankCategorys=@[@"world",@"country",@"city"];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://github-awards.com/users?type=%@",webViewRankCategorys[indexPath.section]]];
    if ([[UIDevice currentDevice].systemVersion hasPrefix:@"9"]) {
        SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:URL];
        [self presentViewController:sfvc animated:YES completion:nil];
    } else {
        [[UIApplication sharedApplication] openURL:URL];
    }
    
    
}

- (void)safariViewControllerDidFinish:(nonnull SFSafariViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
