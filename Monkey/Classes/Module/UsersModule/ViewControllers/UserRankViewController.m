//
//  LanguageRankViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserRankViewController.h"
#import "UserModel.h"
#import "RankTableViewCell.h"
#import "HeaderSegmentControl.h"
#import "CityViewController.h"
#import "LanguageViewController.h"
#import "UserDetailViewController.h"
#import "CountryViewController.h"
#import "UserRankDataSource.h"
#import "UserRankViewModel.h"
@interface UserRankViewController ()<UITableViewDelegate>{
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
    UserRankDataSource *userRankDataSource;
    UserRankViewModel *userRankViewModel;
}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;
@end

@implementation UserRankViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

    NSString *cityAppear=[[NSUserDefaults standardUserDefaults] objectForKey:@"cityAppear"];
    if ([cityAppear isEqualToString:@"2"]) {
        currentIndex=1;
        [segmentControl swipeAction:101];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cityAppear"];
        [refreshHeader1 beginRefreshing];
        NSString *city=[[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
        if (city==nil || city.length<1) {
            city=NSLocalizedString(@"beijing", @"");
        }
        [segmentControl.button1 setTitle:city forState:UIControlStateNormal];
        NSString *country=[[NSUserDefaults standardUserDefaults] objectForKey:@"country"];
        if (country==nil || country.length<1) {
            country=@"China";
        }
        [segmentControl.button2 setTitle:country forState:UIControlStateNormal];
    }
    NSString *languageAppear=[[NSUserDefaults standardUserDefaults] objectForKey:@"languageAppear"];
    if ([languageAppear isEqualToString:@"2"]) {
       
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"languageAppear"];
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
        if (language==nil || language.length<1) {
            language=NSLocalizedString(@"all languages", @"");
            
        }
        if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
            segmentControl.buttonCount=2;
            segmentControl.button3.hidden=YES;
        }else{
            segmentControl.buttonCount=3;
            segmentControl.button3.hidden=NO;
        }
        
        if (currentIndex==1) {
            [refreshHeader1 beginRefreshing];
        }else if (currentIndex==2){
            [refreshHeader2 beginRefreshing];
        }else if (currentIndex==3){
            if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
                currentIndex=2;
                [segmentControl swipeAction:102];
                [refreshHeader2 beginRefreshing];
            }else{
                [refreshHeader3 beginRefreshing];
            }
        }
        if ([language isEqualToString:@"CPP"]) {
            titleText.text=@"C++";
        }else{
            titleText.text=language;
        }
    }
    if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
        [scrollView setContentSize:CGSizeMake(ScreenWidth * (2), bgViewHeight)];
    }else{
        [scrollView setContentSize:CGSizeMake(ScreenWidth * (3), bgViewHeight)];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    
    userRankViewModel=[[UserRankViewModel alloc] init];
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((ScreenWidth-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;

    language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    if (language==nil || language.length<1) {
        language=NSLocalizedString(@"all languages", @"");
    }
    tableView1Language=language;
    tableView2Language=language;
    tableView3Language=language;
    if ([language isEqualToString:@"CPP"]) {
        titleText.text=@"C++";
    }else{
        titleText.text=language;
    }
    self.view.backgroundColor=[UIColor whiteColor];
    titleHeight=35;
    bgViewHeight=ScreenHeight-64-titleHeight-49;
    [self initScroll];
    self.automaticallyAdjustsScrollViewInsets=NO;
  
    segmentControl=[[HeaderSegmentControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, titleHeight)];
    [self.view addSubview:segmentControl];
    if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
        segmentControl.buttonCount=2;
        segmentControl.button3.hidden=YES;
    }else{
        segmentControl.buttonCount=3;
        segmentControl.button3.hidden=NO;
    }

    currentIndex=1;
    NSString *city=[[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    if (city==nil || city.length<1) {
        city=NSLocalizedString(@"beijing", @"");
    }
    
    [segmentControl.button1 setTitle:city forState:UIControlStateNormal];
    NSString *country=[[NSUserDefaults standardUserDefaults] objectForKey:@"country"];
    if (country==nil || country.length<1) {
        country=@"China";
    }
    [segmentControl.button2 setTitle:country forState:UIControlStateNormal];
    [self initTable];
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"city", @"") style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem=left;

    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"language", @"") style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem=right;
   
}

#pragma mark - Actions
- (void)leftAction
{
    CountryViewController *viewController=[[CountryViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)rightAction
{
    LanguageViewController *viewController=[[LanguageViewController alloc] init];
    viewController.languageEntranceType=UserLanguageEntranceType;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
        [scrollView setContentSize:CGSizeMake(ScreenWidth * (2), bgViewHeight)];
    }else{
        [scrollView setContentSize:CGSizeMake(ScreenWidth * (3), bgViewHeight)];
    }
}

- (void)initTable
{
    
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
    [scrollView addSubview:tableView1];
    userRankDataSource =[[UserRankDataSource alloc] init];
    tableView1.dataSource=userRankDataSource;
    tableView1.delegate=self;
    tableView1.tag=11;
    tableView1.rowHeight=RankTableViewCellHeight;
    tableView1.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader:1];
    [self addFooter:1];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"

    __weak UIScrollView * weakScrollView=scrollView;
    segmentControl.ButtonActionBlock=^(int buttonTag){
        __strong UIScrollView * strongScrollView=weakScrollView;

        currentIndex=buttonTag-100;
        [strongScrollView scrollRectToVisible:CGRectMake(ScreenWidth * (currentIndex-1),0,ScreenWidth,bgViewHeight) animated:NO];
        [strongScrollView setContentOffset:CGPointMake(ScreenWidth* (currentIndex-1),0)];
        
        if (currentIndex==1) {
            if (![titleText.text isEqualToString:tableView1Language]) {
                [refreshHeader1 beginRefreshing];
            }
            if (self.DsOfPageListObject1.totalCount>0) {
              [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)self.DsOfPageListObject1.totalCount] forState:UIControlStateNormal];
            }
        }else if (currentIndex==2){
            if (tableView2==nil) {
                tableView2=[[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
                [scrollView addSubview:tableView2];
                tableView2.showsVerticalScrollIndicator = NO;
                tableView2.tag=12;
                tableView2.dataSource=userRankDataSource;
                tableView2.delegate=self;
                tableView2.separatorStyle=UITableViewCellSeparatorStyleNone;
                tableView2.rowHeight=RankTableViewCellHeight;
                [self addHeader:2];
                [self addFooter:2];
            }
            if (![titleText.text isEqualToString:tableView2Language]) {
                [refreshHeader2 beginRefreshing];
            }
            
            if (self.DsOfPageListObject2.totalCount>0) {
                [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)self.DsOfPageListObject2.totalCount] forState:UIControlStateNormal];
            }
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countryAppear"] isEqualToString:@"2"]) {
                [refreshHeader2 beginRefreshing];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"countryAppear"];
            }
          
        }else if (currentIndex==3){
            if (tableView3==nil) {
                tableView3=[[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
                [scrollView addSubview:tableView3];
                tableView3.showsVerticalScrollIndicator = NO;
                
                tableView3.tag=13;
                tableView3.dataSource=userRankDataSource;
                tableView3.delegate=self;
                tableView3.separatorStyle=UITableViewCellSeparatorStyleNone;
                tableView3.rowHeight=RankTableViewCellHeight;
                [self addHeader:3];
                [self addFooter:3];

            }
            if (![titleText.text isEqualToString:tableView3Language]) {
                [refreshHeader3 beginRefreshing];
            }
            if (self.DsOfPageListObject3.totalCount>0) {
                [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)(self.DsOfPageListObject3.totalCount)] forState:UIControlStateNormal];
            }
        }else if (currentIndex==4){
            
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
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf loadDataFromApiWithIsFirst:YES];
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader1 beginRefreshing];
    }else if (type==2){
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader2=[[YiRefreshHeader alloc] init];
        refreshHeader2.scrollView=tableView2;
        [refreshHeader2 header];
        @weakify(self);
        refreshHeader2.beginRefreshingBlock=^(){
            @strongify(self);
            [self loadDataFromApiWithIsFirst:YES];
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader2 beginRefreshing];
        
    }else if (type==3){
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader3=[[YiRefreshHeader alloc] init];
        refreshHeader3.scrollView=tableView3;
        [refreshHeader3 header];
        @weakify(self);
        refreshHeader3.beginRefreshingBlock=^(){
            @strongify(self);
            [self loadDataFromApiWithIsFirst:YES];
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader3 beginRefreshing];
        
    }
}

- (void)addFooter:(int)type
{
    @weakify(self);
    if (type==1) {
        @strongify(self);
        //    YiRefreshFooter  底部刷新按钮的使用
        refreshFooter1=[[YiRefreshFooter alloc] init];
        refreshFooter1.scrollView=tableView1;
        [refreshFooter1 footer];
        refreshFooter1.beginRefreshingBlock=^(){
            [self loadDataFromApiWithIsFirst:NO];
        };
    }else if (type==2){
            @strongify(self);
            //    YiRefreshFooter  底部刷新按钮的使用
            refreshFooter2=[[YiRefreshFooter alloc] init];
            refreshFooter2.scrollView=tableView2;
            [refreshFooter2 footer];
            refreshFooter2.beginRefreshingBlock=^(){
                [self loadDataFromApiWithIsFirst:NO];
            };
            
    }else if (type==3){
            @strongify(self);
            //    YiRefreshFooter  底部刷新按钮的使用
            refreshFooter3=[[YiRefreshFooter alloc] init];
            refreshFooter3.scrollView=tableView3;
            [refreshFooter3 footer];
            refreshFooter3.beginRefreshingBlock=^(){
                [self loadDataFromApiWithIsFirst:NO];
            };
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
    
    [userRankViewModel loadDataFromApiWithIsFirst:isFirst currentIndex:currentIndex firstTableData:^(DataSourceModel* DsOfPageListObject){
        userRankDataSource.DsOfPageListObject1=DsOfPageListObject;
        
                    [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)DsOfPageListObject.totalCount] forState:UIControlStateNormal];
                    [tableView1 reloadData];
        
                    if (!isFirst) {
                        [refreshFooter1 endRefreshing];
                    }else
                    {
                        [refreshHeader1 endRefreshing];
                    }
    } secondTableData:^(DataSourceModel* DsOfPageListObject){
        userRankDataSource.DsOfPageListObject2=DsOfPageListObject;

                    [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)DsOfPageListObject.totalCount] forState:UIControlStateNormal];
                    [tableView2 reloadData];
        
                    if (!isFirst) {
                        [refreshFooter2 endRefreshing];
                    }else
                    {
                        [refreshHeader2 endRefreshing];
                    }
    } thirdTableData:^(DataSourceModel* DsOfPageListObject){
        userRankDataSource.DsOfPageListObject3=DsOfPageListObject;

                    [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)DsOfPageListObject.totalCount] forState:UIControlStateNormal];
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
    
        if (currentPage==0){
        
            [scrollView scrollRectToVisible:CGRectMake(0,0,ScreenWidth,bgViewHeight) animated:NO];
            [scrollView setContentOffset:CGPointMake(0,0)];
        }else if (currentPage>=(1)){
            currentPage=1;
            [scrollView scrollRectToVisible:CGRectMake(ScreenWidth * 1,0,ScreenWidth,bgViewHeight) animated:NO];
            [scrollView setContentOffset:CGPointMake(ScreenWidth* 1,0)];
        }
    
        currentIndex=currentPage+1;
        [segmentControl swipeAction:(100+currentPage+1)];
    }else if (segmentControl.buttonCount==3){
            
            
            CGFloat pagewidth = scrollView.frame.size.width;
            int currentPage = floor((scrollView.contentOffset.x - pagewidth/ (3)) / pagewidth) + 1;
            
            if (currentPage==0){
                
                [scrollView scrollRectToVisible:CGRectMake(0,0,ScreenWidth,bgViewHeight) animated:NO];
                [scrollView setContentOffset:CGPointMake(0,0)];
            }else if (currentPage>=(2)){
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
    UserDetailViewController *detail=[[UserDetailViewController alloc] init];
    if (currentIndex==1) {
        UserModel  *model = [(userRankDataSource.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        detail.userModel=model;
    }else  if (currentIndex==2) {
        UserModel  *model = [(userRankDataSource.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        detail.userModel=model;
    }else if (currentIndex==3){
        UserModel  *model = [(userRankDataSource.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        detail.userModel=model;
    }
    [self.navigationController pushViewController:detail animated:YES];
}

@end
