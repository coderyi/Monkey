//
//  LanguageViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "LanguageViewController.h"

@interface LanguageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView1;
    NSArray *languages;
}

@end

@implementation LanguageViewController

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
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen-64) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    //    tableView1.showsVerticalScrollIndicator = NO;
    
    tableView1.dataSource=self;
    tableView1.delegate=self;
    
    //    tableView1.separatorStyle=UITableViewCellSeparatorStyleNone;
    //    citys=@[@"beijing",@"shanghai",@"guangzhou",@"shenzhen",@"chengdu",@"hangzhou",@"nanjing",@"wuhan武汉",@"suzhou苏州"];
    
    if (_isRepositories) {
        languages=@[@"JavaScript",@"Java",@"PHP",@"Ruby",@"Python",@"CSS",@"C",@"Objective-C",@"Shell",@"R",@"Perl",@"Lua",@"HTML",@"Scala",@"Go"];
    }else{
    languages=@[@"所有语言",@"JavaScript",@"Java",@"PHP",@"Ruby",@"Python",@"CSS",@"C",@"Objective-C",@"Shell",@"R",@"Perl",@"Lua",@"HTML",@"Scala",@"Go"];
    
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return languages.count;
    
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    NSString *cellId=@"CellId1";
    cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        //            cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text=(languages)[indexPath.row];
    return cell;
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isRepositories) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"languageAppear1"];
        
        [[NSUserDefaults standardUserDefaults] setObject:languages[indexPath.row] forKey:@"language1"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"languageAppear"];
        
        [[NSUserDefaults standardUserDefaults] setObject:languages[indexPath.row] forKey:@"language"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
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
