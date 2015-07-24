//
//  UserDetailViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserModel.h"
#import "RankTableViewCell.h"
#import "RepositoryModel.h"
#import "RepositoriesTableViewCell.h"
#import "DetailSegmentControl.h"
#import "WebViewController.h"


#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "RepositoryDetailViewController.h"


@interface UserDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView;
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
    int currentIndex;

    
    UIImageView *titleImageView;
    UIButton *loginButton;
    UILabel *name;
    UILabel *createLabel;
    UILabel *company;
    UILabel *locationLabel;
    UIButton *emailBt;
    UIButton *blogBt;
    DetailSegmentControl *segmentControl;
    BOOL isFollowing;
    OCTClient *client;
}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;

@end

@implementation UserDetailViewController
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
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cityAppear"];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _userModel.login;
    currentIndex=1;

    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }

    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
   
    
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain ];
    [self.view addSubview:tableView];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=135.7;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader];
    [self addFooter];
//    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
//    self.navigationItem.rightBarButtonItem=right;

    
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 210+35)];
    UIView *titleBg1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150+35)];
    [titleView addSubview:titleBg1];
    
    titleImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
//    titleImageView.image=[UIImage imageNamed:@"github_square"];
    [titleBg1 addSubview:titleImageView];
    titleImageView.layer.cornerRadius=13;
    titleImageView.layer.borderColor=YiGray.CGColor;
    titleImageView.layer.borderWidth=0.3;
    titleImageView.layer.masksToBounds=YES;
    // 事件监听
    titleImageView.tag = 0;
    titleImageView.userInteractionEnabled = YES;
    [titleImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
    
    // 内容模式
    titleImageView.clipsToBounds = YES;
    titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
//    login=[[UILabel alloc] initWithFrame:CGRectMake(100, 10, 135, 30)];
//    [titleBg1 addSubview:login];
    
    loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame=CGRectMake(100, 10, 135, 30);
    
    [titleBg1 addSubview:loginButton];
    [loginButton setTitleColor:YiBlue forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    loginButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    name=[[UILabel alloc] initWithFrame:CGRectMake(235, 10, 75+ScreenWidth-320, 30)];
    [titleBg1 addSubview:name];
    createLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 45, 210, 30)];
    [titleBg1 addSubview:createLabel];
    

    
    
    company=[[UILabel alloc] initWithFrame:CGRectMake(100, 45+35, 95, 30)];
    [titleBg1 addSubview:company];
    
    locationLabel=[[UILabel alloc] initWithFrame:CGRectMake(200, 45+35, 110+ScreenWidth-320, 30)];
    [titleBg1 addSubview:locationLabel];
    
    emailBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [titleBg1 addSubview:emailBt];
    emailBt.frame=CGRectMake(100, 80+35, 210+ScreenWidth-320, 30);
    
    
    blogBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [titleBg1 addSubview:blogBt];
    blogBt.frame=CGRectMake(100, 115+35, 210+ScreenWidth-320, 30);
    [blogBt addTarget:self action:@selector(blogAction) forControlEvents:UIControlEventTouchUpInside];
    
    [blogBt setTitleColor:YiBlue forState:UIControlStateNormal];
    [emailBt setTitleColor:YiBlue forState:UIControlStateNormal];
    
    loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    name.font=[UIFont systemFontOfSize:14];
    company.font=[UIFont systemFontOfSize:14];
    emailBt.titleLabel.font=[UIFont systemFontOfSize:15];
    blogBt.titleLabel.font=[UIFont systemFontOfSize:15];
//    company.backgroundColor =[UIColor redColor];
//    locationLabel.backgroundColor=[UIColor greenColor];
//    login.backgroundColor=[UIColor redColor];
//    name.backgroundColor=[UIColor greenColor];
    locationLabel.font=[UIFont systemFontOfSize:13];
    name.textColor=YiTextGray;
    createLabel.font=[UIFont systemFontOfSize:12];
    blogBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    blogBt.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    emailBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    emailBt.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0, 182, ScreenWidth, 1)];
//    [titleBg1 addSubview:line];
    line.backgroundColor=YiBlue;
    [self refreshTitleView];
    
    UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(0, 244, ScreenWidth, 1)];
    [titleBg1 addSubview:line1];
    line1.backgroundColor=YiGray;
    
    
    segmentControl=[[DetailSegmentControl alloc] initWithFrame:CGRectMake(0, 150+34, ScreenWidth, 60)];
    [titleView addSubview:segmentControl];
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
    
    
    [self checkFollowStatusAction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)loginButtonAction{

    if (_userModel.html_url.length>0  ) {
        WebViewController *web=[[WebViewController alloc] init];
        web.urlString=_userModel.html_url;
        [self.navigationController pushViewController:web animated:YES];
        
    }
}
- (void)followAction{
    OCTUser *user=[OCTUser userWithRawLogin:_userModel.login server:OCTServer.dotComServer];
    NSString *login= _userModel.login;
    user.login=login;
    
    
    if (isFollowing) {
        [self showYiProgressHUD:@"unfollowing……"];
        [[client unfollowUser:user] subscribeNext:^(id x) {
            NSLog(@"a");
           
        } error:^(NSError *error) {
            NSLog(@"e %@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideYiProgressHUD];
                
            });
        } completed:^{
            NSLog(@"c");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideYiProgressHUD];
                isFollowing=!isFollowing;
                self.navigationItem.rightBarButtonItem=nil;
                UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"follow" style:UIBarButtonItemStylePlain target:self action:@selector(followAction)];
                self.navigationItem.rightBarButtonItem=right;
            });
        }];


    }else{
        [self showYiProgressHUD:@"following……"];

        [[client followUser:user]subscribeNext:^(id x) {
            NSLog(@"a");
         
        } error:^(NSError *error) {
            NSLog(@"e %@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideYiProgressHUD];
                
            });
        } completed:^{
            NSLog(@"c");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideYiProgressHUD];
                isFollowing=!isFollowing;
                self.navigationItem.rightBarButtonItem=nil;
                UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"unfollow" style:UIBarButtonItemStylePlain target:self action:@selector(followAction)];
                self.navigationItem.rightBarButtonItem=right;
            });
        }];

    }
}
- (void)checkFollowStatusAction{
    /*
    [ApplicationDelegate.apiEngine checkFollowStatusWithUsername:@"coderyi" target_user:_userModel.login completoinHandler:^(UserModel *model){
        
    } errorHandel:^(NSError* error){
        
    }];
     */
    NSString *savedLogin=[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
    NSString *savedToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if (savedLogin.length<1 || !savedLogin) {
        return;
    }
    if (savedToken.length<1 || !savedToken) {
        return;
    }
    
    OCTUser *user = [OCTUser userWithRawLogin:savedLogin server:OCTServer.dotComServer];
    client = [OCTClient authenticatedClientWithUser:user token:savedToken];
   
    
    OCTUser *followUser=[OCTUser userWithRawLogin:_userModel.login server:OCTServer.dotComServer];
    NSString *followLogin= _userModel.login;
    followUser.login=followLogin;
    [[client hasFollowUser:followUser] subscribeNext:^(NSNumber *hasFollowUser){
        dispatch_async(dispatch_get_main_queue(), ^{
            isFollowing=hasFollowUser.boolValue;
            NSLog(@"%@",hasFollowUser);
            NSString *rightTitle;
            if (isFollowing) {
                rightTitle=@"unfollow";
            }else{
                rightTitle=@"follow";
                
            }
            
            self.navigationItem.rightBarButtonItem=nil;
            UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStylePlain target:self action:@selector(followAction)];
            self.navigationItem.rightBarButtonItem=right;
        
        });
        
        
    }  error:^(NSError *error) {
        NSLog(@"e %@",error);
    } completed:^{
        NSLog(@"c");
    }];
    
    
    
//    client

}

//详细见mj的code4app
//http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E5%9B%BE%E7%89%87%E6%B5%8F%E8%A7%88%E5%99%A8/525e06116803fa7b0a000001
- (void)tapImage:(UITapGestureRecognizer *)tap
{
//    NSArray *urls=@[_userModel.avatar_url];
//    int count = urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
//    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:_userModel.avatar_url]; // 图片路径
        photo.srcImageView = titleImageView; // 来源于哪个UIImageView
        [photos addObject:photo];
//    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}


- (void)blogAction{
    if (_userModel.blog.length>0  ) {
        WebViewController *web=[[WebViewController alloc] init];
        web.urlString=_userModel.blog;
        [self.navigationController pushViewController:web animated:YES];
        
    }
}

#pragma mark - Private

- (void)refreshTitleView{
    [titleImageView sd_setImageWithURL:[NSURL URLWithString:_userModel.avatar_url]];

 
//    login.backgroundColor=[UIColor darkGrayColor];
//    name.backgroundColor=[UIColor blueColor];
//    createLabel.backgroundColor=[UIColor darkGrayColor];
//    company.backgroundColor=[UIColor darkGrayColor];
//    locationLabel.backgroundColor=[UIColor darkGrayColor];
//    [emailBt setBackgroundColor:[UIColor darkGrayColor]];
//    blogBt.backgroundColor=[UIColor darkGrayColor];
    [loginButton setTitle:_userModel.login forState:UIControlStateNormal];
    
    name.text=_userModel.name;
    createLabel.text=[_userModel.created_at substringWithRange:NSMakeRange(0, 10)];
    company.text=_userModel.company;
    locationLabel.text=_userModel.location;
    [emailBt setTitle:_userModel.email forState:UIControlStateNormal];
    [blogBt setTitle:_userModel.blog forState:UIControlStateNormal];
    segmentControl.bt1Label.text=[NSString stringWithFormat:@"%d",_userModel.public_repos];
    
    segmentControl.bt2Label.text=[NSString stringWithFormat:@"%d",_userModel.following];

    segmentControl.bt3Label.text=[NSString stringWithFormat:@"%d",_userModel.followers];

    
//    login.text=@"coderyi";
//    name.text=@"coderyi";
//    createLabel.text=@"2015-01-24";
//    company.text=@"腾讯";
//    locationLabel.text=@"Beijing China";
//    [emailBt setTitle:@"coderyi@foxmail.com" forState:UIControlStateNormal];
//    [blogBt setTitle:@"www.coderyi.com" forState:UIControlStateNormal];
    
    
    
}


- (void)addHeader
{  //    YiRefreshHeader  头部刷新按钮的使用
    refreshHeader=[[YiRefreshHeader alloc] init];
    refreshHeader.scrollView=tableView;
    [refreshHeader header];
    
    refreshHeader.beginRefreshingBlock=^(){
        [ApplicationDelegate.apiEngine userDetailWithUserName:_userModel.login completoinHandler:^(UserModel *model){
            _userModel=model;
            [self refreshTitleView];
            [self loadDataFromApiWithIsFirst:YES];
            
            
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
    __weak typeof(self) weakSelf = self;
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
        [ApplicationDelegate.apiEngine userRepositoriesWithPage:page userName:_userModel.login completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            
            if (page<=1) {
                [self.DsOfPageListObject1.dsArray removeAllObjects];
            }
            
            
            //        [self hideHUD];
            
            [self.DsOfPageListObject1.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject1.page=page;
            [tableView reloadData];
            
            if (page>1) {
                
                [refreshFooter endRefreshing];
                
                
            }else
            {
                [refreshHeader endRefreshing];
            }
            
        } errorHandel:^(NSError* error){
            if (isFirst) {
                
                [refreshHeader endRefreshing];
                
                
                
                
            }else{
                [refreshFooter endRefreshing];
                
            }
            
        }];
        
        
        
        
        
        return YES;
    }else if (currentIndex==2){
            NSInteger page = 0;
            
            if (isFirst) {
                page = 1;
                
            }else{
                
                page = self.DsOfPageListObject2.page+1;
            }
            [ApplicationDelegate.apiEngine userFollowingWithPage:page userName:_userModel.login completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
                
                if (page<=1) {
                    [self.DsOfPageListObject2.dsArray removeAllObjects];
                }
                
                
                //        [self hideHUD];
                
                [self.DsOfPageListObject2.dsArray addObjectsFromArray:modelArray];
                self.DsOfPageListObject2.page=page;
                [tableView reloadData];
                
                if (page>1) {
                    
                    [refreshFooter endRefreshing];
                    
                    
                }else
                {
                    [refreshHeader endRefreshing];
                }
                
            } errorHandel:^(NSError* error){
                if (isFirst) {
                    
                    [refreshHeader endRefreshing];
                    
                    
                    
                    
                }else{
                    [refreshFooter endRefreshing];
                    
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
                [ApplicationDelegate.apiEngine userFollowersWithPage:page userName:_userModel.login completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
                    
                    if (page<=1) {
                        [self.DsOfPageListObject3.dsArray removeAllObjects];
                    }
                    
                    
                    //        [self hideHUD];
                    
                    [self.DsOfPageListObject3.dsArray addObjectsFromArray:modelArray];
                    self.DsOfPageListObject3.page=page;
                    [tableView reloadData];
                    
                    if (page>1) {
                        
                        [refreshFooter endRefreshing];
                        
                        
                    }else
                    {
                        [refreshHeader endRefreshing];
                    }
                    
                } errorHandel:^(NSError* error){
                    if (isFirst) {
                        
                        [refreshHeader endRefreshing];
                        
                        
                        
                        
                    }else{
                        [refreshFooter endRefreshing];
                        
                    }
                    
                }];
                
                
                
                
                
                return YES;
    }
    
    return YES;
    
}



#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex==1) {
        return 135.7;
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

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex==1) {
        
  
        NSString *cellId=@"CellId";
        RepositoriesTableViewCell *cell=[tableView1 dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.userLabel.hidden=YES;
            cell.titleImageView.hidden=YES;
    
        }
        RepositoryModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.repositoryLabel.text=[NSString stringWithFormat:@"%@",model.name];
//    cell.userLabel.text=[NSString stringWithFormat:@"Owner:%@",model.user.login];
//    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url] placeholderImage:nil];
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
    }else if (currentIndex==2){
            
            RankTableViewCell *cell;
            
            NSString *cellId=@"CellId1";
            cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell==nil) {
                cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            UserModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
            cell.rankLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
            cell.mainLabel.text=[NSString stringWithFormat:@"%@",model.login];
            cell.detailLabel.text=[NSString stringWithFormat:@"id:%d",model.userId];
            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:nil];
            return cell;
    }else if (currentIndex==3){ RankTableViewCell *cell;
                
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
                return cell;
    }
    return nil;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex==1) {
        RepositoryModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        RepositoryDetailViewController *viewController=[[RepositoryDetailViewController alloc] init];
        viewController.model=model;
        [self.navigationController pushViewController:viewController animated:YES];

    }else if (currentIndex==2){
        UserModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        UserDetailViewController *detail=[[UserDetailViewController alloc] init];
        
        detail.userModel=model;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (currentIndex==3){
        UserModel  *model = [(self.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        UserDetailViewController *detail=[[UserDetailViewController alloc] init];
        
        detail.userModel=model;
        [self.navigationController pushViewController:detail animated:YES];
    }

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
