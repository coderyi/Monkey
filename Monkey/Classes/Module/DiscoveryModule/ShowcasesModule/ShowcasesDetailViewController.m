//
//  ShowcasesDetailViewController.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "ShowcasesDetailViewController.h"
#import "UserModel.h"
#import "RankTableViewCell.h"
#import "RepositoryModel.h"
#import "RepositoriesTableViewCell.h"
#import "LanguageViewController.h"
#import "RepositoryDetailViewController.h"
@interface ShowcasesDetailViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *tableView;
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
    NSString *language;
    
}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;

@end

@implementation ShowcasesDetailViewController

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.DsOfPageListObject = [[DataSourceModel alloc]init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    self.title=_model.name;
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain ];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=RepositoriesTableViewCellheight;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader];
    [self addFooter];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)addHeader
{  //    YiRefreshHeader  头部刷新按钮的使用
    refreshHeader=[[YiRefreshHeader alloc] init];
    refreshHeader.scrollView=tableView;
    [refreshHeader header];
    WEAKSELF
    refreshHeader.beginRefreshingBlock=^(){
        STRONGSELF
        [strongSelf loadDataFromApiWithIsFirst:YES];
    };
    
    //    是否在进入该界面的时候就开始进入刷新状态
    
    [refreshHeader beginRefreshing];
}

- (void)addFooter
{    //    YiRefreshFooter  底部刷新按钮的使用
    refreshFooter=[[YiRefreshFooter alloc] init];
    refreshFooter.scrollView=tableView;
    [refreshFooter footer];
    WEAKSELF
    refreshFooter.beginRefreshingBlock=^(){
        STRONGSELF
        [strongSelf loadDataFromApiWithIsFirst:NO];
    };
}

- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst
{
    
    YiNetworkEngine *networkEngine=[[YiNetworkEngine  alloc] initWithHostName:@"trending.codehub-app.com" customHeaderFields:nil];
    NSInteger page = 0;
    
    if (isFirst) {
        page = 1;
    }else{
        page = self.DsOfPageListObject.page+1;
    }
    [networkEngine showcasesDetailListWithShowcase:_model.slug completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
        if (page<=1) {
            [self.DsOfPageListObject.dsArray removeAllObjects];
        }
        [self.DsOfPageListObject.dsArray addObjectsFromArray:modelArray];
        self.DsOfPageListObject.page=page;
        [tableView reloadData];
        if (!isFirst) {
            [refreshFooter endRefreshing];
        }else
        {
            [refreshHeader endRefreshing];
        }
    }
                                       errorHandel:^(NSError* error){
                                           if (isFirst) {
                                               [refreshHeader endRefreshing];
                                           }else{
                                               [refreshFooter endRefreshing];
                                           }
                                       }];
    
    return YES;
    
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DsOfPageListObject.dsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId=@"CellId";
    RepositoriesTableViewCell *cell=[tableView1 dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    RepositoryModel  *model = [(self.DsOfPageListObject.dsArray) objectAtIndex:indexPath.row];
    cell.rankLabel.text=[NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
    cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
    cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url]];
    cell.descriptionLabel.text=[NSString stringWithFormat:@"%@",model.repositoryDescription];
    [cell.homePageBt setTitle:model.homepage forState:UIControlStateNormal];
    cell.starLabel.text=[NSString stringWithFormat:@"Star:%d",model.stargazers_count];
    cell.forkLabel.text=[NSString stringWithFormat:@"Fork:%d",model.forks_count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepositoryDetailViewController *detail=[[RepositoryDetailViewController alloc] init];
    RepositoryModel  *model = [(self.DsOfPageListObject.dsArray) objectAtIndex:indexPath.row];
    detail.model=model;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
