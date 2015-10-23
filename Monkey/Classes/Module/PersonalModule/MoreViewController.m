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
    titleText.text=NSLocalizedString(@"More", nil);
    
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped ];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;

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

    LoginViewController *login=[[LoginViewController alloc] init];
    login.callback=^(NSString *response){
        if ([response isEqualToString:@"yes"]) {
            currentLogin=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
            currentAvatarUrl=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentAvatarUrl"];
            [tableView reloadData];
        }
        
    };
    [self.navigationController pushViewController:login animated:YES];
    
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

    }else if (indexPath.section==2){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

        [self presentModalViewController:[UMFeedback feedbackModalViewController]
                                animated:YES];
#pragma clang diagnostic pop

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


@end
