//
//  WebViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate> {
    UILabel *titleText;
    UIActivityIndicatorView *activityIndicator;
    UIWebView *webView;
    UIButton *backBt;
    UIButton *closeBt;
}

@end

@implementation WebViewController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [activityIndicator removeFromSuperview];
}

- (void)viewDidLoad
{
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
    titleText.text=_urlString;
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    [self.view addSubview:webView];
    webView.delegate=self;
    [webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlString]] ];
    
    activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(ScreenWidth-60, 0, 44, 44)];
    [self.navigationController.navigationBar addSubview:activityIndicator];
    activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
    
    backBt=[UIButton buttonWithType:UIButtonTypeCustom];
    backBt.frame=CGRectMake(0, 0, 30, 30);
    [backBt setImage:[UIImage imageNamed:@"ic_arrow_back_white_48pt"] forState:UIControlStateNormal];
    [backBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(backBtAction) forControlEvents:UIControlEventTouchUpInside];
    closeBt=[UIButton buttonWithType:UIButtonTypeCustom];
    closeBt.frame=CGRectMake(0, 0, 30, 30);
    closeBt.titleLabel.font=[UIFont systemFontOfSize:12];
    [closeBt setImage:[UIImage imageNamed:@"ic_cancel_white_48pt"] forState:UIControlStateNormal];
    [closeBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBt addTarget:self action:@selector(closeBtAction) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItems=@[[[UIBarButtonItem alloc] initWithCustomView:backBt]];
}

- (void)backBtAction
{
    if (webView.canGoBack)
    {
        [webView goBack];
        self.navigationItem.leftBarButtonItems=@[[[UIBarButtonItem alloc] initWithCustomView:backBt],[[UIBarButtonItem alloc] initWithCustomView:closeBt]];
    }else{
        [self closeBtAction];
    }
}

- (void)closeBtAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [activityIndicator stopAnimating];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

@end
