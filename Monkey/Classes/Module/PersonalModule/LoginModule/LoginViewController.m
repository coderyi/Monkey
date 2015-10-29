//
//  LoginViewController.m
//  Monkey
//
//  Created by coderyi on 15/7/11.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "LoginViewController.h"
#import "AESCrypt.h"
@interface LoginViewController (){
    UITextField *usernameTF;
    UITextField *pwdTF;
}

@end

@implementation LoginViewController
#pragma mark - Lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"GitHub.com login";
    self.view.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIImageView *titleIV=[[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-40)/2, 100, 40, 40)];
    [self.view addSubview:titleIV];
    titleIV.image=[UIImage imageNamed:@"github60"];
    usernameTF=[[UITextField alloc] initWithFrame:CGRectMake((ScreenWidth-300)/2, 150, 300, 40)];
    [self.view addSubview:usernameTF];
    usernameTF.backgroundColor=[UIColor whiteColor];
    usernameTF.textAlignment=NSTextAlignmentCenter;
    usernameTF.layer.borderWidth=0.4;
    usernameTF.layer.borderColor=YiBlue.CGColor;
    usernameTF.placeholder=@"Username or email";
    pwdTF=[[UITextField alloc] initWithFrame:CGRectMake((ScreenWidth-300)/2, 200, 300, 40)];
    [self.view addSubview:pwdTF];
    pwdTF.layer.borderWidth=0.4;
    pwdTF.textAlignment=NSTextAlignmentCenter;
    pwdTF.placeholder=@"password";
    pwdTF.layer.borderColor=YiBlue.CGColor;
    pwdTF.backgroundColor=[UIColor whiteColor];
    pwdTF.secureTextEntry = YES;
    
    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:but];
    but.frame=CGRectMake((ScreenWidth-200)/2, 250, 200, 40);
    [but setBackgroundColor:YiBlue];
    but.titleLabel.tintColor=[UIColor whiteColor];
    [but setTitle:@"Sign in" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(loginBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
}
#pragma mark - Actions
- (void)tapAction{
    if ([usernameTF isFirstResponder]) {
        [usernameTF resignFirstResponder];
    }else if ([pwdTF isFirstResponder]){
        [pwdTF resignFirstResponder];
    }
}
- (void)loginBtAction{
    if (usernameTF.text.length<1 || !usernameTF.text) {
        return;
    }
    
    if (pwdTF.text.length<1 || !pwdTF.text) {
        return;
    }
    NSString *coderyiClientID=CoderyiClientID;
    NSString *encryptedData = [AESCrypt encrypt:coderyiClientID password:@"xxxsd-sdsd*sd672323q___---_w.."];
    NSString *coderyiClientSecret=CoderyiClientSecret;
    NSString *message = [AESCrypt encrypt:coderyiClientSecret password:@"xx3xc45sqvzupb4xsd-sdsd*sd672323q___---_w.."];

    
    
//    
//    [OCTClient setClientID:[[AESCrypt decrypt:CoderyiClientID password:@"xxxsd-sdsd*sd672323q___---_w.."] substringFromIndex:1] clientSecret:[[AESCrypt decrypt:CoderyiClientSecret password:@"xx3xc45sqvzupb4xsd-sdsd*sd672323q___---_w.."] substringFromIndex:1]];
//
//    OCTUser *user = [OCTUser userWithRawLogin:usernameTF.text server:OCTServer.dotComServer];
//    [self showYiProgressHUD:@"logining"];
//    [[OCTClient signInAsUser:user password:pwdTF.text oneTimePassword:nil scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository note:nil noteURL:nil fingerprint:nil]
//     subscribeNext:^(OCTClient *authenticatedClient) {
//         // Authentication was successful. Do something with the created client.
//         [[NSUserDefaults standardUserDefaults] setObject:authenticatedClient.token forKey:@"access_token"];
//         
//         [[NSUserDefaults standardUserDefaults] setObject:authenticatedClient.user.login forKey:@"currentLogin"];
//         [[NSUserDefaults standardUserDefaults] setObject:[authenticatedClient.user.avatarURL absoluteString] forKey:@"currentAvatarUrl"];
//         
//         dispatch_async(dispatch_get_main_queue(), ^{
//             [self hideYiProgressHUD];
//             if (_callback) {
//                 _callback(@"yes");
//                 _callback = nil;
//                 [self.navigationController popViewControllerAnimated:YES];
//                 
//             }
//
//         });
//
//     } error:^(NSError *error) {
//         // Authentication failed.
//         dispatch_async(dispatch_get_main_queue(), ^{
//             [self hideYiProgressHUD];
//             double delayInSeconds = 0.6;
//             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                 // code to be executed on the main queue after delay
//                 [self showYiProgressHUD:@"login error" afterDelay:1.5];
//
//             });
//         
//         });
//
//     
//     }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
