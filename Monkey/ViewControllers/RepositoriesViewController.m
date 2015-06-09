//
//  RepositoriesViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "RepositoriesViewController.h"
#import "UserModel.h"
#import "RankTableViewCell.h"
#import "RepositoryModel.h"
#import "RepositoriesTableViewCell.h"
#import "LanguageViewController.h"
#import "RepositoryDetailViewController.h"
@interface RepositoriesViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView;
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
    NSString *language;
    UILabel *titleText;

}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;

@end

@implementation RepositoriesViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.DsOfPageListObject = [[DataSourceModel alloc]init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
   
    NSString *languageAppear=[[NSUserDefaults standardUserDefaults] objectForKey:@"languageAppear1"];
    if ([languageAppear isEqualToString:@"2"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"languageAppear1"];
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language1"];
        if (language==nil || language.length<1) {
            language=@"JavaScript";
            
        }
    
        
      
            [refreshHeader beginRefreshing];
            
            
        titleText.text=language;
    }
  
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((WScreen-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language1"];
    if (language==nil || language.length<1) {
        language=@"JavaScript";
        
    }
    
    
    
    
    
    titleText.text=language;
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen-64-49) style:UITableViewStylePlain ];
    [self.view addSubview:tableView];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=135.7;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader];
    [self addFooter];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"语言" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem=right;
    
}

-(void)rightAction{
    LanguageViewController *city=[[LanguageViewController alloc] init];
    city.isRepositories=YES;
    [self.navigationController pushViewController:city animated:YES];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DsOfPageListObject.dsArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"CellId";
    RepositoriesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    RepositoryModel  *model = [(self.DsOfPageListObject.dsArray) objectAtIndex:indexPath.row];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoryDetailViewController *detail=[[RepositoryDetailViewController alloc] init];
    RepositoryModel  *model = [(self.DsOfPageListObject.dsArray) objectAtIndex:indexPath.row];

    detail.model=model;
    [self.navigationController pushViewController:detail animated:YES];
    
    
}
- (void)addHeader
{  //    YiRefreshHeader  头部刷新按钮的使用
    refreshHeader=[[YiRefreshHeader alloc] init];
    refreshHeader.scrollView=tableView;
    [refreshHeader header];
    refreshHeader.beginRefreshingBlock=^(){
        [self loadDataFromApiWithIsFirst:YES];
        
        
        
    };
    
    //    是否在进入该界面的时候就开始进入刷新状态
    
    [refreshHeader beginRefreshing];
}

- (void)addFooter
{    //    YiRefreshFooter  底部刷新按钮的使用
    refreshFooter=[[YiRefreshFooter alloc] init];
    refreshFooter.scrollView=tableView;
    [refreshFooter footer];
    refreshFooter.beginRefreshingBlock=^(){
        
        [self loadDataFromApiWithIsFirst:NO];
    };}


- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst
{
    
    
    NSInteger page = 0;
    
    if (isFirst) {
        page = 1;
        
    }else{
        
        page = self.DsOfPageListObject.page+1;
    }
    
    [ApplicationDelegate.apiEngine searchRepositoriesWithPage:page  q:[NSString stringWithFormat:@"language:%@",language] sort:@"stars" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
        
        if (page<=1) {
            [self.DsOfPageListObject.dsArray removeAllObjects];
        }
        
        
        //        [self hideHUD];
        
        [self.DsOfPageListObject.dsArray addObjectsFromArray:modelArray];
        self.DsOfPageListObject.page=page;
        [refreshHeader endRefreshing];
        
        if (page>1) {
            
            [refreshFooter endRefreshing];
            
            
        }else
        {
            [refreshHeader endRefreshing];
        }
        [tableView reloadData];
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
