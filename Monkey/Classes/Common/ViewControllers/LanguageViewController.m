//
//  LanguageViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "LanguageViewController.h"

@interface LanguageViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *tableView1;
    NSArray *languages;
}

@end

@implementation LanguageViewController

#pragma mark - Lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=NSLocalizedString(@"Language", nil);
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    tableView1.dataSource=self;
    tableView1.delegate=self;
  
    if (_languageEntranceType==RepLanguageEntranceType) {
        languages=@[@"JavaScript",@"Java",@"PHP",@"Ruby",@"Python",@"CSS",@"CPP",@"C",@"Objective-C",@"Swift",@"Shell",@"R",@"Perl",@"Lua",@"HTML",@"Scala",@"Go"];
    }else if (_languageEntranceType==UserLanguageEntranceType  ) {
        languages=@[NSLocalizedString(@"all languages", @""),@"JavaScript",@"Java",@"PHP",@"Ruby",@"Python",@"CSS",@"CPP",@"C",@"Objective-C",@"Swift",@"Shell",@"R",@"Perl",@"Lua",@"HTML",@"Scala",@"Go"];
    }else if (_languageEntranceType==TrendingLanguageEntranceType ) {
        languages=@[NSLocalizedString(@"all languages", @""),@"javascript",@"java",@"php",@"ruby",@"python",@"css",@"cpp",@"c",@"objective-c",@"swift",@"shell",@"r",@"perl",@"lua",@"html",@"scala",@"go"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    NSString *cellId=@"CellId1";
    cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSString *languageName=(languages)[indexPath.row];
    if ([languageName isEqualToString:@"cpp"]) {
        languageName=@"c++";
    }else if ([languageName isEqualToString:@"CPP"]){
        languageName=@"C++";
    }
    cell.textLabel.text=languageName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_languageEntranceType==RepLanguageEntranceType) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"languageAppear1"];
        [[NSUserDefaults standardUserDefaults] setObject:languages[indexPath.row] forKey:@"language1"];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_languageEntranceType==UserLanguageEntranceType) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"languageAppear"];
        [[NSUserDefaults standardUserDefaults] setObject:languages[indexPath.row] forKey:@"language"];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_languageEntranceType==TrendingLanguageEntranceType) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"trendingLanguageAppear"];
        [[NSUserDefaults standardUserDefaults] setObject:languages[indexPath.row] forKey:@"language2"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
