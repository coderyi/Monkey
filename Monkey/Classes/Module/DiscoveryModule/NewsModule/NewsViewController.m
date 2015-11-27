//
//  NewsViewController.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "NewsViewController.h"
#import "RepositoryDetailViewController.h"
#import "UserReceivedEventModel.h"
@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *tableView;
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;
@end

@implementation NewsViewController

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
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=NSLocalizedString(@"News", @"");
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain ];
    [self.view addSubview:tableView];
    tableView.dataSource=self;
    tableView.delegate=self;
 
    [self addHeader];
    [self addFooter];
   
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
    NSInteger page = 0;
    if (isFirst) {
        page = 1;
    }else{
        page = self.DsOfPageListObject.page+1;
    }
    
    [ApplicationDelegate.apiEngine repositoriesTrendingWithPage:page login:_login completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
        
        if (page<=1) {
            [self.DsOfPageListObject.dsArray removeAllObjects];
        }
        
        [self.DsOfPageListObject.dsArray addObjectsFromArray:modelArray];
        self.DsOfPageListObject.page=page;
        [tableView reloadData];

        if (page>1) {
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
    
    NSString *CellId = @"autoCell";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
    }
    UserReceivedEventModel *model=((UserReceivedEventModel *)([self.DsOfPageListObject.dsArray objectAtIndex:indexPath.row]));
    cell.textLabel.text=model.actor.login;
    cell.textLabel.textColor=YiBlue;
    NSString *detailText;
    if ([model.type isEqualToString:@"ForkEvent"]) {
        detailText=[NSString stringWithFormat:@"forked %@ to %@",model.repo.name,model.payload.forkee.full_name];
    }else if ([model.type isEqualToString:@"WatchEvent"]) {
        detailText=[NSString stringWithFormat:@"%@ %@",model.payload.action,model.repo.name];
    }else if ([model.type isEqualToString:@"CreateEvent"]) {
        detailText=[NSString stringWithFormat:@"created repository %@",model.repo.name];
    }
    cell.detailTextLabel.text=detailText;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserReceivedEventModel *model=((UserReceivedEventModel *)([self.DsOfPageListObject.dsArray objectAtIndex:indexPath.row]));
    
    RepositoryDetailViewController *viewController=[[RepositoryDetailViewController alloc] init];
    RepositoryModel *model1=[[RepositoryModel alloc] init];
    model1.user=[[UserModel alloc] init];

    NSRange range = [model.repo.name rangeOfString:@"/"]; //现获取要截取的字符串位置
    NSString * result = [model.repo.name substringFromIndex:(range.location+1)]; //截取字符串
    model1.user.login=[model.repo.name substringToIndex:(range.location)];
    model1.name=result;
    viewController.model=model1;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

@end
