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
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    UITableView *tableView1;
    UITableView *tableView2;
    int currentIndex;
    YiRefreshHeader *refreshHeader1;
    YiRefreshFooter *refreshFooter1;
    
    YiRefreshHeader *refreshHeader2;
    YiRefreshFooter *refreshFooter2;
    UISearchBar *searchBar;
    SearchSegmentControl *searchSegment;
    UILabel *titleText;
}
@property (strong, nonatomic) MKNetworkOperation *apiOperation;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;

@end

@implementation SearchViewController
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
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cityAppear"];
    [self.navigationController.navigationBar addSubview:searchBar];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    [searchBar removeFromSuperview];
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
    titleText.text=@"Search";
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    searchSegment=[[SearchSegmentControl alloc] initWithFrame:CGRectMake(0, 0, WScreen, 30)];
    [self.view addSubview:searchSegment];
    currentIndex=1;
    
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 30, WScreen, HScreen-64-30) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    tableView1.dataSource=self;
    tableView1.delegate=self;
    [self addHeader:1];
    [self addFooter:1];
    tableView1.tag=11;
    searchSegment.ButtonActionBlock=^(int buttonTag){
        currentIndex=buttonTag-100;
        
        
        if (currentIndex==1) {
            tableView1.hidden=NO;
            tableView2.hidden=YES;
        }else if (currentIndex==2){
            if (tableView2==nil) {
                tableView2=[[UITableView alloc] initWithFrame:CGRectMake(0, 30, WScreen, HScreen-64-30) style:UITableViewStylePlain];
                [self.view addSubview:tableView2];
                
                tableView2.tag=12;
                tableView2.dataSource=self;
                tableView2.delegate=self;
                [self addHeader:2];
                [self addFooter:2];
                
            }
            tableView1.hidden=YES;
            tableView2.hidden=NO;
        }
        
        
        
        
     };
    self.navigationItem.hidesBackButton =YES;
    
    searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(10, 2, WScreen-60, 40)];
    [self.navigationController.navigationBar addSubview:searchBar];
    
    searchBar.delegate=self;
//    searchBar.backgroundColor=[UIColor clearColor];
    searchBar.tintColor=YiBlue;

    [searchBar becomeFirstResponder];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem=right;
}
-(void)rightAction{
    [searchBar removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
    


#pragma mark  searchdelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search  button");
    [self loadDataFromApiWithIsFirst:YES];
    [searchBar endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==11) {
        
        
        return self.DsOfPageListObject1.dsArray.count;
        
    }else if (tableView.tag==12){
        
        
        return self.DsOfPageListObject2.dsArray.count;
    }
    
    return self.DsOfPageListObject1.dsArray.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (tableView.tag==11) {
        NSString *cellId=@"CellId1";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        UserModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];

        cell.textLabel.text=model.login;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:nil];
        cell.imageView.layer.masksToBounds=YES;
        cell.imageView.layer.cornerRadius=8;
//
//        cell.imageView.image=[UIImage imageNamed:@"github"];
        return cell;
        
    }else if (tableView.tag==12){
        
        NSString *cellId=@"CellId2";
        cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        RepositoryModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        
        cell.textLabel.text=model.full_name;
        cell.detailTextLabel.text=model.language;
        return cell;
        
    }
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==11) {
        UserDetailViewController *detail=[[UserDetailViewController alloc] init];

        UserModel  *model = [(self.DsOfPageListObject1.dsArray) objectAtIndex:indexPath.row];
        
        detail.userModel=model;
        [self.navigationController pushViewController:detail animated:YES];

    }else  if (tableView.tag==12) {
        RepositoryDetailViewController *detail=[[RepositoryDetailViewController alloc] init];

        RepositoryModel  *model = [(self.DsOfPageListObject2.dsArray) objectAtIndex:indexPath.row];
        
        detail.model=model;
        [self.navigationController pushViewController:detail animated:YES];

        
    }
    
    
}



- (void)addHeader:(int)type
{
    if (type==1) {
        
        
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader1=[[YiRefreshHeader alloc] init];
        refreshHeader1.scrollView=tableView1;
        [refreshHeader1 header];
        refreshHeader1.beginRefreshingBlock=^(){
            [self loadDataFromApiWithIsFirst:YES];
            
            
            
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
//        [refreshHeader1 beginRefreshing];
    }else if (type==2){
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader2=[[YiRefreshHeader alloc] init];
        refreshHeader2.scrollView=tableView2;
        [refreshHeader2 header];
        refreshHeader2.beginRefreshingBlock=^(){
            [self loadDataFromApiWithIsFirst:YES];
            
            
            
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
//        [refreshHeader2 beginRefreshing];
        
    }
}

- (void)addFooter:(int)type
{
    if (type==1) {
        
        
        //    YiRefreshFooter  底部刷新按钮的使用
        refreshFooter1=[[YiRefreshFooter alloc] init];
        refreshFooter1.scrollView=tableView1;
        [refreshFooter1 footer];
        refreshFooter1.beginRefreshingBlock=^(){
            
            [self loadDataFromApiWithIsFirst:NO];
        };}else if (type==2){
            
            //    YiRefreshFooter  底部刷新按钮的使用
            refreshFooter2=[[YiRefreshFooter alloc] init];
            refreshFooter2.scrollView=tableView2;
            [refreshFooter2 footer];
            refreshFooter2.beginRefreshingBlock=^(){
                
                [self loadDataFromApiWithIsFirst:NO];
            };
            
        }}

- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst
{ NSString *text=searchBar.text;
    if (text!=nil) {
        
   
     if (currentIndex==1){
        
        NSInteger page = 0;
        
        if (isFirst) {
            page = 1;
            
        }else{
            
            page = self.DsOfPageListObject1.page+1;
        }
        
        
        [ApplicationDelegate.apiEngine searchUsersWithPage:page  q:text sort:@"followers" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            self.DsOfPageListObject1.totalCount=totalCount;
            
            if (page<=1) {
                [self.DsOfPageListObject1.dsArray removeAllObjects];
            }
            
            
            //        [self hideHUD];
            
            [self.DsOfPageListObject1.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject1.page=page;
            [refreshHeader1 endRefreshing];
            
            if (page>1) {
                
                [refreshFooter1 endRefreshing];
                
                
            }else
            {
                [refreshHeader1 endRefreshing];
            }
            [tableView1 reloadData];
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
        
        [ApplicationDelegate.apiEngine searchRepositoriesWithPage:page  q:text sort:@"stars" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            
            if (page<=1) {
                [self.DsOfPageListObject2.dsArray removeAllObjects];
            }
            
            
            //        [self hideHUD];
            
            [self.DsOfPageListObject2.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject2.page=page;
            [refreshHeader2 endRefreshing];
            
            if (page>1) {
                
                [refreshFooter2 endRefreshing];
                
                
            }else
            {
                [refreshHeader2 endRefreshing];
            }
            [tableView2 reloadData];
        }
                                                      errorHandel:^(NSError* error){
                                                          if (isFirst) {
                                                              
                                                              [refreshHeader2 endRefreshing];
                                                              
                                                              
                                                              
                                                              
                                                          }else{
                                                              [refreshFooter2 endRefreshing];
                                                              
                                                          }
                                                          
                                                      }];
        
        
        
        
        return YES;
} }
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
