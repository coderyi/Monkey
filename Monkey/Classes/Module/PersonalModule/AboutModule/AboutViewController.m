//
//  AboutViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "AboutViewController.h"
#import "UserDetailViewController.h"
#import "RepositoryDetailViewController.h"
#import "WebViewController.h"
@interface AboutViewController () {
    UILabel *titleText;
}

@end

@implementation AboutViewController

#pragma mark - Lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
    self.navigationItem.titleView=titleText;
    titleText.text=NSLocalizedString(@"about", @"");
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UILabel *creator=[[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-120)/2, 80, 60, 40)];
    [self.view addSubview:creator];
    creator.textColor=YiTextGray;
    creator.text=[NSString stringWithFormat:@"%@:",NSLocalizedString(@"Author", @"")];
    creator.font=[UIFont systemFontOfSize:14];
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button1];
    button1.frame=CGRectMake((ScreenWidth-120)/2+60, 80, 70, 40);
    [button1 setTitleColor:YiBlue forState:UIControlStateNormal];
    [button1 setTitle:@"coderyi" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(bt1Action) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *edition=[[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-150)/2, 120, 150, 40)];
    [self.view addSubview:edition];
    edition.textAlignment=NSTextAlignmentCenter;
    edition.textColor=YiTextGray;
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    edition.text=[NSString stringWithFormat:@"%@：Monkey%@",NSLocalizedString(@"Version", @""),version];
    edition.font=[UIFont systemFontOfSize:14];
   
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-300)/2, 160, 300, 30)];
    [self.view addSubview:label];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=YiTextGray;
    label.numberOfLines=0;
    label.text=@"Monkey open source:";
    label.font=[UIFont systemFontOfSize:14];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button2];
    button2.frame=CGRectMake((ScreenWidth-300)/2, 190, 300, 30);
    [button2 setTitleColor:YiBlue forState:UIControlStateNormal];
    [button2 setTitle:@"https://github.com/coderyi/Monkey" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(bt2Action) forControlEvents:UIControlEventTouchUpInside];
    button2.titleLabel.font=[UIFont systemFontOfSize:14];
    
    UIButton *buttonLicense=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonLicense];
    buttonLicense.frame=CGRectMake((ScreenWidth-300)/2, 230, 300, 30);
    [buttonLicense setTitleColor:YiBlue forState:UIControlStateNormal];
    [buttonLicense setTitle:@"open source components" forState:UIControlStateNormal];
    [buttonLicense addTarget:self action:@selector(buttonLicenseAction) forControlEvents:UIControlEventTouchUpInside];
    buttonLicense.titleLabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *someLabel=[[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-200)/2, 270, 200, 40)];
    [self.view addSubview:someLabel];
    someLabel.textAlignment=NSTextAlignmentCenter;
    someLabel.textColor=YiTextGray;
    someLabel.text=@"To my old friend,Fengliang";
    someLabel.font=[UIFont systemFontOfSize:14];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)bt1Action
{
    UserDetailViewController *detail=[[UserDetailViewController alloc] init];
    UserModel  *model = [[UserModel alloc] init];
    model.login=@"coderyi";
    detail.userModel=model;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)bt2Action
{
    RepositoryDetailViewController *detail=[[RepositoryDetailViewController alloc] init];
    
    RepositoryModel  *model = [[RepositoryModel alloc] init];
    UserModel *userModel=[[UserModel alloc] init];
    userModel.login=@"coderyi";
    model.user=userModel;
    model.name=@"Monkey";
    detail.model=model;
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)buttonLicenseAction
{
    WebViewController *web=[[WebViewController alloc] init];
    web.urlString=@"https://github.com/coderyi/Monkey/blob/master/Documents/Monkey_opensource_components.md";
    [self.navigationController pushViewController:web animated:YES];

}

@end
