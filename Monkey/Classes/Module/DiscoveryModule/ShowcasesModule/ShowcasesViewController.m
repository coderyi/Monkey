//
//  ShowcasesViewController.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//
#import "ShowcasesTableViewCell.h"

#import "ShowcasesViewController.h"
#import "ShowcasesModel.h"
#import "ShowcasesDetailViewController.h"
@interface ShowcasesViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *tableView;
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;
@end

@implementation ShowcasesViewController

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
    self.title=@"Showcases";
    self.automaticallyAdjustsScrollViewInsets=NO;
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain ];
    [self.view addSubview:tableView];
    tableView.dataSource=self;
    tableView.delegate=self;
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
    
    [networkEngine showcasesWithCompletoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowcasesTableViewCell *cell  = [[ShowcasesTableViewCell alloc] init];
    ShowcasesModel *model=((ShowcasesModel *)([self.DsOfPageListObject.dsArray objectAtIndex:indexPath.row]));
    //calculate
    CGFloat height = [cell calulateHeightWithtTitle:model.name desrip:model.showcasesDescription];
    return height;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DsOfPageListObject.dsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellId = @"autoCell";
    ShowcasesTableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[ShowcasesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
        cell.detailTextLabel.textColor=[UIColor grayColor];
    }
    ShowcasesModel *model=((ShowcasesModel *)([self.DsOfPageListObject.dsArray objectAtIndex:indexPath.row]));

    [cell.titleLabel setText:nil];
    [cell.titleLabel setText:model.name];
    //补上的几句，给用来显示的DetailLabel 设置最大布局宽度
    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-108;
    [cell.descriptionLabel setPreferredMaxLayoutWidth:preMaxWaith];
    [cell.descriptionLabel layoutIfNeeded];
    [cell.descriptionLabel setText:nil];
    [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    [cell.descriptionLabel setText:model.showcasesDescription];
    return cell;
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowcasesDetailViewController *detail=[[ShowcasesDetailViewController alloc] init];
    ShowcasesModel  *model = [(self.DsOfPageListObject.dsArray) objectAtIndex:indexPath.row];
    detail.model=model;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
