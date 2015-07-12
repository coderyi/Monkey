//
//  LoginViewController.m
//  Monkey
//
//  Created by coderyi on 15/7/11.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginWebViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
#pragma mark - Lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cityAppear"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"登录";
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    UIButton *test=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:test];
    test.frame=CGRectMake(100, 100, 100, 50);
    [test addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    test.titleLabel.text=@"登录";
    test.titleLabel.textColor=[UIColor whiteColor];
    test.backgroundColor=[UIColor redColor];
    
    
    UIButton *test1=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:test1];
    test1.frame=CGRectMake(100, 200, 100, 50);
    [test1 addTarget:self action:@selector(login1Action) forControlEvents:UIControlEventTouchUpInside];
    test1.titleLabel.text=@"登录1";
    test1.titleLabel.textColor=[UIColor whiteColor];
    test1.backgroundColor=[UIColor redColor];
    
    
    UIButton *test2=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:test2];
    test2.frame=CGRectMake(100, 300, 100, 50);
    [test2 addTarget:self action:@selector(login2Action) forControlEvents:UIControlEventTouchUpInside];
    test2.titleLabel.text=@"登录2";
    test2.titleLabel.textColor=[UIColor whiteColor];
    test2.backgroundColor=[UIColor redColor];

    
}
#pragma mark - Actions

- (void)loginAction{
//    YiNetworkEngine *apiEngine=[[YiNetworkEngine alloc] initWithHostName:@"github.com"];
//    [apiEngine loginWithCompletoinHandler:^(NSString *response){
//        
//    } errorHandel:^(NSError* error){
//        
//    }];
//
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
    webViewController.urlString=@"https://github.com/login/oauth/authorize/?client_id=a8d9c1a366f057a23753&state=1995&redirect_uri=https://github.com/coderyi";
    webViewController.callback=^(NSString *code){
    
//        [self login1Action:code];
    };
    [self presentViewController:webViewController animated:YES completion:nil];
    
}

- (void)login1Action:(NSString *)code{
        YiNetworkEngine *apiEngine=[[YiNetworkEngine alloc] initWithHostName:@"github.com"];
    [apiEngine loginWithCode:code completoinHandler:^(NSString *response){
//        [self login2Action:<#(NSString *)#>];
//        13 40
        if ([[response substringWithRange:NSMakeRange(0, 13)] isEqualToString:@"access_token="]) {
            NSString *token=[response substringWithRange:NSMakeRange(13, 40)];
            [self login2Action:token];
        }
       
    } errorHandel:^(NSError* error){
        
    }];
}

- (void)login2Action:(NSString *)token{
    [ApplicationDelegate.apiEngine getUserInfoWithToken:token completoinHandler:^(UserModel *model){
        
    } errorHandel:^(NSError* error){
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
