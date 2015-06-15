//
//  RankViewController.m
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "RankViewController.h"
#import "UserModel.h"
#import "RankTableViewCell.h"
#import "HeaderSegmentControl.h"
#import "CityViewController.h"
@interface RankViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIScrollView *scrollView;
    int currentIndex;
    UITableView *tableView1;
    UITableView *tableView2;
    float titleHeight;
    float bgViewHeight;
    HeaderSegmentControl *segmentControl;
    YiRefreshHeader *refreshHeader1;
    YiRefreshFooter *refreshFooter1;
    
    YiRefreshHeader *refreshHeader2;
    YiRefreshFooter *refreshFooter2;
    
}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property (strong, nonatomic) MKNetworkOperation *apiOperation;
@end

@implementation RankViewController
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
-(void)viewWillAppear:(BOOL)animated{
    NSString *cityAppear=[[NSUserDefaults standardUserDefaults] objectForKey:@"cityAppear"];
    if ([cityAppear isEqualToString:@"2"]) {
        [segmentControl swipeAction:102];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cityAppear"];
        [refreshHeader2 beginRefreshing];
        NSString *city=[[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
        if (city==nil || city.length<1) {
            city=@"北京";
        }
        
        [segmentControl.button2 setTitle:city forState:UIControlStateNormal];
        
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
     
    }
    self.view.backgroundColor=[UIColor whiteColor];
    titleHeight=35;
    bgViewHeight=HScreen-64-titleHeight-49;
       [self initScroll];
    self.automaticallyAdjustsScrollViewInsets=NO;
//    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, bgViewHeight) style:UITableViewStylePlain ];
//    [scrollView addSubview:tableView1];
//    
//    tableView1.delegate=self;
//    tableView1.dataSource=self;
   
  
    
    segmentControl=[[HeaderSegmentControl alloc] initWithFrame:CGRectMake(0, 0, WScreen, titleHeight)];
    [self.view addSubview:segmentControl];
    segmentControl.buttonCount=2;
   currentIndex=1;
    
     [self initTable];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"城市" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem=right;
    
    

}
-(void)rightAction{
    CityViewController *city=[[CityViewController alloc] init];
    [self.navigationController pushViewController:city animated:YES];
    

}
-(void)initScroll{
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleHeight, WScreen, bgViewHeight)];
    scrollView.alwaysBounceHorizontal=YES;
    scrollView.backgroundColor=[UIColor whiteColor];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    [scrollView setContentSize:CGSizeMake(WScreen * (2), bgViewHeight)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [scrollView scrollRectToVisible:CGRectMake(0,0,WScreen,bgViewHeight) animated:NO];
    
}

-(void)initTable{
    
    
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, bgViewHeight) style:UITableViewStylePlain];
    [scrollView addSubview:tableView1];
//    tableView1.showsVerticalScrollIndicator = NO;
    
    tableView1.dataSource=self;
    tableView1.delegate=self;
    tableView1.tag=11;
    tableView1.rowHeight=90.7;
    tableView1.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addHeader:1];
    [self addFooter:1];

    
    
    segmentControl.ButtonActionBlock=^(int buttonTag){
        
        currentIndex=buttonTag-100;
        [scrollView scrollRectToVisible:CGRectMake(WScreen * (currentIndex-1),0,WScreen,bgViewHeight) animated:NO];
        [scrollView setContentOffset:CGPointMake(WScreen* (currentIndex-1),0)];
        
        if (currentIndex==1) {
            
            
        }else if (currentIndex==2){
            if (tableView2==nil) {
                tableView2=[[UITableView alloc] initWithFrame:CGRectMake(WScreen, 0, WScreen, bgViewHeight) style:UITableViewStylePlain];
                [scrollView addSubview:tableView2];
                tableView2.showsVerticalScrollIndicator = NO;
                
                tableView2.tag=12;
                tableView2.dataSource=self;
                tableView2.delegate=self;
                tableView2.separatorStyle=UITableViewCellSeparatorStyleNone;
                tableView2.rowHeight=90.7;
                [self addHeader:2];
                [self addFooter:2];
                
            }
            
        }else if (currentIndex==3){
      
            
        }else if (currentIndex==4){

        }
    };
    
    currentIndex=1;
    
    
}
#pragma mark scrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pagewidth/ (2)) / pagewidth) + 1;
    
    if (currentPage==0)
    {
        
        [scrollView scrollRectToVisible:CGRectMake(0,0,WScreen,bgViewHeight) animated:NO];
        [scrollView setContentOffset:CGPointMake(0,0)];
    }
    else if (currentPage>=(1))
    {
        currentPage=1;
        [scrollView scrollRectToVisible:CGRectMake(WScreen * 1,0,WScreen,bgViewHeight) animated:NO];
        [scrollView setContentOffset:CGPointMake(WScreen* 1,0)];
    }
    
    currentIndex=currentPage+1;
    NSLog(@"cccc %d",currentIndex);
    [segmentControl swipeAction:(100+currentPage+1)];
    
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
    RankTableViewCell *cell;
     if (tableView.tag==11) {
    NSString *cellId=@"CellId1";
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
         return cell;

     }else if (tableView.tag==12){
     
         NSString *cellId=@"CellId2";
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
     
     }
    return cell;
    

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
    
        [refreshHeader1 beginRefreshing];
    }else if (type==2){
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader2=[[YiRefreshHeader alloc] init];
        refreshHeader2.scrollView=tableView2;
        [refreshHeader2 header];
        refreshHeader2.beginRefreshingBlock=^(){
            [self loadDataFromApiWithIsFirst:YES];
            
            
            
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader2 beginRefreshing];
        
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
{
    if (currentIndex==1) {
    
    NSInteger page = 0;
    
    if (isFirst) {
        page = 1;
        
    }else{
        
        page = self.DsOfPageListObject1.page+1;
    }
    
    [ApplicationDelegate.apiEngine searchUsersWithPage:page  q:@"location:china" sort:@"followers" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
        
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
 
  
    
    
        return YES;}else if (currentIndex==2){
        
            NSInteger page = 0;
            
            if (isFirst) {
                page = 1;
                
            }else{
                
                page = self.DsOfPageListObject2.page+1;
            }
            NSString *city=[[NSUserDefaults standardUserDefaults] objectForKey:@"pinyinCity"];
            if (city==nil || city.length<1) {
                city=@"beijing";
            }
            [ApplicationDelegate.apiEngine searchUsersWithPage:page  q:[NSString stringWithFormat:@"location:%@",city] sort:@"followers" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
                
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
        
        }
    return YES;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
