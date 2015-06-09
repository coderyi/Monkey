//
//  AboutViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "AboutViewController.h"
#import "UserDetailViewController.h"
@interface AboutViewController (){


    UILabel *titleText;

}

@end

@implementation AboutViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cityAppear"];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((WScreen-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    titleText.text=@"关于";
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    UILabel *creator=[[UILabel alloc] initWithFrame:CGRectMake((WScreen-120)/2, 120, 60, 40)];
    [self.view addSubview:creator];
    creator.textColor=YiTextGray;
    creator.text=@"作者:";
    creator.font=[UIFont systemFontOfSize:14];
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button1];
    button1.frame=CGRectMake((WScreen-120)/2+60, 120, 60, 40);
    [button1 setTitleColor:YiBlue forState:UIControlStateNormal];
    [button1 setTitle:@"coderyi" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(bt1Action) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *edition=[[UILabel alloc] initWithFrame:CGRectMake((WScreen-150)/2, 160, 150, 40)];
    [self.view addSubview:edition];
    edition.textAlignment=NSTextAlignmentCenter;
    edition.textColor=YiTextGray;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    edition.text=[NSString stringWithFormat:@"版本：Monkey%@",version];
    edition.font=[UIFont systemFontOfSize:14];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake((WScreen-300)/2, 210, 300, 60)];
    [self.view addSubview:label];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=YiTextGray;
    label.numberOfLines=0;
    label.text=@"Monkey open source:\nhttps://github.com/coderyi/Monkey";
    label.font=[UIFont systemFontOfSize:14];
    
    
    UILabel *someLabel=[[UILabel alloc] initWithFrame:CGRectMake((WScreen-200)/2, 270, 200, 40)];
    [self.view addSubview:someLabel];
    someLabel.textAlignment=NSTextAlignmentCenter;
    someLabel.textColor=YiTextGray;
    someLabel.text=@"To my old friend,Fengliang";
    someLabel.font=[UIFont systemFontOfSize:14];
    

    
}
-(void)bt1Action{
    UserDetailViewController *detail=[[UserDetailViewController alloc] init];
  
        UserModel  *model = [[UserModel alloc] init];
        
        model.login=@"coderyi";
    detail.userModel=model;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
