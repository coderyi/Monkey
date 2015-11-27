//
//  CountryViewController.m
//  Monkey
//
//  Created by coderyi on 15/7/21.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "CountryViewController.h"
#import "CityViewController.h"
@interface CountryViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *tableView1;
    NSArray *countrys;
}

@end

@implementation CountryViewController

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
    self.title=NSLocalizedString(@"Select Country", nil);
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    
    tableView1.dataSource=self;
    tableView1.delegate=self;
    
    countrys=@[@"USA",@"UK",@"Germany",@"China",@"Canada",@"India",@"France",@"Australia",@"Other"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return countrys.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    NSString *cellId=@"CellId1";
    cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text=(countrys)[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row!=countrys.count-1) {
        [[NSUserDefaults standardUserDefaults] setObject:countrys[indexPath.row] forKey:@"country"];

    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"China" forKey:@"country"];

    }

    NSArray *cityArray;
    if (indexPath.row==0) {
        //美国
        cityArray= @[@"San Francisco",@"New York",@"Seattle",@"Chicago",@"Los Angeles",@"Boston",@"Washington",@"San Diego",@"San Jose",@"Philadelphia"];
        
    }else if (indexPath.row==1){
        //        uk
        cityArray= @[@"London",@"Cambridge",@"Manchester",@"Edinburgh",@"Bristol",@"Birmingham",@"Glasgow",@"Oxford",@"Newcastle",@"Leeds"];
    }else if (indexPath.row==2){
        //germany
        cityArray= @[@"Berlin",@"Munich",@"Hamburg",@"Cologne",@"Stuttgart",@"Dresden",@"Leipzig"];
    }else if (indexPath.row==3){
        cityArray= @[@"beijing",@"shanghai",@"shenzhen",@"hangzhou",@"guangzhou",@"chengdu",@"nanjing",@"wuhan",@"suzhou",@"xiamen",@"tianjin",@"chongqing",@"changsha"];
        
    }else if (indexPath.row==4){
        //        canada
        cityArray= @[@"Toronto",@"Vancouver",@"Montreal",@"ottawa",@"Calgary",@"Quebec"];
    }else if (indexPath.row==5){
        //        india
        cityArray= @[@"Chennai",@"Pune",@"Hyderabad",@"Mumbai",@"New Delhi",@"Noida",@"Ahmedabad",@"Gurgaon",@"Kolkata"];
    }else if (indexPath.row==6){
        //        france
        cityArray= @[@"paris",@"Lyon",@"Toulouse",@"Nantes"];
    }else if (indexPath.row==7){
        //        澳大利亚
        cityArray= @[@"sydney",@"Melbourne",@"Brisbane",@"Perth"];
    }else if (indexPath.row==8){
        //        other
        cityArray= @[@"Tokyo",@"Moscow",@"Singapore",@"Seoul"];
    }
    CityViewController *viewController=[[CityViewController alloc] init];
    viewController.pinyinCitys=cityArray;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

@end
