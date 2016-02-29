//
//  MoreViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "MoreViewController.h"
#import "SearchViewController.h"
#import "AboutViewController.h"
#import "UMFeedback.h"
#import "UserDetailViewController.h"
#import "LoginWebViewController.h"
#import "AESCrypt.h"
#import "NEHTTPEyeViewController.h"
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {
    UITableView *tableView;
    UILabel *titleText;
    NSString *currentLogin;
    NSString *currentAvatarUrl;
}

@end

@implementation MoreViewController

#pragma mark - Lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserInfoAction];

    currentLogin=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
    currentAvatarUrl=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentAvatarUrl"];
    [tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((ScreenWidth-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    titleText.text=NSLocalizedString(@"More", nil);
   
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped ];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - loginmodule

/**
 *  https://developer.github.com/v3/oauth/#redirect-users-to-request-github-access
 */

- (void)oauth2LoginAction{

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
    webViewController.urlString=[NSString stringWithFormat:@"https://github.com/login/oauth/authorize/?client_id=%@&state=1995&redirect_uri=https://github.com/coderyi/monkey&scope=user,public_repo",[[AESCrypt decrypt:CoderyiClientID password:@"xxxsd-sdsd*sd672323q___---_w.."] substringFromIndex:1] ];
    webViewController.callback=^(NSString *code){
        [self getUserInfoAction];
    };
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (void)getUserInfoAction
{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if (token.length<1 || !token) {
        return;
    }
    [ApplicationDelegate.apiEngine getUserInfoWithToken:nil completoinHandler:^(UserModel *model){
        if (model) {
            currentLogin=model.login;
            currentAvatarUrl=model.avatar_url;
            [[NSUserDefaults standardUserDefaults] setObject:currentLogin forKey:@"currentLogin"];
            [[NSUserDefaults standardUserDefaults] setObject:currentAvatarUrl forKey:@"currentAvatarUrl"];
            [tableView reloadData];
        }
    } errorHandel:^(NSError* error){
    }];
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#if defined(DEBUG)||defined(_DEBUG)
    if (currentLogin) {
        return 5;
    }
    return 4;
#else
    if (currentLogin) {
        return 4;
    }
    return 3;
#endif
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *cellId=@"CellId";
    cell=[tableView1 dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
#if defined(DEBUG)||defined(_DEBUG)
    if (indexPath.section==0) {
        if (currentLogin) {
            cell.textLabel.text=currentLogin;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:currentAvatarUrl]];
        }else{
            cell.textLabel.text=NSLocalizedString(@"login", @"");
        }
        
    }else if (indexPath.section==1) {
        cell.textLabel.text=NSLocalizedString(@"about", @"");
    }else if (indexPath.section==2) {
        cell.textLabel.text=NSLocalizedString(@"feedback", @"");
    }else if (indexPath.section==3) {
            cell.textLabel.text=@"Network Debug";
    }
    if (currentLogin) {
        if (indexPath.section==4) {
            cell.textLabel.text=NSLocalizedString(@"logout", @"");
        }
    }
#else
    if (indexPath.section==0) {
        if (currentLogin) {
            cell.textLabel.text=currentLogin;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:currentAvatarUrl]];
        }else{
            cell.textLabel.text=NSLocalizedString(@"login", @"");
        }
        
    }else if (indexPath.section==1) {
        
        cell.textLabel.text=NSLocalizedString(@"about", @"");
        
    }else if (indexPath.section==2) {
        cell.textLabel.text=NSLocalizedString(@"feedback", @"");
    }
    if (currentLogin) {
        if (indexPath.section==3) {
            cell.textLabel.text=NSLocalizedString(@"logout", @"");
        }
    }
#endif
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#if defined(DEBUG)||defined(_DEBUG)
    if (indexPath.section==0) {
        if (currentLogin) {
            UserDetailViewController *detail=[[UserDetailViewController alloc] init];
            UserModel *model=[[UserModel alloc] init];
            model.login=currentLogin;
            detail.userModel=model;
            [self.navigationController pushViewController:detail animated:YES];
        }else{
            [self oauth2LoginAction];
        }
    }else if (indexPath.section==1) {
        AboutViewController *about=[[AboutViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.section==2) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [self presentModalViewController:[UMFeedback feedbackModalViewController]
                                animated:YES];
#pragma clang diagnostic pop
        
    }else if (indexPath.section==3) {
    #if defined(DEBUG)||defined(_DEBUG)
            NEHTTPEyeViewController *vc=[[NEHTTPEyeViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
    #endif
    }
    if (currentLogin) {
        if (indexPath.section==4) {
            UIAlertView *logoutAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出登录？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [logoutAlertView show];
        }
    }
#else
    if (indexPath.section==0) {
        if (currentLogin) {
            UserDetailViewController *detail=[[UserDetailViewController alloc] init];
            UserModel *model=[[UserModel alloc] init];
            model.login=currentLogin;
            detail.userModel=model;
            [self.navigationController pushViewController:detail animated:YES];
        }else{
            [self oauth2LoginAction];
        }
    }else if (indexPath.section==1) {
        AboutViewController *about=[[AboutViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.section==2) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [self presentModalViewController:[UMFeedback feedbackModalViewController]
                                animated:YES];
#pragma clang diagnostic pop
        
    }
    
    if (currentLogin) {
        if (indexPath.section==3) {
            UIAlertView *logoutAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出登录？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [logoutAlertView show];
        }
    }
#endif
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        currentLogin=nil;
        currentAvatarUrl=nil;
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"currentLogin"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"currentAvatarUrl"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
        [tableView reloadData];
    }
}

@end
