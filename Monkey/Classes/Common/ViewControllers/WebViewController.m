//
//  WebViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>{
    
    
    UILabel *titleText;
    UIActivityIndicatorView *activityIndicator;
    UIWebView *webView;
}


@end

@implementation WebViewController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cityAppear"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    [activityIndicator removeFromSuperview];
    
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
//    self.navigationItem.titleView=titleText;
    titleText.text=_urlString;
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    [self.view addSubview:webView];
    webView.delegate=self;
    [webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlString]] ];
    
//    activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((ScreenWidth-60)/2, 100, 60, 60)];
//    [self.view addSubview:activityIndicator];
    activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(ScreenWidth-60, 0, 44, 44)];
    [self.navigationController.navigationBar addSubview:activityIndicator];
    activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
    
    UIButton *backBt=[UIButton buttonWithType:UIButtonTypeCustom];
    backBt.frame=CGRectMake(10, 10, 30, 40);
    [backBt setTitle:@"back" forState:UIControlStateNormal];
    [backBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(backBtAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:backBt];
    UIButton *closeBt=[UIButton buttonWithType:UIButtonTypeCustom];
    closeBt.frame=CGRectMake(70, 10, 30, 50);
    closeBt.titleLabel.font=[UIFont systemFontOfSize:12];
    [closeBt setTitle:@"close" forState:UIControlStateNormal];
    [closeBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBt addTarget:self action:@selector(closeBtAction) forControlEvents:UIControlEventTouchUpInside];

//    [self.navigationController.navigationBar addSubview:closeBt];
    
//    self.navigationItem.leftBarButtonItems=@[[[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtAction)],[[UIBarButtonItem alloc] initWithTitle:@"close" style:UIBarButtonItemStylePlain target:self action:@selector(closeBtAction)]];
    self.navigationItem.leftBarButtonItems=@[[[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtAction)]];
}
- (void)backBtAction{
    if (webView.canGoBack)
    {
        [webView goBack];
        self.navigationItem.leftBarButtonItems=@[[[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtAction)],[[UIBarButtonItem alloc] initWithTitle:@"close" style:UIBarButtonItemStylePlain target:self action:@selector(closeBtAction)]];
    }else{
        [self closeBtAction];
    }
}

- (void)closeBtAction{
    [self.navigationController popViewControllerAnimated:YES];

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

    [activityIndicator stopAnimating];
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
