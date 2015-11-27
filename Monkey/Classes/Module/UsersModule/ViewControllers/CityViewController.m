//
//  CityViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView1;
    NSArray *citys;
    
}

@end

@implementation CityViewController
@synthesize pinyinCitys;

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
    self.title=NSLocalizedString(@"Select City", nil);

    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    
    tableView1.dataSource=self;
    tableView1.delegate=self;
    
    if (pinyinCitys.count>0) {
    
        if (![pinyinCitys[0] isEqualToString:@"beijing"]) {
            
            citys=pinyinCitys;
        }else{

            citys=@[NSLocalizedString(@"beijing", @""),NSLocalizedString(@"shanghai", @""),NSLocalizedString(@"shenzhen", @""),
                NSLocalizedString(@"hangzhou", @""),NSLocalizedString(@"guangzhou", @""),NSLocalizedString(@"chengdu", @""),
                NSLocalizedString(@"nanjing", @""),NSLocalizedString(@"wuhan", @""),NSLocalizedString(@"suzhou", @""),
                NSLocalizedString(@"xiamen", @""),NSLocalizedString(@"tianjin", @""),NSLocalizedString(@"chongqing", @""),
                NSLocalizedString(@"changsha", @"")];
        }
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        return citys.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell;
    
        NSString *cellId=@"CellId1";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text=(citys)[indexPath.row];
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"cityAppear"];
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"countryAppear"];
    [[NSUserDefaults standardUserDefaults] setObject:pinyinCitys[indexPath.row] forKey:@"pinyinCity"];
    [[NSUserDefaults standardUserDefaults] setObject:citys[indexPath.row] forKey:@"city"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
