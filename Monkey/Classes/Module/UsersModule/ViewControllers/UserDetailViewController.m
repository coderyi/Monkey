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
#import "UserDetailViewModel.h"
#import "UserDetailDataSource.h"

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
    UserDetailDataSource *userDetailDataSource;
    UserDetailViewModel *userDetailViewModel;

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
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _userModel.login;
    userDetailDataSource=[[UserDetailDataSource alloc] init];
    userDetailViewModel=[[UserDetailViewModel alloc] init];
    userDetailViewModel.userModel=_userModel;
    currentIndex=1;
    userDetailDataSource.currentIndex=currentIndex;
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }

    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
   
    
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain ];
    [self.view addSubview:tableView];
    
    tableView.delegate=self;
    tableView.dataSource=userDetailDataSource;
    tableView.rowHeight=RepositoriesTableViewCellheight;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader];
    [self addFooter];

    //orginY +30*3+heightSpace*2+orginY
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 210+35-35-40)];
    UIView *titleBg1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150+35-35-40)];
    [titleView addSubview:titleBg1];
    float orginX=10;
    float sufTitleImageViewSpace=10;
    float widthSpace=2;
    float orginY=10;
    float titleImageViewWidth=50;
    float heightSpace=0;
    float loginButtonWidth=110;
    float emailButtonWidth=ScreenWidth-orginX*3-titleImageViewWidth-loginButtonWidth-5;
//    float blogButtonWidth=ScreenWidth-orginX*3-titleImageViewWidth-loginButtonWidth-5;

    titleImageView=[[UIImageView alloc] initWithFrame:CGRectMake(orginX, orginY+5, titleImageViewWidth, titleImageViewWidth)];
    [titleBg1 addSubview:titleImageView];
    titleImageView.layer.cornerRadius=11;
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
    
    
    loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame=CGRectMake(orginX+sufTitleImageViewSpace+titleImageViewWidth, orginY, loginButtonWidth, 30);
    
    [titleBg1 addSubview:loginButton];
    [loginButton setTitleColor:YiBlue forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    loginButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    name=[[UILabel alloc] initWithFrame:CGRectMake(orginX+sufTitleImageViewSpace+titleImageViewWidth, orginY+heightSpace+30, loginButtonWidth, 30)];
    [titleBg1 addSubview:name];
    createLabel=[[UILabel alloc] initWithFrame:CGRectMake(orginX, orginY+titleImageViewWidth+5, titleImageViewWidth, 30)];
    [titleBg1 addSubview:createLabel];
    

    
    
    company=[[UILabel alloc] initWithFrame:CGRectMake(orginX+widthSpace+sufTitleImageViewSpace+titleImageViewWidth, orginY+heightSpace*2+30*2, loginButtonWidth, 30)];
    [titleBg1 addSubview:company];
    
    locationLabel=[[UILabel alloc] initWithFrame:CGRectMake(orginX+sufTitleImageViewSpace+titleImageViewWidth+loginButtonWidth, orginY+heightSpace*2+30*2, emailButtonWidth, 30)];
    [titleBg1 addSubview:locationLabel];
    
    emailBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [titleBg1 addSubview:emailBt];
    emailBt.frame=CGRectMake(orginX+widthSpace+sufTitleImageViewSpace+titleImageViewWidth+loginButtonWidth, orginY, emailButtonWidth, 30);
    
    
    blogBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [titleBg1 addSubview:blogBt];
    blogBt.frame=CGRectMake(orginX+widthSpace+sufTitleImageViewSpace+titleImageViewWidth+loginButtonWidth, orginY+heightSpace+30, emailButtonWidth, 30);
    [blogBt addTarget:self action:@selector(blogAction) forControlEvents:UIControlEventTouchUpInside];
    
    [blogBt setTitleColor:YiBlue forState:UIControlStateNormal];
    [emailBt setTitleColor:YiBlue forState:UIControlStateNormal];
    
    loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    name.font=[UIFont systemFontOfSize:14];
    company.font=[UIFont systemFontOfSize:13];
    emailBt.titleLabel.font=[UIFont systemFontOfSize:12];
    blogBt.titleLabel.font=[UIFont systemFontOfSize:12];
    locationLabel.font=[UIFont systemFontOfSize:13];
    name.textColor=YiTextGray;
    createLabel.font=[UIFont systemFontOfSize:9];
    blogBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    blogBt.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    emailBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    emailBt.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0, 182, ScreenWidth, 1)];
    line.backgroundColor=YiBlue;
    [self refreshTitleView];
    
    UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(0, 244-35-40, ScreenWidth, 1)];
    [titleBg1 addSubview:line1];
    line1.backgroundColor=YiGray;
    
    
    segmentControl=[[DetailSegmentControl alloc] initWithFrame:CGRectMake(0, 150+34-35-40, ScreenWidth, 60)];
    [titleView addSubview:segmentControl];
    tableView.tableHeaderView=titleView;
    segmentControl.ButtonActionBlock=^(int buttonTag){
        
        currentIndex=buttonTag-100;
        userDetailDataSource.currentIndex=buttonTag-100;

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
    
    
//    loginButton.backgroundColor=[UIColor yellowColor];
//    name.backgroundColor=[UIColor blueColor];
//    createLabel.backgroundColor=[UIColor blueColor];
//    company.backgroundColor=[UIColor yellowColor];
//    locationLabel.backgroundColor=[UIColor blueColor];
//    emailBt.backgroundColor=[UIColor grayColor];
//    blogBt.backgroundColor=[UIColor brownColor];
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
           
        } error:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideYiProgressHUD];
                
            });
        } completed:^{
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
         
        } error:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideYiProgressHUD];
                
            });
        } completed:^{
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
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"] isEqualToString:_userModel.login]) {
        return;
    }

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

- (void)loadDataFromApiWithIsFirst:(BOOL)isFirst
{
    [userDetailViewModel loadDataFromApiWithIsFirst:isFirst currentIndex:currentIndex firstTableData:^(DataSourceModel* DsOfPageListObject){
        userDetailDataSource.DsOfPageListObject1=DsOfPageListObject;
        
        [tableView reloadData];
        
        if (!isFirst) {
            
            [refreshFooter endRefreshing];
            
            
        }else
        {
            [refreshHeader endRefreshing];
        }
        
        
        
    } secondTableData:^(DataSourceModel* DsOfPageListObject){
        userDetailDataSource.DsOfPageListObject2=DsOfPageListObject;
        
        
        [tableView reloadData];
        
        if (!isFirst) {
            
            [refreshFooter endRefreshing];
            
            
        }else
        {
            [refreshHeader endRefreshing];
        }
        
        
    } thirdTableData:^(DataSourceModel* DsOfPageListObject){
        userDetailDataSource.DsOfPageListObject3=DsOfPageListObject;
        
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex==1) {
        return RepositoriesTableViewCellheight;
    }else if (currentIndex==2){
        return RankTableViewCellHeight;
    }else if (currentIndex==3){
        return RankTableViewCellHeight;
    }
    return 1;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex==1) {
        RepositoryModel  *model = [(userDetailDataSource.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        RepositoryDetailViewController *viewController=[[RepositoryDetailViewController alloc] init];
        viewController.model=model;
        [self.navigationController pushViewController:viewController animated:YES];

    }else if (currentIndex==2){
        UserModel  *model = [(userDetailDataSource.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        UserDetailViewController *detail=[[UserDetailViewController alloc] init];
        
        detail.userModel=model;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (currentIndex==3){
        UserModel  *model = [(userDetailDataSource.DsOfPageListObject3.dsArray) objectAtIndex:indexPath.row];
        UserDetailViewController *detail=[[UserDetailViewController alloc] init];
        
        detail.userModel=model;
        [self.navigationController pushViewController:detail animated:YES];
    }

}




@end
