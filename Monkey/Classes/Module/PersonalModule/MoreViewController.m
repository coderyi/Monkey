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
#import "LoginViewController.h"
#import "LoginWebViewController.h"
#import "UserDetailViewController.h"
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    UITableView *tableView;
    UILabel *titleText;
    NSString *currentLogin;
    NSString *currentAvatarUrl;

}

@end

@implementation MoreViewController
#pragma mark - Lifecycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    currentLogin=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
    currentAvatarUrl=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentAvatarUrl"];
    [tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((ScreenWidth-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    titleText.text=@"More";
    
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped ];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
//    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - loginmodule


/**
 *  https://developer.github.com/v3/oauth/#redirect-users-to-request-github-access
 */
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
            currentAvatarUrl=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentAvatarUrl"];
            
            [tableView reloadData];
        }else{
        
        }
        
        
    };
    [self.navigationController pushViewController:login animated:YES];
    
    
//    [OCTClient setClientID:CoderyiClientID clientSecret:CoderyiClientSecret];
//    [[OCTClient
//      signInToServerUsingWebBrowser:OCTServer.dotComServer scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository]
//     subscribeNext:^(OCTClient *authenticatedClient) {
//         // Authentication was successful. Do something with the created client.
//         NSLog(@"%@",authenticatedClient);
//         
//         currentLogin=authenticatedClient.user.login;
//         //         currentAvatarUrl=authenticatedClient.user.avatar_url;
//         
//         [[NSUserDefaults standardUserDefaults] setObject:currentLogin forKey:@"currentLogin"];
//         //         [[NSUserDefaults standardUserDefaults] setObject:currentAvatarUrl forKey:@"currentAvatarUrl"];
//         [tableView reloadData];
//     } error:^(NSError *error) {
//         // Authentication failed.
//     }];
    
    
//    
//    OCTUser *user = [OCTUser userWithRawLogin:@"coderyi" server:OCTServer.dotComServer];
//    [[OCTClient signInAsUser:user password:@"1991812yy" oneTimePassword:nil scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository note:nil noteURL:nil fingerprint:nil]
//subscribeNext:^(OCTClient *authenticatedClient) {
//    // Authentication was successful. Do something with the created client.
//    NSLog(@"%@",authenticatedClient);
//    [[NSUserDefaults standardUserDefaults] setObject:authenticatedClient.token forKey:@"access_token"];
//    currentLogin=authenticatedClient.user.login;
//    currentAvatarUrl=[authenticatedClient.user.avatarURL absoluteString];
//    [[NSUserDefaults standardUserDefaults] setObject:currentLogin forKey:@"currentLogin"];
//    [[NSUserDefaults standardUserDefaults] setObject:currentAvatarUrl forKey:@"currentAvatarUrl"];
//    [tableView reloadData];
//
//   
//    
//} error:^(NSError *error) {
//    // Authentication failed.
//}];
    
}

- (void)login1Action:(NSString *)code{
    YiNetworkEngine *apiEngine=[[YiNetworkEngine alloc] initWithHostName:@"github.com"];
    [apiEngine loginWithCode:code completoinHandler:^(NSString *response){
        //        [self login2Action:<#(NSString *)#>];
        //        13 40
        if ([[response substringWithRange:NSMakeRange(0, 13)] isEqualToString:@"access_token="]) {
            NSString *token=[response substringWithRange:NSMakeRange(13, 40)];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"access_token"];

            [self login2Action:token];
        }
        
    } errorHandel:^(NSError* error){
        
    }];
}

- (void)login2Action:(NSString *)token{
    [ApplicationDelegate.apiEngine getUserInfoWithToken:token completoinHandler:^(UserModel *model){
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (currentLogin) {
        return 4;
    }
    return 3;
    

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
        if (currentLogin) {
            cell.textLabel.text=currentLogin;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:currentAvatarUrl]];
        }else{
            cell.textLabel.text=NSLocalizedString(@"login", @"");;
        }
        
    }else if (indexPath.section==1){
        
        cell.textLabel.text=NSLocalizedString(@"about", @"");;

        
    }else if (indexPath.section==2){
        cell.textLabel.text=NSLocalizedString(@"feedback", @"");;
    }
    if (currentLogin) {
        if (indexPath.section==3){
            cell.textLabel.text=NSLocalizedString(@"logout", @"");;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
//        LoginViewController *login=[[LoginViewController alloc] init];
//        [self.navigationController pushViewController:login animated:YES];
        if (currentLogin) {
            UserDetailViewController *detail=[[UserDetailViewController alloc] init];
            
            
            UserModel *model=[[UserModel alloc] init];
            model.login=currentLogin;
            detail.userModel=model;
           
            [self.navigationController pushViewController:detail animated:YES];
        }else{
            [self loginAction];
        }
        
    }else if (indexPath.section==1){
        AboutViewController *about=[[AboutViewController alloc] init];
        
        [self.navigationController pushViewController:about animated:YES];
//        NSString *savedLogin=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
//        NSString *savedToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
//
//        OCTUser *user1 = [OCTUser userWithRawLogin:savedLogin server:OCTServer.dotComServer];
//        OCTClient *client1 = [OCTClient authenticatedClientWithUser:user1 token:savedToken];
//            OCTUser *user=[OCTUser userWithRawLogin:@"onlyswan" server:OCTServer.dotComServer];
////        user.login=@"onlyswan";
//        OCTClient *client =[OCTClient unauthenticatedClientWithUser:user];
//        [[client1 hasFollowUser:user] subscribeNext:^(NSNumber *isFollowing){
//            
//            NSLog(@"%@",isFollowing);
//        }];
//        
//        [[client1 fetchUserInfoForUser:user] subscribeNext:^(OCTUser *user2){
//        
//            [client1 unfollowUser:user2];
//            [[client1 hasFollowUser:user2] subscribeNext:^(NSNumber *isFollowing){
//                
//                NSLog(@"%@",isFollowing);
//            }];
//        
//        } error:^(NSError *error) {
//            // Authentication failed.
//        }];
        
        
        
          
        
    }else if (indexPath.section==2){
        
        
        [self presentModalViewController:[UMFeedback feedbackModalViewController]
                                animated:YES];

    }
    
    
    if (currentLogin) {
        if (indexPath.section==3){
            UIAlertView *logoutAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出登录？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [logoutAlertView show];
            
        }
    }
    
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==0) {
        currentLogin=nil;
        currentAvatarUrl=nil;
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"currentLogin"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"currentAvatarUrl"];
        [tableView reloadData];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
