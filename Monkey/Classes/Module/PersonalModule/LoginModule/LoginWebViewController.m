//
//  WebViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "LoginWebViewController.h"

@interface LoginWebViewController ()<UIWebViewDelegate>{
    
    
    UILabel *titleText;
    UIActivityIndicatorView *activityIndicator;
    UIButton *backBt;
}


@end

@implementation LoginWebViewController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cityAppear"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((ScreenWidth-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    titleText.text=_urlString;
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UINavigationBar *bar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:bar];
    bar.barTintColor=YiBlue;
    
    
    backBt=[UIButton buttonWithType:UIButtonTypeCustom];
    backBt.frame=CGRectMake(10, 27, 30, 30);
    [backBt setImage:[UIImage imageNamed:@"ic_arrow_back_white_48pt"] forState:UIControlStateNormal];
    [backBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(backBtAction) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBt];
    backBt.hidden=YES;
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [self.view addSubview:webView];
    webView.delegate=self;
    [webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlString]] ];
    
    activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((ScreenWidth-60)/2, 100, 60, 60)];
//    [self.view addSubview:activityIndicator];
    activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
}

- (void)backBtAction{
    _callback(@"error");
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [activityIndicator startAnimating];
//    [self hideYiProgressHUD];
    [self showYiProgressHUD:@"Login Loading..."];

    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *requestUrl = webView.request.URL.absoluteString;
    [activityIndicator stopAnimating];
    [self hideYiProgressHUD];

    for (int i=0; i<requestUrl.length-5; i++) {
        if ([[requestUrl substringWithRange:NSMakeRange(i, 5)] isEqualToString:@"code="]) {
            backBt.hidden=YES;

            [self loginTokenAction:[requestUrl substringWithRange:NSMakeRange(i+5, 20)]];
//            _callback([requestUrl substringWithRange:NSMakeRange(i+5, 20)]);
//            [self dismissViewControllerAnimated:YES completion:nil];

            return;
        }
    }

    backBt.hidden=NO;

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [activityIndicator stopAnimating];
    [self hideYiProgressHUD];
    backBt.hidden=NO;

    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    return YES;
}
- (void)loginTokenAction:(NSString *)code{
    [self showYiProgressHUD:@"Login..."];
    YiNetworkEngine *apiEngine=[[YiNetworkEngine alloc] initWithHostName:@"github.com"];
    [apiEngine loginWithCode:code completoinHandler:^(NSString *response){
        
        [self hideYiProgressHUD];

        for (int i=0; i<response.length-13; i++) {
            if ([[response substringWithRange:NSMakeRange(i, 13)] isEqualToString:@"access_token="]) {
                NSString *token=[response substringWithRange:NSMakeRange(i+13, 40)];
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"access_token"];
                
//                [self getUserInfoAction:token];
                            _callback(@"success");

                [self dismissViewControllerAnimated:YES completion:nil];
                return ;
                
            }
        }
        backBt.hidden=NO;

        
    } errorHandel:^(NSError* error){
        backBt.hidden=NO;
        [self hideYiProgressHUD];

    }];
}



@end
