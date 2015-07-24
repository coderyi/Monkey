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
#import "LoginViewController.h"
@interface DiscoveryViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView;
    NSString *currentLogin;
}

@end

@implementation DiscoveryViewController
#pragma mark -Lifecycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    currentLogin=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];

}
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
       
        if (currentLogin) {
            NewsViewController *viewController=[[NewsViewController alloc] init];
            viewController.login=currentLogin;
            [self.navigationController pushViewController:viewController animated:YES];
        }else{
            [self loginAction];
        }
        
        
        
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
- (void)loginAction{
    
    
    /*
     //    cookie清除
     NSHTTPCookie *cookie;
     NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
     for (cookie in [storage cookies])
     {
     [storage deleteCookie:cookie];
     }
     
     //    缓存  清除
     [[NSURLCache sharedURLCache] removeAllCachedResponses];
     LoginWebViewController *webViewController=[[LoginWebViewController alloc] init];
     webViewController.urlString=@"https://github.com/login/oauth/authorize/?client_id=a8d9c1a366f057a23753&state=1995&redirect_uri=https://github.com/coderyi&scope=user:follow";
     webViewController.callback=^(NSString *code){
     
     [self login1Action:code];
     };
     [self presentViewController:webViewController animated:YES completion:nil];
     */
    
    LoginViewController *login=[[LoginViewController alloc] init];
    login.callback=^(NSString *response){
        if ([response isEqualToString:@"yes"]) {
            currentLogin=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
            
            [tableView reloadData];
        }else{
            
        }
        
        
    };
    [self.navigationController pushViewController:login animated:YES];
    
}

@end
