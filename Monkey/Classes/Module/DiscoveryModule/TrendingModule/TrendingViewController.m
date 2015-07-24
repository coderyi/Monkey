//
//  LanguageRankViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "TrendingViewController.h"
#import "UserModel.h"
//#import "RankTableViewCell.h"
#import "HeaderSegmentControl.h"
#import "CityViewController.h"
#import "LanguageViewController.h"
#import "UserDetailViewController.h"
#import "CountryViewController.h"
#import "RepositoriesTableViewCell.h"
@interface TrendingViewController ()<UITableViewDataSource,UITableViewDelegate>{
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
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
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
        
        titleText.text=language;
    }
    
        [scrollView setContentSize:CGSizeMake(ScreenWidth * (3), bgViewHeight)];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    
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
    
    
    titleText.text=language;
    self.view.backgroundColor=[UIColor whiteColor];
    titleHeight=35;
    bgViewHeight=ScreenHeight-64-titleHeight;
    [self initScroll];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, bgViewHeight) style:UITableViewStylePlain ];
    //    [scrollView addSubview:tableView1];
    //
    //    tableView1.delegate=self;
    //    tableView1.dataSource=self;
    
    
    
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
#pragma mark - Actions



- (void)rightAction{
    LanguageViewController *viewController=[[LanguageViewController alloc] init];
    viewController.languageEntranceType=TrendingLanguageEntranceType;
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)initScroll{
    
    
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
//    if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
//        [scrollView setContentSize:CGSizeMake(ScreenWidth * (2), bgViewHeight)];
//    }else{
        [scrollView setContentSize:CGSizeMake(ScreenWidth * (3), bgViewHeight)];
        
//    }
}

- (void)initTable{
    
    
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
    [scrollView addSubview:tableView1];
    //    tableView1.showsVerticalScrollIndicator = NO;
    
    tableView1.dataSource=self;
    tableView1.delegate=self;
    tableView1.tag=11;
    tableView1.rowHeight=135.7;
    tableView1.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader:1];
    [self addFooter:1];
    
    segmentControl.ButtonActionBlock=^(int buttonTag){
        
        currentIndex=buttonTag-100;
        [scrollView scrollRectToVisible:CGRectMake(ScreenWidth * (currentIndex-1),0,ScreenWidth,bgViewHeight) animated:NO];
        [scrollView setContentOffset:CGPointMake(ScreenWidth* (currentIndex-1),0)];
        
        if (currentIndex==1) {
            if (![titleText.text isEqualToString:tableView1Language]) {
                [refreshHeader1 beginRefreshing];
            }
//            if (self.DsOfPageListObject1.totalCount>0) {
//                
//                
//                [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",self.DsOfPageListObject1.totalCount] forState:UIControlStateNormal];
//            }
        }else if (currentIndex==2){
            if (tableView2==nil) {
                tableView2=[[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
                [scrollView addSubview:tableView2];
                tableView2.showsVerticalScrollIndicator = NO;
                
                tableView2.tag=12;
                tableView2.dataSource=self;
                tableView2.delegate=self;
                tableView2.separatorStyle=UITableViewCellSeparatorStyleNone;
                tableView2.rowHeight=135.7;
                [self addHeader:2];
                [self addFooter:2];
                
            }
            if (![titleText.text isEqualToString:tableView2Language]) {
                [refreshHeader2 beginRefreshing];
            }
            
//            if (self.DsOfPageListObject2.totalCount>0) {
//                [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",self.DsOfPageListObject2.totalCount] forState:UIControlStateNormal];
//            }
//            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countryAppear"] isEqualToString:@"2"]) {
//                [refreshHeader2 beginRefreshing];
//                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"countryAppear"];
//            }
            
        }else if (currentIndex==3){
            if (tableView3==nil) {
                tableView3=[[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
                [scrollView addSubview:tableView3];
                tableView3.showsVerticalScrollIndicator = NO;
                
                tableView3.tag=13;
                tableView3.dataSource=self;
                tableView3.delegate=self;
                tableView3.separatorStyle=UITableViewCellSeparatorStyleNone;
                tableView3.rowHeight=135.7;
                [self addHeader:3];
                [self addFooter:3];
                
            }
            if (![titleText.text isEqualToString:tableView3Language]) {
                [refreshHeader3 beginRefreshing];
            }
            
//            if (self.DsOfPageListObject3.totalCount>0) {
//                [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",self.DsOfPageListObject3.totalCount] forState:UIControlStateNormal];
//            }
        }else if (currentIndex==4){
            
        }
    };
    
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
    }else if (type==2){
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
        
    }else if (type==3){
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

- (void)addFooter:(int)type
{
    __weak typeof(self) weakSelf = self;
    if (type==1) {
        
        
        //    YiRefreshFooter  底部刷新按钮的使用
        refreshFooter1=[[YiRefreshFooter alloc] init];
        refreshFooter1.scrollView=tableView1;
        [refreshFooter1 footer];
        refreshFooter1.beginRefreshingBlock=^(){
            
            [weakSelf loadDataFromApiWithIsFirst:NO];
        };
    }else if (type==2){
        
        //    YiRefreshFooter  底部刷新按钮的使用
        refreshFooter2=[[YiRefreshFooter alloc] init];
        refreshFooter2.scrollView=tableView2;
        [refreshFooter2 footer];
        refreshFooter2.beginRefreshingBlock=^(){
            
            [weakSelf loadDataFromApiWithIsFirst:NO];
        };
        
    }else if (type==3){
        
        //    YiRefreshFooter  底部刷新按钮的使用
        refreshFooter3=[[YiRefreshFooter alloc] init];
        refreshFooter3.scrollView=tableView3;
        [refreshFooter3 footer];
        refreshFooter3.beginRefreshingBlock=^(){
            
            [weakSelf loadDataFromApiWithIsFirst:NO];
        };
        
    }
}


- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst
{
    YiNetworkEngine *networkEngine=[[YiNetworkEngine  alloc] initWithHostName:@"trending.codehub-app.com" customHeaderFields:nil];
     if (currentIndex==1){
        
        NSInteger page = 0;
        
        if (isFirst) {
            page = 1;
            
        }else{
            
            page = self.DsOfPageListObject1.page+1;
        }
                      language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language2"];
        
                if (language==nil || language.length<1) {
                    language=NSLocalizedString(@"all languages", @"");
        
                }
                tableView1Language=language;
        
         
        
        [networkEngine repositoriesTrendingWithType:@"daily" language:language completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
//            [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)totalCount] forState:UIControlStateNormal];
            self.DsOfPageListObject1.totalCount=totalCount;
            
            if (page<=1) {
                [self.DsOfPageListObject1.dsArray removeAllObjects];
            }
            
            
            //        [self hideHUD];
            
            [self.DsOfPageListObject1.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject1.page=page;
            [tableView1 reloadData];

            if (!isFirst) {
                
                [refreshFooter1 endRefreshing];
                
                
            }else
            {
                [refreshHeader1 endRefreshing];
            }
            
        }
                                        errorHandel:^(NSError* error){
                                            if (isFirst) {
                                                
                                                [refreshHeader1 endRefreshing];
                                                
                                                
                                                
                                                
                                            }else{
                                                [refreshFooter1 endRefreshing];
                                                
                                            }
                                            
                                        }];
        
        
        
        
        
        
        return YES;
        
    }else if (currentIndex==2) {
        
        NSInteger page = 0;
        
        if (isFirst) {
            page = 1;
            
        }else{
            
            page = self.DsOfPageListObject2.page+1;
        }
//        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
//       
//        NSString *q=[NSString stringWithFormat:@"language:%@",language];
//        
//        if (language==nil || language.length<1) {
//            language=@"所有语言";
//            
//        }
//        tableView2Language=language;
//        
//        if ([language isEqualToString:@"所有语言"]) {
//            q=[NSString stringWithFormat:@"location:%@",country];
//        }
//        
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language2"];
        
        if (language==nil || language.length<1) {
            language=NSLocalizedString(@"all languages", @"");
            
        }
        tableView2Language=language;
        
        [networkEngine repositoriesTrendingWithType:@"weekly" language:language completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            self.DsOfPageListObject2.totalCount=totalCount;
//            [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",totalCount] forState:UIControlStateNormal];
            
            if (page<=1) {
                [self.DsOfPageListObject2.dsArray removeAllObjects];
            }
            
            
            //        [self hideHUD];
            
            [self.DsOfPageListObject2.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject2.page=page;
            [tableView2 reloadData];
            
            if (!isFirst) {
                
                [refreshFooter2 endRefreshing];
                
                
            }else
            {
                [refreshHeader2 endRefreshing];
            }
            
        }
                                        errorHandel:^(NSError* error){
                                            if (isFirst) {
                                                
                                                [refreshHeader2 endRefreshing];
                                                
                                                
                                                
                                                
                                            }else{
                                                [refreshFooter2 endRefreshing];
                                                
                                            }
                                            
                                        }];
        
        
        
        
        return YES;
    }else if (currentIndex==3){
        
        NSInteger page = 0;
        
        if (isFirst) {
            page = 1;
            
        }else{
            
            page = self.DsOfPageListObject3.page+1;
        }
//        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
//        if (language==nil || language.length<1) {
//            language=@"所有语言";
//            
//        }
        
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language2"];
        
        if (language==nil || language.length<1) {
            language=NSLocalizedString(@"all languages", @"");
            
        }
        
        tableView3Language=language;
        
        
        [networkEngine repositoriesTrendingWithType:@"monthly" language:language completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
//            [segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",totalCount] forState:UIControlStateNormal];
            self.DsOfPageListObject3.totalCount=totalCount;
            
            if (page<=1) {
                [self.DsOfPageListObject3.dsArray removeAllObjects];
            }
            
            
            //        [self hideHUD];
            
            [self.DsOfPageListObject3.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject3.page=page;
            [tableView3 reloadData];
            
            if (!isFirst) {
                
                [refreshFooter3 endRefreshing];
                
                
            }else
            {
                [refreshHeader3 endRefreshing];
            }
            
        }
                                               errorHandel:^(NSError* error){
                                                   if (isFirst) {
                                                       
                                                       [refreshHeader3 endRefreshing];
                                                       
                                                       
                                                       
                                                       
                                                   }else{
                                                       [refreshFooter3 endRefreshing];
                                                       
                                                   }
                                                   
                                               }];
        
        
        
        
        return YES;
        
    }
    return YES;
    
}






#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
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
        NSLog(@"cccc %d",currentIndex);
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
        NSLog(@"cccc %d",currentIndex);
        [segmentControl swipeAction:(100+currentPage+1)];
    }
    
}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==11) {
        
        
        return self.DsOfPageListObject1.dsArray.count;
        
    }else if (tableView.tag==12){
        
        
        return self.DsOfPageListObject2.dsArray.count;
    }else if (tableView.tag==13){
        
        
        return self.DsOfPageListObject3.dsArray.count;
    }
    
    return self.DsOfPageListObject1.dsArray.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoriesTableViewCell *cell;
    if (tableView.tag==11) {
       
        
        NSString *cellId=@"CellId1";
        cell=[tableView1 dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        RepositoryModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
        cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url] placeholderImage:nil];
        cell.descriptionLabel.text=[NSString stringWithFormat:@"%@",model.repositoryDescription];
        
        [cell.homePageBt setTitle:model.homepage forState:UIControlStateNormal];
        if (model.homepage.length<1) {
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 85, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 85, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }else{
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 105, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 105, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }
        cell.starLabel.text=[NSString stringWithFormat:@"Star:%d",model.stargazers_count];
        cell.forkLabel.text=[NSString stringWithFormat:@"Fork:%d",model.forks_count];
        return cell;

        
        
    }else if (tableView.tag==12){
        
        
        NSString *cellId=@"CellId2";
        cell=[tableView2 dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        RepositoryModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
        cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url] placeholderImage:nil];
        cell.descriptionLabel.text=[NSString stringWithFormat:@"%@",model.repositoryDescription];
        
        [cell.homePageBt setTitle:model.homepage forState:UIControlStateNormal];
        if (model.homepage.length<1) {
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 85, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 85, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }else{
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 105, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 105, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }
        cell.starLabel.text=[NSString stringWithFormat:@"Star:%d",model.stargazers_count];
        cell.forkLabel.text=[NSString stringWithFormat:@"Fork:%d",model.forks_count];
        return cell;
        
    }else if (tableView.tag==13){
        
        NSString *cellId=@"CellId3";
        cell=[tableView3 dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        RepositoryModel  *model = [(self.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
        cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url] placeholderImage:nil];
        cell.descriptionLabel.text=[NSString stringWithFormat:@"%@",model.repositoryDescription];
        
        [cell.homePageBt setTitle:model.homepage forState:UIControlStateNormal];
        if (model.homepage.length<1) {
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 85, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 85, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }else{
            cell.starLabel.frame=CGRectMake(cell.starLabel.frame.origin.x, 105, cell.starLabel.frame.size.width, cell.starLabel.frame.size.height);
            cell.forkLabel.frame=CGRectMake(cell.forkLabel.frame.origin.x, 105, cell.forkLabel.frame.size.width, cell.forkLabel.frame.size.height);
        }
        cell.starLabel.text=[NSString stringWithFormat:@"Star:%d",model.stargazers_count];
        cell.forkLabel.text=[NSString stringWithFormat:@"Fork:%d",model.forks_count];
        return cell;
        
    }
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserDetailViewController *detail=[[UserDetailViewController alloc] init];
    if (currentIndex==1) {
        UserModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        
        detail.userModel=model;
    }else  if (currentIndex==2) {
        UserModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        
        detail.userModel=model;
        
        
    }else if (currentIndex==3){
        UserModel  *model = [(self.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        
        detail.userModel=model;
        
    }
    [self.navigationController pushViewController:detail animated:YES];
    
    
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
