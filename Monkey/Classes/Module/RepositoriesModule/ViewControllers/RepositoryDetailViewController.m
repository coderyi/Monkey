//
//  RepositoryDetailViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/4/3.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "RepositoryDetailViewController.h"
#import "RankTableViewCell.h"
#import "UserModel.h"
#import "DetailSegmentControl.h"
#import "RepositoriesTableViewCell.h"
#import "WebViewController.h"
#import "UserDetailViewController.h"
#import "RepositoryDetailDataSource.h"
#import "RepositoryDetailViewModel.h"
@interface RepositoryDetailViewController ()<UITableViewDelegate> {
    
    UITableView *tableView;
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;

    DetailSegmentControl *segmentControl;
    UIButton *nameBt;
    UIButton *ownerBt;
    UIButton *parentBt;
    UILabel *lineLabel;
    UILabel *forkLabel;
    UILabel *createLabel;
    UIButton *homePageBt;
    UIImageView *ownerIV;
    UILabel *descLabel;
    UIView *titleView;
    BOOL isStaring;
    RepositoryDetailDataSource *repositoryDetailDataSource;
    RepositoryDetailViewModel *repositoryDetailViewModel;
    UILabel *line1;
}

@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;
@property(nonatomic,assign) int currentIndex;
@end

@implementation RepositoryDetailViewController
@synthesize currentIndex;

#pragma mark - Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.DsOfPageListObject1 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject2 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject3 = [[DataSourceModel alloc]init];    }
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
    self.title = _model.name;

    repositoryDetailDataSource=[[RepositoryDetailDataSource alloc] init];
    repositoryDetailViewModel=[[RepositoryDetailViewModel alloc] init];
    repositoryDetailViewModel.model=_model;
    currentIndex=1;
    repositoryDetailDataSource.currentIndex=currentIndex;

    // Do any additional setup after loading the view.
    
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain ];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=repositoryDetailDataSource;
    tableView.rowHeight=RepositoriesTableViewCellheight;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader];
    [self addFooter];
    
    titleView=[[UIView alloc] init];
    tableView.tableHeaderView=titleView;
    float orginX=10;
    nameBt=[UIButton buttonWithType:UIButtonTypeCustom];
    nameBt.frame=CGRectMake(orginX, 0, (ScreenWidth-2*orginX)/2, 40);
    [nameBt setTitleColor:YiBlue forState:UIControlStateNormal];
    nameBt.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [titleView addSubview:nameBt];
    [nameBt addTarget:self action:@selector(nameBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    ownerBt=[UIButton buttonWithType:UIButtonTypeCustom];
    ownerBt.frame=CGRectMake(orginX+(ScreenWidth-2*orginX)/2, 0, (ScreenWidth-2*orginX)/2, 40);
    [ownerBt setTitleColor:YiBlue forState:UIControlStateNormal];
    ownerBt.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    ownerBt.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [titleView addSubview:ownerBt];
    ownerBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [ownerBt addTarget:self action:@selector(ownerBtAction) forControlEvents:UIControlEventTouchUpInside];

    lineLabel=[[UILabel alloc] init];
    [titleView addSubview:lineLabel];
    lineLabel.font=[UIFont systemFontOfSize:20];
    lineLabel.textColor=YiGray;
    lineLabel.text=@"/";

    ownerIV=[[UIImageView alloc] init];
    [titleView addSubview:ownerIV];
    ownerIV.frame=CGRectMake(ScreenWidth-45, 5, 30, 30);
    ownerIV.layer.masksToBounds=YES;
    ownerIV.layer.cornerRadius=4;
    
    forkLabel=[[UILabel alloc] initWithFrame:CGRectMake(orginX, 40, 70, 30)];
    [titleView addSubview:forkLabel];
    forkLabel.textColor=YiTextGray;
    forkLabel.text=@"forked from";
    forkLabel.font=[UIFont systemFontOfSize:12];
    forkLabel.hidden=YES;
    parentBt=[UIButton buttonWithType:UIButtonTypeCustom];
    parentBt.frame=CGRectMake(orginX+70, 40, (ScreenWidth-2*orginX)/2, 30);
    [parentBt setTitleColor:YiBlue forState:UIControlStateNormal];
    parentBt.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [titleView addSubview:parentBt];

    createLabel=[[UILabel alloc] initWithFrame:CGRectMake(orginX, 70, 100, 30)];
    [titleView addSubview:createLabel];
    createLabel.font=[UIFont systemFontOfSize:11];
    
    homePageBt=[UIButton buttonWithType:UIButtonTypeCustom];
    homePageBt.frame=CGRectMake(orginX+100, 70, (ScreenWidth-2*orginX)-100, 30);
    [homePageBt setTitleColor:YiBlue forState:UIControlStateNormal];
    homePageBt.titleLabel.font=[UIFont boldSystemFontOfSize:13];

    [titleView addSubview:homePageBt];
    homePageBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    homePageBt.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [homePageBt addTarget:self action:@selector(homePageAction) forControlEvents:UIControlEventTouchUpInside];
    descLabel=[[UILabel alloc] initWithFrame:CGRectMake(orginX, 130-30, (ScreenWidth-2*orginX), 30)];
    [titleView addSubview:descLabel];
    descLabel.font=[UIFont systemFontOfSize:12];
    descLabel.numberOfLines=0;
    descLabel.lineBreakMode=NSLineBreakByWordWrapping;
    
    line1=[[UILabel alloc] init];
    [titleView addSubview:line1];
    line1.backgroundColor=YiGray;
    
    segmentControl=[[DetailSegmentControl alloc] initWithFrame:CGRectMake(0, 130+5-30, ScreenWidth, 60)];
    [titleView addSubview:segmentControl];
    segmentControl.bt1Label1.text=@"Contributors";
    segmentControl.bt2Label1.text=@"Forks";
    segmentControl.bt3Label1.text=@"Stargazers";
    tableView.tableHeaderView=titleView;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"

    segmentControl.ButtonActionBlock=^(int buttonTag){
        currentIndex=buttonTag-100;
        repositoryDetailDataSource.currentIndex=buttonTag-100;
        if (currentIndex==1) {
            if (self.DsOfPageListObject1.dsArray.count<1) {
                [refreshHeader beginRefreshing];
            }
        }else if (currentIndex==2){
            if (self.DsOfPageListObject2.dsArray.count<1) {
                [refreshHeader beginRefreshing];
            }
        }else if (currentIndex==3){
            if (self.DsOfPageListObject3.dsArray.count<1) {
                [refreshHeader beginRefreshing];}
        }
        [tableView reloadData];
    };
#pragma clang diagnostic pop

    [self refreshTitleView];
    [self checkStarStatusAction];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)nameBtAction
{
    if (_model.html_url.length>0  ) {
        WebViewController *web=[[WebViewController alloc] init];
        web.urlString=_model.html_url;
        [self.navigationController pushViewController:web animated:YES];
        
    }
}


- (void)ownerBtAction
{
    if (_model.user.html_url.length>0  ) {
        WebViewController *web=[[WebViewController alloc] init];
        web.urlString=_model.user.html_url;
        [self.navigationController pushViewController:web animated:YES];
    }
}

- (void)starAction
{
    if (isStaring) {
        [self showYiProgressHUD:@"unstaring……"];
        [ApplicationDelegate.apiEngine unStarRepoWithOwner:_model.user.login repo:_model.name completoinHandler:^(BOOL isSuccess){
            if (isSuccess) {
                [self hideYiProgressHUD];
                isStaring=!isStaring;
                self.navigationItem.rightBarButtonItem=nil;
                UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"star" style:UIBarButtonItemStylePlain target:self action:@selector(starAction)];
                self.navigationItem.rightBarButtonItem=right;
            }else{
                [self hideYiProgressHUD];
            }
        } errorHandel:^(NSError *error){
            [self hideYiProgressHUD];
        }];
        
    }else{
        [self showYiProgressHUD:@"staring……"];
        [ApplicationDelegate.apiEngine starRepoWithOwner:_model.user.login repo:_model.name completoinHandler:^(BOOL isSuccess){
            if (isSuccess) {
                [self hideYiProgressHUD];
                isStaring=!isStaring;
                self.navigationItem.rightBarButtonItem=nil;
                UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"unstar" style:UIBarButtonItemStylePlain target:self action:@selector(starAction)];
                self.navigationItem.rightBarButtonItem=right;
            }else{
              [self hideYiProgressHUD];
            }
        } errorHandel:^(NSError *error){
          [self hideYiProgressHUD];
        }];
    }
}

- (void)checkStarStatusAction
{
 
    NSString *savedLogin=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
    NSString *savedToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if (savedLogin.length<1 || !savedLogin) {
        return;
    }
    if (savedToken.length<1 || !savedToken) {
        return;
    }
    [ApplicationDelegate.apiEngine checkStarStatusWithOwner:_model.user.login repo:_model.name completoinHandler:^(BOOL isStarred){
        isStaring=isStarred;
        NSString *rightTitle;
        if (isStaring) {
            rightTitle=@"unstar";
        }else{
            rightTitle=@"star";
            
        }
        self.navigationItem.rightBarButtonItem=nil;
        UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStylePlain target:self action:@selector(starAction)];
        self.navigationItem.rightBarButtonItem=right;
    } errorHandel:^(NSError *error){
    }];
}

- (void)homePageAction
{
    if (_model.homepage.length>0  ) {
        WebViewController *web=[[WebViewController alloc] init];
        web.urlString=_model.homepage;
        [self.navigationController pushViewController:web animated:YES];
    }
}

#pragma mark - Private

- (void)refreshTitleView
{
    float orginX=10;
    segmentControl.bt2Label.text=[NSString stringWithFormat:@"%d",_model.forks_count];
    segmentControl.bt3Label.text=[NSString stringWithFormat:@"%d",_model.stargazers_count];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    float nameWidth=[_model.name sizeWithFont:[UIFont boldSystemFontOfSize:19] constrainedToSize:CGSizeMake((ScreenWidth-2*10)/2, 40) lineBreakMode:NSLineBreakByWordWrapping].width;
    nameBt.frame=CGRectMake(10, 0, nameWidth, 40);
    lineLabel.frame=CGRectMake(orginX+nameWidth, 0, 10, 40);
    ownerBt.frame=CGRectMake(orginX+nameWidth+10, 0, (ScreenWidth-2*orginX)/2-40, 40);
    [ownerIV sd_setImageWithURL:[NSURL URLWithString:_model.user.avatar_url]];
    [nameBt setTitle:_model.name forState:UIControlStateNormal];
    [ownerBt setTitle:_model.user.login forState:UIControlStateNormal];
    [parentBt setTitle:_model.parentOwnerName forState:UIControlStateNormal];
    float parentheight=0;
    if (_model.parentOwnerName==nil) {
        forkLabel.hidden=YES;
        parentheight=-30;
    }else{
        forkLabel.hidden=NO;
    }
    createLabel.frame=CGRectMake(orginX, 70+parentheight, 100, 30);
    createLabel.text=[_model.created_at substringWithRange:NSMakeRange(0, 10)];
    [homePageBt setTitle:_model.homepage forState:UIControlStateNormal];
    homePageBt.frame=CGRectMake(orginX+100, 70+parentheight, (ScreenWidth-2*orginX)-100, 30);
    float descHeight=[_model.repositoryDescription sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake((ScreenWidth-2*orginX), 700) lineBreakMode:NSLineBreakByWordWrapping].height+5;
#pragma clang diagnostic pop
    descLabel.text=_model.repositoryDescription;
    descLabel.frame=CGRectMake(orginX, 130+parentheight-30, (ScreenWidth-2*orginX), descHeight);
    segmentControl.frame=CGRectMake(0, 130+descHeight+5+parentheight-30, ScreenWidth, 60);
    titleView.frame=CGRectMake(0, 0, ScreenWidth, 130+descHeight+5+60+parentheight-30);
    line1.frame=CGRectMake(0, 130+descHeight+5+60+parentheight-30-0.5, ScreenWidth,0.5 );
    tableView.tableHeaderView=titleView;
    [tableView reloadData];
}

- (void)addHeader
{  //    YiRefreshHeader  头部刷新按钮的使用
    refreshHeader=[[YiRefreshHeader alloc] init];
    refreshHeader.scrollView=tableView;
    [refreshHeader header];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    WEAKSELF

    refreshHeader.beginRefreshingBlock=^(){
        
        [ApplicationDelegate.apiEngine repositoryDetailWithUserName:_model.user.login repositoryName:_model.name completoinHandler:^(RepositoryModel *model){
            _model=model;
            STRONGSELF
            [strongSelf refreshTitleView];
            [strongSelf loadDataFromApiWithIsFirst:YES];
        } errorHandel:^(NSError* error){
            STRONGSELF
            [strongSelf loadDataFromApiWithIsFirst:YES];
        }];
    };
#pragma clang diagnostic pop

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

- (void)loadDataFromApiWithIsFirst:(BOOL)isFirst
{
    
    [repositoryDetailViewModel loadDataFromApiWithIsFirst:isFirst currentIndex:currentIndex firstTableData:^(DataSourceModel* DsOfPageListObject){
        repositoryDetailDataSource.DsOfPageListObject1=DsOfPageListObject;
        
                    [tableView reloadData];
        
                    if (!isFirst) {
                        [refreshFooter endRefreshing];
                    }else
                    {
                        [refreshHeader endRefreshing];
                    }
        
    } secondTableData:^(DataSourceModel* DsOfPageListObject){
        repositoryDetailDataSource.DsOfPageListObject2=DsOfPageListObject;
        [tableView reloadData];
        
        if (!isFirst) {
            [refreshFooter endRefreshing];
        }else
        {
            [refreshHeader endRefreshing];
        }

    } thirdTableData:^(DataSourceModel* DsOfPageListObject){
        repositoryDetailDataSource.DsOfPageListObject3=DsOfPageListObject;
        [tableView reloadData];
        
        if (!isFirst) {
            [refreshFooter endRefreshing];
        }else
        {
            [refreshHeader endRefreshing];
        }
    }];
  
}
#pragma mark - UITableViewDataSource  &UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (currentIndex==1) {
        return RankTableViewCellHeight;
    }else if (currentIndex==2){
        return RankTableViewCellHeight;
    }else if (currentIndex==3){
        return RankTableViewCellHeight;
    }
    return 1;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (currentIndex==1) {
        UserModel  *model = [(repositoryDetailDataSource.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        UserDetailViewController *detail=[[UserDetailViewController alloc] init];
        detail.userModel=model;
        [self.navigationController pushViewController:detail animated:YES];
       
    }else if (currentIndex==2){
        RepositoryModel  *model = [(repositoryDetailDataSource.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        RepositoryDetailViewController *viewController=[[RepositoryDetailViewController alloc] init];
        viewController.model=model;
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (currentIndex==3){
        UserModel  *model = [(repositoryDetailDataSource.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        UserDetailViewController *detail=[[UserDetailViewController alloc] init];
        detail.userModel=model;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
