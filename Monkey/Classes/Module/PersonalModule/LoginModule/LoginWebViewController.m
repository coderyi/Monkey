//
//  WebViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "LoginWebViewController.h"

@interface LoginWebViewController ()<UIWebViewDelegate>

@end

@implementation LoginWebViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.hidesBottomBarWhenPushed = YES;
    
    /*
     before iOS7, use tintColor, since iOS7, use barTintBar.
     */
    self.navigationController.navigationBar.tintColor = YiBlue;
    self.navigationController.navigationBar.barTintColor = YiBlue;
    self.navigationItem.title = NSLocalizedString(@"login", nil);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backBtAction)];
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backButton;
    
    CGFloat originalY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-originalY)];
    [self.view addSubview:webView];
    webView.delegate=self;
    [webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlString]]];
}

- (void)backBtAction
{
    WEAKSELF;
    [self dismissViewControllerAnimated:YES completion:^{
        STRONGSELF;
        if (strongSelf.callback) {
            strongSelf.callback(@"error");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showYiProgressHUD:@"Login Loading..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *requestUrl = webView.request.URL.absoluteString;
    [self hideYiProgressHUD];
    
    NSString *toCheckString = @"code=";
    NSRange range = [requestUrl rangeOfString:toCheckString];
    if (range.location != NSNotFound) {
        NSString *code = nil;
        
        NSArray *stringsArray = [self arrayFromResponseString:requestUrl];
        for (NSString *string in stringsArray) {
            range = [string rangeOfString:toCheckString];
            if (range.location != NSNotFound) {
                code = [string substringFromIndex:range.location+range.length];
                break;
            }
        }
        
        if (code.length > 0) {
            [self loginTokenAction:code];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideYiProgressHUD];
}

- (void)loginTokenAction:(NSString *)code
{
    [self showYiProgressHUD:@"Login..."];
    YiNetworkEngine *apiEngine=[[YiNetworkEngine alloc] initWithHostName:@"github.com"];
    
    WEAKSELF;
    [apiEngine loginWithCode:code completoinHandler:^(NSString *response){
        STRONGSELF;
        [strongSelf hideYiProgressHUD];
        
        NSString *token = nil;
        
        NSArray *stringsArray = [self arrayFromResponseString:response];
        for (NSString *string in stringsArray) {
            NSRange range = [response rangeOfString:@"access_token="];
            if (range.location != NSNotFound) {
                token = [string substringWithRange:NSMakeRange(range.location+range.length, string.length -range.location-range.length)];
                break;
            }
        }
        
        if (token.length > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"access_token"];
            
            __weak typeof(strongSelf) weakRef = strongSelf;
            [strongSelf dismissViewControllerAnimated:YES completion:^{
                typeof(weakRef) strongRef = weakRef;
                if (strongRef.callback) {
                    strongRef.callback(@"success");
                }
            }];
        }
    } errorHandel:^(NSError* error){
        STRONGSELF;
        [strongSelf hideYiProgressHUD];
    }];
}

- (NSArray *)arrayFromResponseString:(NSString *)responseString {
    return [responseString componentsSeparatedByString:@"&"];
}

@end
