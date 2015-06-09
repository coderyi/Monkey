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
    NSArray *pinyinCitys;
}

@end

@implementation CityViewController
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
    citys=@[@"北京",@"上海",@"深圳",@"杭州",@"广州",@"成都",@"南京",@"武汉",@"苏州",@"厦门",@"天津",@"重庆",@"长沙"];
pinyinCitys=@[@"beijing",@"shanghai",@"shenzhen",@"hangzhou",@"guangzhou",@"chengdu",@"nanjing",@"wuhan",@"suzhou",@"xiamen",@"tianjin",@"chongqing",@"changsha"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return citys.count;
   
    
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
    cell.textLabel.text=(citys)[indexPath.row];
        return cell;
        

    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"cityAppear"];

    [[NSUserDefaults standardUserDefaults] setObject:pinyinCitys[indexPath.row] forKey:@"pinyinCity"];
    [[NSUserDefaults standardUserDefaults] setObject:citys[indexPath.row] forKey:@"city"];
    [self.navigationController popViewControllerAnimated:YES];
    

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
