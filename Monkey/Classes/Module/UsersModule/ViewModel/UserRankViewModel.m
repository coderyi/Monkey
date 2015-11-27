//
//  UserRankViewModel.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserRankViewModel.h"
@interface UserRankViewModel(){
    NSString *language;
    
}
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong)DataSourceModel *DsOfPageListObject3;
@property(nonatomic,strong)NSString *tableView1Language;
@property(nonatomic,strong)NSString *tableView2Language;
@property(nonatomic,strong)NSString *tableView3Language;

@end

@implementation UserRankViewModel
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

- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst  currentIndex:(int)currentIndex firstTableData:(UserRankDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(UserRankDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(UserRankDataSourceModelResponseBlock)thirdCompletionBlock
{
    
    if (currentIndex==1){
        
        NSInteger page = 0;
        
        if (isFirst) {
            page = 1;
            
        }else{
            
            page = self.DsOfPageListObject1.page+1;
        }
        NSString *city=[[NSUserDefaults standardUserDefaults] objectForKey:@"pinyinCity"];
        city=[city stringByReplacingOccurrencesOfString:@" "  withString:@"%2B"];
        if (city==nil || city.length<1) {
            city=@"beijing";
        }
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
        NSString *q=[NSString stringWithFormat:@"location:%@+language:%@",city,language];
        
        if (language==nil || language.length<1) {
            language=NSLocalizedString(@"all languages", @"");
            
        }
        tableView1Language=language;
        
        if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
            q=[NSString stringWithFormat:@"location:%@",city];
        }
        
        [ApplicationDelegate.apiEngine searchUsersWithPage:page  q:q sort:@"followers" categoryLocation:city categoryLanguage:language completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            
            self.DsOfPageListObject1.totalCount=totalCount;
            
            if (page<=1) {
                [self.DsOfPageListObject1.dsArray removeAllObjects];
            }

            [self.DsOfPageListObject1.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject1.page=page;
            firstCompletionBlock(self.DsOfPageListObject1);

            
        }
                                               errorHandel:^(NSError* error){
                                                   firstCompletionBlock(self.DsOfPageListObject1);
                                                   
                                               }];
        
        return YES;
        
    }else if (currentIndex==2) {
        
        NSInteger page = 0;
        
        if (isFirst) {
            page = 1;
            
        }else{
            
            page = self.DsOfPageListObject2.page+1;
        }
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
        NSString *country=[[NSUserDefaults standardUserDefaults] objectForKey:@"country"];
        if (country==nil || country.length<1) {
            country=@"China";
        }
        NSString *q=[NSString stringWithFormat:@"location:%@+language:%@",country,language];
        
        if (language==nil || language.length<1) {
            language=NSLocalizedString(@"all languages", @"");
            
        }
        tableView2Language=language;
        
        if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
            q=[NSString stringWithFormat:@"location:%@",country];
        }
        
        [ApplicationDelegate.apiEngine searchUsersWithPage:page  q:q sort:@"followers" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            self.DsOfPageListObject2.totalCount=totalCount;

            if (page<=1) {
                [self.DsOfPageListObject2.dsArray removeAllObjects];
            }

            [self.DsOfPageListObject2.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject2.page=page;
            secondCompletionBlock(self.DsOfPageListObject2);
            
        }
                                               errorHandel:^(NSError* error){
                                                   secondCompletionBlock(self.DsOfPageListObject2);

                                               }];
     
        return YES;
    }else if (currentIndex==3){
        
        NSInteger page = 0;
        
        if (isFirst) {
            page = 1;
            
        }else{
            
            page = self.DsOfPageListObject3.page+1;
        }
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
        if (language==nil || language.length<1) {
            language=NSLocalizedString(@"all languages", @"");
            
        }
        tableView3Language=language;
        [ApplicationDelegate.apiEngine searchUsersWithPage:page  q:[NSString stringWithFormat:@"language:%@",language] sort:@"followers" completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
            
            self.DsOfPageListObject3.totalCount=totalCount;
            
            if (page<=1) {
                [self.DsOfPageListObject3.dsArray removeAllObjects];
            }
            
            [self.DsOfPageListObject3.dsArray addObjectsFromArray:modelArray];
            self.DsOfPageListObject3.page=page;
            thirdCompletionBlock(self.DsOfPageListObject3);

            
        }
                                               errorHandel:^(NSError* error){
                                                   thirdCompletionBlock(self.DsOfPageListObject3);
   
                                               }];

        return YES;
        
    }
    return YES;
    
}

@end
