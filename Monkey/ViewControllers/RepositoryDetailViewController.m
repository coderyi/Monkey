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
#import "SegmentControl.h"
#import "RepositoriesTableViewCell.h"
#import "WebViewController.h"

@interface RepositoryDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
    UILabel *titleText;
    int currentIndex;

    SegmentControl *segmentControl;
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
}

@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;
@end

@implementation RepositoryDetailViewController
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
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cityAppear"];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    currentIndex=1;

    // Do any additional setup after loading the view.
    titleText = [[UILabel alloc] initWithFrame: CGRectMake((WScreen-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    
    titleText.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleText;
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen-64) style:UITableViewStylePlain ];
    [self.view addSubview:tableView];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=135.7;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader];
    [self addFooter];
    
    
    
    titleView=[[UIView alloc] init];
//    [self.view addSubview:titleView];
    tableView.tableHeaderView=titleView;
    float orginX=10;
    nameBt=[UIButton buttonWithType:UIButtonTypeCustom];
    nameBt.frame=CGRectMake(orginX, 0, (WScreen-2*orginX)/2, 40);
    [nameBt setTitleColor:YiBlue forState:UIControlStateNormal];
    [nameBt setFont:[UIFont boldSystemFontOfSize:19]];
    [titleView addSubview:nameBt];
    
    
    ownerBt=[UIButton buttonWithType:UIButtonTypeCustom];
    ownerBt.frame=CGRectMake(orginX+(WScreen-2*orginX)/2, 0, (WScreen-2*orginX)/2, 40);
    [ownerBt setTitleColor:YiBlue forState:UIControlStateNormal];
    [ownerBt setFont:[UIFont boldSystemFontOfSize:19]];
    [titleView addSubview:ownerBt];
    ownerBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    
    
    lineLabel=[[UILabel alloc] init];
    [titleView addSubview:lineLabel];
    lineLabel.font=[UIFont systemFontOfSize:20];
//    lineLabel.backgroundColor=[UIColor redColor];
    lineLabel.textColor=YiGray;
    lineLabel.text=@"/";

    
    
    ownerIV=[[UIImageView alloc] init];
    [titleView addSubview:ownerIV];
    ownerIV.frame=CGRectMake(WScreen-45, 5, 30, 30);
    ownerIV.layer.masksToBounds=YES;
    ownerIV.layer.cornerRadius=4;
    
    
   
    
//    nameBt.backgroundColor=[UIColor redColor];
    
    
    forkLabel=[[UILabel alloc] initWithFrame:CGRectMake(orginX, 40, 70, 30)];
    [titleView addSubview:forkLabel];
    forkLabel.textColor=YiTextGray;
    forkLabel.text=@"forked from";
    forkLabel.font=[UIFont systemFontOfSize:12];
    forkLabel.hidden=YES;
    parentBt=[UIButton buttonWithType:UIButtonTypeCustom];
    parentBt.frame=CGRectMake(orginX+70, 40, (WScreen-2*orginX)/2, 30);
    [parentBt setTitleColor:YiBlue forState:UIControlStateNormal];
    [parentBt setFont:[UIFont boldSystemFontOfSize:15]];
    [titleView addSubview:parentBt];
//    parentBt.backgroundColor=[UIColor redColor];

    
    createLabel=[[UILabel alloc] initWithFrame:CGRectMake(orginX, 70, 100, 30)];
    [titleView addSubview:createLabel];
    createLabel.font=[UIFont systemFontOfSize:11];
    
    
    homePageBt=[UIButton buttonWithType:UIButtonTypeCustom];
    homePageBt.frame=CGRectMake(orginX, 100, (WScreen-2*orginX), 30);
    [homePageBt setTitleColor:YiBlue forState:UIControlStateNormal];
    [homePageBt setFont:[UIFont boldSystemFontOfSize:13]];
    [titleView addSubview:homePageBt];
//    homePageBt.backgroundColor=[UIColor redColor];
    homePageBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [homePageBt addTarget:self action:@selector(homePageAction) forControlEvents:UIControlEventTouchUpInside];
    descLabel=[[UILabel alloc] initWithFrame:CGRectMake(orginX, 130, (WScreen-2*orginX), 30)];
    [titleView addSubview:descLabel];
    descLabel.font=[UIFont systemFontOfSize:12];
    descLabel.numberOfLines=0;
    descLabel.lineBreakMode=NSLineBreakByWordWrapping;
    
    segmentControl=[[SegmentControl alloc] initWithFrame:CGRectMake(0, 130+5, WScreen, 60)];
    [titleView addSubview:segmentControl];
    segmentControl.bt1Label1.text=@"Contributors";
    segmentControl.bt2Label1.text=@"Forks";

    segmentControl.bt3Label1.text=@"Stargazers";

    tableView.tableHeaderView=titleView;
    segmentControl.ButtonActionBlock=^(int buttonTag){
        
        currentIndex=buttonTag-100;
        if (currentIndex==1) {
            if (self.DsOfPageListObject1.dsArray.count<1) {
                [refreshHeader beginRefreshing];
            }
        }else if (currentIndex==2){
            if (self.DsOfPageListObject2.dsArray.count<1) {
                [refreshHeader beginRefreshing];}
            
        }else if (currentIndex==3){
            if (self.DsOfPageListObject3.dsArray.count<1) {
                [refreshHeader beginRefreshing];}
            
        }
        [tableView reloadData];
    };
}
-(void)homePageAction{
    if (_model.homepage.length>0  ) {
        WebViewController *web=[[WebViewController alloc] init];
        web.urlString=_model.homepage;
        [self.navigationController pushViewController:web animated:YES];
        
    }
}
-(void)refreshTitleView{

//    segmentControl.bt1Label.text=[NSString stringWithFormat:@"%d",_model.public_repos];
    float orginX=10;
    segmentControl.bt2Label.text=[NSString stringWithFormat:@"%d",_model.forks_count];
    
    segmentControl.bt3Label.text=[NSString stringWithFormat:@"%d",_model.stargazers_count];
    float nameWidth=[[NSString stringWithFormat:_model.name] sizeWithFont:[UIFont boldSystemFontOfSize:19] constrainedToSize:CGSizeMake((WScreen-2*10)/2, 40) lineBreakMode:NSLineBreakByWordWrapping].width;
    
    nameBt.frame=CGRectMake(10, 0, nameWidth, 40);
    lineLabel.frame=CGRectMake(orginX+nameWidth, 0, 10, 40);
    ownerBt.frame=CGRectMake(orginX+nameWidth+10, 0, (WScreen-2*orginX)/2-40, 40);
    [ownerIV setImageWithURL:[NSURL URLWithString:_model.user.avatar_url]];
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
    homePageBt.frame=CGRectMake(orginX, 100+parentheight, (WScreen-2*orginX), 30);
    
//    descLabel.backgroundColor=[UIColor redColor];
//    _model.repositoryDescription=@"12345667890qwetruyoipasdfghjklzcxvbnm12345667890qwetruyoipasdfghjklzcxvbnm12345667890qwetruyoipasdfghjklzcxvbnm12345667890qwetruyoipasdfghjklzcxvbnm12345667890qwetruyoipasdfghjklzcxvbnm12345667890qwetruyoipasdfghjklzcxvbnm12345667890qwetruyoipasdfghjklzcxvbnm12345667890qwetruyoipasdfghjklzcxvbnm12345667890qwetruyoipasdfghjklzcxvbnm12345667890qwetruyoipasdfghjklzcxvbnm";
    float descHeight=[[NSString stringWithFormat:_model.repositoryDescription] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake((WScreen-2*10), 700) lineBreakMode:NSLineBreakByWordWrapping].height;
    descLabel.text=_model.repositoryDescription;
    descLabel.frame=CGRectMake(orginX, 130+parentheight, (WScreen-2*orginX), descHeight);
    segmentControl.frame=CGRectMake(0, 130+descHeight+5+parentheight, WScreen, 60);
    titleView.frame=CGRectMake(0, 0, WScreen, 130+descHeight+5+60+parentheight);
    tableView.tableHeaderView=titleView;
    [tableView reloadData];
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex==1) {
        return 90.7;
    }else if (currentIndex==2){
        return 90.7;
    }else if (currentIndex==3){
        return 90.7;
    }
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (currentIndex==1) {
        return self.DsOfPageListObject1.dsArray.count;
        
    }else if (currentIndex==2){
        
        return self.DsOfPageListObject2.dsArray.count;
        
    }else if (currentIndex==3){
        
        return self.DsOfPageListObject3.dsArray.count;
        
        
    }
    
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex==1) {
        
        
        RankTableViewCell *cell;
        
        NSString *cellId=@"CellId";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        UserModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.mainLabel.text=[NSString stringWithFormat:@"%@",model.login];
        cell.detailLabel.text=[NSString stringWithFormat:@"id:%d",model.userId];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:nil];
        return cell;  }else if (currentIndex==2){
            
            RankTableViewCell *cell;
            
            NSString *cellId=@"CellId1";
            cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell==nil) {
                cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            RepositoryModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
            cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
            cell.mainLabel.text=[NSString stringWithFormat:@"%@",model.user.login];
            cell.detailLabel.text=[NSString stringWithFormat:@"id:%d",model.userId];
            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url] placeholderImage:nil];
            return cell;}else if (currentIndex==3){ RankTableViewCell *cell;
                
                NSString *cellId=@"CellId2";
                cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                if (cell==nil) {
                    cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                UserModel  *model = [(self.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
                cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
                cell.mainLabel.text=[NSString stringWithFormat:@"%@",model.login];
                cell.detailLabel.text=[NSString stringWithFormat:@"id:%d",model.userId];
                [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:nil];
                return cell;}
    return nil;
    
    
}


- (void)addHeader
{  //    YiRefreshHeader  头部刷新按钮的使用
    refreshHeader=[[YiRefreshHeader alloc] init];
    refreshHeader.scrollView=tableView;
    [refreshHeader header];
    __weak RepositoryDetailViewController *weakSelf=self;

    refreshHeader.beginRefreshingBlock=^(){
        
        
        [ApplicationDelegate.apiEngine repositoryDetailWithUserName:_model.user.login repositoryName:_model.name completoinHandler:^(RepositoryModel *model){
            _model=model;
            [weakSelf refreshTitleView];
            [weakSelf loadDataFromApiWithIsFirst:YES];
            
            
        } errorHandel:^(NSError* error){
            
            [self loadDataFromApiWithIsFirst:YES];
            
            
            
        }];
        
        
        
        
        
        
    };
    
    //    是否在进入该界面的时候就开始进入刷新状态
    
    [refreshHeader beginRefreshing];
}

- (void)addFooter
{    //    YiRefreshFooter  底部刷新按钮的使用
    refreshFooter=[[YiRefreshFooter alloc] init];
    refreshFooter.scrollView=tableView;
    [refreshFooter footer];
    __weak RepositoryDetailViewController *weakSelf=self;
    refreshFooter.beginRefreshingBlock=^(){
        
        [weakSelf loadDataFromApiWithIsFirst:NO];
    };}


- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst
{
    
    if (currentIndex==1) {
        
        
        NSInteger page = 0;
        
        if (isFirst) {
            page = 1;
            
        }else{
            
            page = self.DsOfPageListObject1.page+1;
        }
        [ApplicationDelegate.apiEngine reposDetailCategoryWithPage:page userName:_model.user.login repositoryName:_model.name category:@"contributors" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            
            if (page<=1) {
                [self.DsOfPageListObject1.dsArray removeAllObjects];
            }
            
            
            //        [self hideHUD];
            
            [self.DsOfPageListObject1.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject1.page=page;
            [refreshHeader endRefreshing];
            
            if (page>1) {
                
                [refreshFooter endRefreshing];
                
                
            }else
            {
                [refreshHeader endRefreshing];
            }
            [tableView reloadData];
        } errorHandel:^(NSError* error){
            if (isFirst) {
                
                [refreshHeader endRefreshing];
                
                
                
                
            }else{
                [refreshFooter endRefreshing];
                
            }
            
        }];
        
        
        
        
        
        return YES; }else if (currentIndex==2){
            NSInteger page = 0;
            
            if (isFirst) {
                page = 1;
                
            }else{
                
                page = self.DsOfPageListObject2.page+1;
            }
            [ApplicationDelegate.apiEngine reposDetailCategoryWithPage:page userName:_model.user.login repositoryName:_model.name category:@"forks" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
                
                if (page<=1) {
                    [self.DsOfPageListObject2.dsArray removeAllObjects];
                }
                
                
                //        [self hideHUD];
                
                [self.DsOfPageListObject2.dsArray addObjectsFromArray:modelArray];
                self.DsOfPageListObject2.page=page;
                [refreshHeader endRefreshing];
                
                if (page>1) {
                    
                    [refreshFooter endRefreshing];
                    
                    
                }else
                {
                    [refreshHeader endRefreshing];
                }
                [tableView reloadData];
            } errorHandel:^(NSError* error){
                if (isFirst) {
                    
                    [refreshHeader endRefreshing];
                    
                    
                    
                    
                }else{
                    [refreshFooter endRefreshing];
                    
                }
                
            }];
            
            
            
            
            
            return YES;}else if (currentIndex==3){
                NSInteger page = 0;
                
                if (isFirst) {
                    page = 1;
                    
                }else{
                    
                    page = self.DsOfPageListObject3.page+1;
                }
                [ApplicationDelegate.apiEngine reposDetailCategoryWithPage:page userName:_model.user.login repositoryName:_model.name category:@"stargazers" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
                    
                    if (page<=1) {
                        [self.DsOfPageListObject3.dsArray removeAllObjects];
                    }
                    
                    
                    //        [self hideHUD];
                    
                    [self.DsOfPageListObject3.dsArray addObjectsFromArray:modelArray];
                    self.DsOfPageListObject3.page=page;
                    [refreshHeader endRefreshing];
                    
                    if (page>1) {
                        
                        [refreshFooter endRefreshing];
                        
                        
                    }else
                    {
                        [refreshHeader endRefreshing];
                    }
                    [tableView reloadData];
                } errorHandel:^(NSError* error){
                    if (isFirst) {
                        
                        [refreshHeader endRefreshing];
                        
                        
                        
                        
                    }else{
                        [refreshFooter endRefreshing];
                        
                    }
                    
                }];
                
                
                
                
                
                return YES;}
    
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
