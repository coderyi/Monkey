//
//  SearchViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/4/4.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchSegmentControl.h"
#import "UserModel.h"
#import "RepositoryModel.h"
#import "UserDetailViewController.h"
#import "RepositoryDetailViewController.h"
#import "SearchViewModel.h"
#import "SearchDataSource.h"
@interface SearchViewController ()<UITableViewDelegate,UISearchBarDelegate> {
    int currentIndex;
    YiRefreshHeader *refreshHeader1;
    YiRefreshFooter *refreshFooter1;
    
    YiRefreshHeader *refreshHeader2;
    YiRefreshFooter *refreshFooter2;
    UISearchBar *mySearchBar;
    SearchSegmentControl *searchSegment;
    UILabel *titleText;
    SearchViewModel *searchViewModel;
    SearchDataSource *searchDataSourcel;
}
@property (strong, nonatomic) MKNetworkOperation *apiOperation;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong)UITableView *tableView1;
@property(nonatomic,strong)UITableView *tableView2;

@end

@implementation SearchViewController
@synthesize tableView1,tableView2;

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.DsOfPageListObject1 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject2 = [[DataSourceModel alloc]init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar addSubview:mySearchBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [mySearchBar removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    searchViewModel=[[SearchViewModel alloc] init];
    searchDataSourcel=[[SearchDataSource alloc] init];

    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((ScreenWidth-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    titleText.text=@"Search";
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    searchSegment=[[SearchSegmentControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [self.view addSubview:searchSegment];
    currentIndex=1;
    
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, ScreenHeight-64-30) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    tableView1.dataSource=searchDataSourcel;
    tableView1.delegate=self;
    [self addHeader:1];
    [self addFooter:1];
    tableView1.tag=11;
    @weakify(self);
    __weak SearchDataSource * weakSearchDataSourcel = searchDataSourcel;
    searchSegment.ButtonActionBlock=^(int buttonTag){
        currentIndex=buttonTag-100;
        @strongify(self);
        __strong SearchDataSource * strongSearchDataSourcel = weakSearchDataSourcel;
        if (currentIndex==1) {
            self.tableView1.hidden=NO;
            self.tableView2.hidden=YES;
        }else if (currentIndex==2){
            if (tableView2==nil) {
                tableView2=[[UITableView alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, ScreenHeight-64-30) style:UITableViewStylePlain];
                [self.view addSubview:self.tableView2];
                self.tableView2.tag=12;
                self.tableView2.dataSource=strongSearchDataSourcel;
                self.tableView2.delegate=self;
                [self addHeader:2];
                [self addFooter:2];
            }
            self.tableView1.hidden=YES;
            self.tableView2.hidden=NO;
        }
     };
    self.navigationItem.hidesBackButton =YES;
    mySearchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(10, 2, ScreenWidth-80, 40)];
    [self.navigationController.navigationBar addSubview:mySearchBar];
    mySearchBar.delegate=self;
    mySearchBar.tintColor=YiBlue;
    [mySearchBar becomeFirstResponder];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel", @"") style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem=right;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)rightAction
{
    [mySearchBar removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private

- (void)addHeader:(int)type
{
    WEAKSELF
    if (type==1) {
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader1=[[YiRefreshHeader alloc] init];
        refreshHeader1.scrollView=tableView1;
        [refreshHeader1 header];
        refreshHeader1.beginRefreshingBlock=^(){
            STRONGSELF
            [strongSelf loadDataFromApiWithIsFirst:YES];
        };
    }else if (type==2){
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader2=[[YiRefreshHeader alloc] init];
        refreshHeader2.scrollView=tableView2;
        [refreshHeader2 header];
        
        refreshHeader2.beginRefreshingBlock=^(){
            STRONGSELF
            [strongSelf loadDataFromApiWithIsFirst:YES];
        };
    }
}

- (void)addFooter:(int)type
{
    WEAKSELF
    if (type==1) {
        //    YiRefreshFooter  底部刷新按钮的使用
        refreshFooter1=[[YiRefreshFooter alloc] init];
        refreshFooter1.scrollView=tableView1;
        [refreshFooter1 footer];
        refreshFooter1.beginRefreshingBlock=^(){
            STRONGSELF
            [strongSelf loadDataFromApiWithIsFirst:NO];
        };}else if (type==2){
            //    YiRefreshFooter  底部刷新按钮的使用
            refreshFooter2=[[YiRefreshFooter alloc] init];
            refreshFooter2.scrollView=tableView2;
            [refreshFooter2 footer];
            refreshFooter2.beginRefreshingBlock=^(){
                STRONGSELF
                [strongSelf loadDataFromApiWithIsFirst:NO];
            };
    }
}

- (void)loadDataFromApiWithIsFirst:(BOOL)isFirst
{
  
    [searchViewModel loadDataFromApiWithIsFirst:isFirst currentIndex:currentIndex searchBarText:mySearchBar.text firstTableData:^(DataSourceModel* DsOfPageListObject){
        searchDataSourcel.DsOfPageListObject1=DsOfPageListObject;
                        [tableView1 reloadData];
                        if (!isFirst) {
                            [refreshFooter1 endRefreshing];
                        }else {
                            [refreshHeader1 endRefreshing];
                        }
    } secondTableData:^(DataSourceModel* DsOfPageListObject){
        searchDataSourcel.DsOfPageListObject2=DsOfPageListObject;
        [tableView2 reloadData];
        if (!isFirst) {
            [refreshFooter2 endRefreshing];
        }else {
            [refreshHeader2 endRefreshing];
        }
    } ];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self loadDataFromApiWithIsFirst:YES];
    [mySearchBar endEditing:YES];
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==11) {
        UserDetailViewController *detail=[[UserDetailViewController alloc] init];
        UserModel  *model = [(searchDataSourcel.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        detail.userModel=model;
        [self.navigationController pushViewController:detail animated:YES];
    }else  if (tableView.tag==12) {
        RepositoryDetailViewController *detail=[[RepositoryDetailViewController alloc] init];
        RepositoryModel  *model = [(searchDataSourcel.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        detail.model=model;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
