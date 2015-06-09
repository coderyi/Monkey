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
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    UILabel *titleText;


}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((WScreen-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    titleText.text=@"More";
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen-64) style:UITableViewStyleGrouped ];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
//    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        
        
        UITableViewCell *cell;
        
        NSString *cellId=@"CellId";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    if (indexPath.section==0) {
        cell.textLabel.text=@"搜索";

    }else if (indexPath.section==1){
        cell.textLabel.text=@"关于";

    
    }else if (indexPath.section==2){
        cell.textLabel.text=@"反馈";
        
        
    }
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        SearchViewController *search=[[SearchViewController alloc] init];
        
        [self.navigationController pushViewController:search animated:YES];
    }else if (indexPath.section==1){
        
        AboutViewController *about=[[AboutViewController alloc] init];
        
        [self.navigationController pushViewController:about animated:YES];
        
    }else if (indexPath.section==2){
        [self presentModalViewController:[UMFeedback feedbackModalViewController]
                                animated:YES];
        
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
