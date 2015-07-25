
//
//  TrendingViewModel.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "TrendingViewModel.h"
@interface TrendingViewModel(){
    NSString *language;
    
}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;
@property(nonatomic,strong)NSString *tableView1Language;
@property(nonatomic,strong)NSString *tableView2Language;
@property(nonatomic,strong)NSString *tableView3Language;

@end
@implementation TrendingViewModel

@synthesize tableView1Language,tableView2Language,tableView3Language;
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.DsOfPageListObject1 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject2 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject3 = [[DataSourceModel alloc]init];
    }
    return self;
}
- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst currentIndex:(int)currentIndex firstTableData:(DataSourceModelResponseBlock)firstCompletionBlock secondTableData:(DataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(DataSourceModelResponseBlock)thirdCompletionBlock
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
            firstCompletionBlock(self.DsOfPageListObject1);
//            trendingDataSource.DsOfPageListObject1=self.DsOfPageListObject1;
//            [tableView1 reloadData];
//            if (!isFirst) {
//                [refreshFooter1 endRefreshing];
//            }else
//            {
//                [refreshHeader1 endRefreshing];
//            }
            
        }
                                        errorHandel:^(NSError* error){
                                            firstCompletionBlock(self.DsOfPageListObject1);

//                                            if (isFirst) {
//                                                [refreshHeader1 endRefreshing];
//  
//                                            }else{
//                                                [refreshFooter1 endRefreshing];
//                                                
//                                            }
                                            
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
            secondCompletionBlock(self.DsOfPageListObject2);

//            trendingDataSource.DsOfPageListObject2=self.DsOfPageListObject2;
//
//            [tableView2 reloadData];
//            
//            if (!isFirst) {
//                
//                [refreshFooter2 endRefreshing];
//                
//                
//            }else
//            {
//                [refreshHeader2 endRefreshing];
//            }
            
        }
                                        errorHandel:^(NSError* error){
                                            secondCompletionBlock(self.DsOfPageListObject2);

//                                            if (isFirst) {
//                                                
//                                                [refreshHeader2 endRefreshing];
//                                                
//                                                
//                                                
//                                                
//                                            }else{
//                                                [refreshFooter2 endRefreshing];
//                                                
//                                            }
                                            
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
            thirdCompletionBlock(self.DsOfPageListObject3);

//            trendingDataSource.DsOfPageListObject3=self.DsOfPageListObject3;
//
//            [tableView3 reloadData];
//            
//            if (!isFirst) {
//                
//                [refreshFooter3 endRefreshing];
//                
//                
//            }else
//            {
//                [refreshHeader3 endRefreshing];
//            }
            
        }
                                        errorHandel:^(NSError* error){
                                            thirdCompletionBlock(self.DsOfPageListObject3);

//                                            if (isFirst) {
//                                                
//                                                [refreshHeader3 endRefreshing];
//                                                
//                                                
//                                                
//                                                
//                                            }else{
//                                                [refreshFooter3 endRefreshing];
//                                                
//                                            }
                                            
                                        }];
        
        
        
        
        return YES;
        
    }
    return YES;
    
}




@end
