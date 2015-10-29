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
    
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    [self.view addSubview:webView];
    webView.delegate=self;
    [webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlString]] ];
    
    activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((ScreenWidth-60)/2, 100, 60, 60)];
    [self.view addSubview:activityIndicator];
    activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [activityIndicator startAnimating];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *requestUrl = webView.request.URL.absoluteString;
    NSLog(@"requestUrl   %@",requestUrl);
    [activityIndicator stopAnimating];
//    if ([[requestUrl substringWithRange:NSMakeRange(27, 5)] isEqualToString:@"code="]) {
//        _callback([requestUrl substringWithRange:NSMakeRange(32, 20)]);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    32  20
    for (int i=0; i<requestUrl.length-5; i++) {
        if ([[requestUrl substringWithRange:NSMakeRange(i, 5)] isEqualToString:@"code="]) {
            
            _callback([requestUrl substringWithRange:NSMakeRange(i+5, 20)]);
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
    }

    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [activityIndicator stopAnimating];
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    return YES;
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
