//
//  LanguageRankViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "TrendingViewController.h"
#import "UserModel.h"
#import "HeaderSegmentControl.h"
#import "CityViewController.h"
#import "LanguageViewController.h"
#import "UserDetailViewController.h"
#import "CountryViewController.h"
#import "RepositoriesTableViewCell.h"
#import "TrendingDataSource.h"
#import "TrendingViewModel.h"
#import "RepositoryDetailViewController.h"

@interface TrendingViewController ()<UITableViewDelegate> {
    UIScrollView *scrollView;
    int currentIndex;
    UITableView *tableView1;
    UITableView *tableView2;
    UITableView *tableView3;
    
    float titleHeight;
    float bgViewHeight;
    HeaderSegmentControl *segmentControl;
    YiRefreshHeader *refreshHeader1;
    YiRefreshFooter *refreshFooter1;
    
    YiRefreshHeader *refreshHeader2;
    YiRefreshFooter *refreshFooter2;
    
    YiRefreshHeader *refreshHeader3;
    YiRefreshFooter *refreshFooter3;
    
    NSString *language;

    NSString *tableView1Language;
    NSString *tableView2Language;
    NSString *tableView3Language;
    UILabel *titleText;
    TrendingDataSource *trendingDataSource;
    TrendingViewModel *trendingViewModel;
}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;
@end

@implementation TrendingViewController

#pragma mark - Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.DsOfPageListObject1 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject2 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject3 = [[DataSourceModel alloc]init];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    NSString *languageAppear=[[NSUserDefaults standardUserDefaults] objectForKey:@"trendingLanguageAppear"];
    if ([languageAppear isEqualToString:@"2"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"trendingLanguageAppear"];
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language2"];
        if (language==nil || language.length<1) {
            language=NSLocalizedString(@"all languages", @"");
        }
        if (currentIndex==1) {
            [refreshHeader1 beginRefreshing];
        }else if (currentIndex==2){
            [refreshHeader2 beginRefreshing];
        }else if (currentIndex==3){
            [refreshHeader3 beginRefreshing];
        }
        if ([language isEqualToString:@"cpp"]) {
            titleText.text=@"c++";
        }else{
            titleText.text=language;
        }
    }
    [scrollView setContentSize:CGSizeMake(ScreenWidth * (3), bgViewHeight)];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    trendingViewModel=[[TrendingViewModel alloc] init];
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((ScreenWidth-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    
    language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language2"];
    if (language==nil || language.length<1) {
        language=NSLocalizedString(@"all languages", @"");
    }
    tableView1Language=language;
    tableView2Language=language;
    tableView3Language=language;
    
    if ([language isEqualToString:@"cpp"]) {
        titleText.text=@"c++";
    }else{
        titleText.text=language;
    }
    self.view.backgroundColor=[UIColor whiteColor];
    titleHeight=35;
    bgViewHeight=ScreenHeight-64-titleHeight;
    [self initScroll];
    self.automaticallyAdjustsScrollViewInsets=NO;

    segmentControl=[[HeaderSegmentControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, titleHeight)];
    [self.view addSubview:segmentControl];
    [segmentControl.button1 setTitle:@"daily" forState:UIControlStateNormal];
    [segmentControl.button2 setTitle:@"weekly" forState:UIControlStateNormal];
    [segmentControl.button3 setTitle:@"monthly" forState:UIControlStateNormal];

    segmentControl.buttonCount=3;
    segmentControl.button3.hidden=NO;
    segmentControl.button4.hidden=YES;
   
    currentIndex=1;
    
    [self initTable];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"language", @"") style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
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
    LanguageViewController *viewController=[[LanguageViewController alloc] init];
    viewController.languageEntranceType=TrendingLanguageEntranceType;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Private

- (void)initScroll
{
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleHeight, ScreenWidth, bgViewHeight)];
    scrollView.alwaysBounceHorizontal=YES;
    scrollView.backgroundColor=[UIColor whiteColor];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(ScreenWidth * (3), bgViewHeight)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [scrollView scrollRectToVisible:CGRectMake(0,0,ScreenWidth,bgViewHeight) animated:NO];
    [scrollView setContentSize:CGSizeMake(ScreenWidth * (3), bgViewHeight)];
 
}

- (void)initTable
{
    
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
    [scrollView addSubview:tableView1];
    trendingDataSource=[[TrendingDataSource alloc] init];
    tableView1.dataSource=trendingDataSource;
    tableView1.delegate=self;
    tableView1.tag=11;
    tableView1.rowHeight=RepositoriesTableViewCellheight;
    tableView1.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader:1];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"

    segmentControl.ButtonActionBlock=^(int buttonTag){
        currentIndex=buttonTag-100;
        [scrollView scrollRectToVisible:CGRectMake(ScreenWidth * (currentIndex-1),0,ScreenWidth,bgViewHeight) animated:NO];
        [scrollView setContentOffset:CGPointMake(ScreenWidth* (currentIndex-1),0)];
        if (currentIndex==1) {
            if (![titleText.text isEqualToString:tableView1Language]) {
                [refreshHeader1 beginRefreshing];
            }
        }else if (currentIndex==2){
            if (tableView2==nil) {
                tableView2=[[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
                [scrollView addSubview:tableView2];
                tableView2.showsVerticalScrollIndicator = NO;
                tableView2.tag=12;
                tableView2.dataSource=trendingDataSource;
                tableView2.delegate=self;
                tableView2.separatorStyle=UITableViewCellSeparatorStyleNone;
                tableView2.rowHeight=RepositoriesTableViewCellheight;
                [self addHeader:2];
            }
            if (![titleText.text isEqualToString:tableView2Language]) {
                [refreshHeader2 beginRefreshing];
            }
            
        }else if (currentIndex==3){
            if (tableView3==nil) {
                tableView3=[[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
                [scrollView addSubview:tableView3];
                tableView3.showsVerticalScrollIndicator = NO;
                tableView3.tag=13;
                tableView3.dataSource=trendingDataSource;
                tableView3.delegate=self;
                tableView3.separatorStyle=UITableViewCellSeparatorStyleNone;
                tableView3.rowHeight=RepositoriesTableViewCellheight;
                [self addHeader:3];
            }
            if (![titleText.text isEqualToString:tableView3Language]) {
                [refreshHeader3 beginRefreshing];
            }
        }
    };
#pragma clang diagnostic pop

    currentIndex=1;
    
}

- (void)addHeader:(int)type
{
    if (type==1) {
        
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader1=[[YiRefreshHeader alloc] init];
        refreshHeader1.scrollView=tableView1;
        [refreshHeader1 header];
        __weak typeof(self) weakSelf = self;
        refreshHeader1.beginRefreshingBlock=^(){
            [weakSelf loadDataFromApiWithIsFirst:YES];
            
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader1 beginRefreshing];
    }else if (type==2) {
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader2=[[YiRefreshHeader alloc] init];
        refreshHeader2.scrollView=tableView2;
        [refreshHeader2 header];
        __weak typeof(self) weakSelf = self;
        refreshHeader2.beginRefreshingBlock=^(){
            [weakSelf loadDataFromApiWithIsFirst:YES];
            
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader2 beginRefreshing];
        
    }else if (type==3) {
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader3=[[YiRefreshHeader alloc] init];
        refreshHeader3.scrollView=tableView3;
        [refreshHeader3 header];
        __weak typeof(self) weakSelf = self;
        refreshHeader3.beginRefreshingBlock=^(){
            [weakSelf loadDataFromApiWithIsFirst:YES];
            
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader3 beginRefreshing];
        
    }
}

- (void)loadDataFromApiWithIsFirst:(BOOL)isFirst
{
    if (currentIndex==1) {
        tableView1Language=language;
    }else if (currentIndex==2) {
        tableView2Language=language;
    }else if (currentIndex==3) {
        tableView3Language=language;
    }
    [trendingViewModel loadDataFromApiWithIsFirst:isFirst currentIndex:currentIndex firstTableData:^(DataSourceModel* DsOfPageListObject){
        trendingDataSource.DsOfPageListObject1=DsOfPageListObject;
        [tableView1 reloadData];
        if (!isFirst) {
            [refreshFooter1 endRefreshing];
        }else
        {
            [refreshHeader1 endRefreshing];
        }
    } secondTableData:^(DataSourceModel* DsOfPageListObject){
        trendingDataSource.DsOfPageListObject2=DsOfPageListObject;
        [tableView2 reloadData];
        if (!isFirst) {
            [refreshFooter2 endRefreshing];
        }else
        {
            [refreshHeader2 endRefreshing];
        }
    } thirdTableData:^(DataSourceModel* DsOfPageListObject){
        trendingDataSource.DsOfPageListObject3=DsOfPageListObject;
        [tableView3 reloadData];
        if (!isFirst) {
            [refreshFooter3 endRefreshing];
        }else
        {
            [refreshHeader3 endRefreshing];
        }
    }];

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)tempScrollView
{
    if (segmentControl.buttonCount==2) {
        
        CGFloat pagewidth = scrollView.frame.size.width;
        int currentPage = floor((scrollView.contentOffset.x - pagewidth/ (2)) / pagewidth) + 1;
        if (currentPage==0)
        {
            [scrollView scrollRectToVisible:CGRectMake(0,0,ScreenWidth,bgViewHeight) animated:NO];
            [scrollView setContentOffset:CGPointMake(0,0)];
        }
        else if (currentPage>=(1))
        {
            currentPage=1;
            [scrollView scrollRectToVisible:CGRectMake(ScreenWidth * 1,0,ScreenWidth,bgViewHeight) animated:NO];
            [scrollView setContentOffset:CGPointMake(ScreenWidth* 1,0)];
        }
        
        currentIndex=currentPage+1;
        [segmentControl swipeAction:(100+currentPage+1)];
    }else if (segmentControl.buttonCount==3){
        
        CGFloat pagewidth = scrollView.frame.size.width;
        int currentPage = floor((scrollView.contentOffset.x - pagewidth/ (3)) / pagewidth) + 1;
        if (currentPage==0)
        {
            [scrollView scrollRectToVisible:CGRectMake(0,0,ScreenWidth,bgViewHeight) animated:NO];
            [scrollView setContentOffset:CGPointMake(0,0)];
        }
        else if (currentPage>=(2))
        {
            currentPage=2;
            [scrollView scrollRectToVisible:CGRectMake(ScreenWidth * 2,0,ScreenWidth,bgViewHeight) animated:NO];
            [scrollView setContentOffset:CGPointMake(ScreenWidth* 2,0)];
        }
        
        currentIndex=currentPage+1;
        [segmentControl swipeAction:(100+currentPage+1)];
    }
    
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepositoryDetailViewController *detail=[[RepositoryDetailViewController alloc] init];
    if (currentIndex==1) {
        RepositoryModel  *model = [(trendingDataSource.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        detail.model=model;
    }else  if (currentIndex==2) {
        RepositoryModel  *model = [(trendingDataSource.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        detail.model=model;
    }else if (currentIndex==3){
        RepositoryModel  *model = [(trendingDataSource.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        detail.model=model;
    }
    [self.navigationController pushViewController:detail animated:YES];
}

@end
