
//
//  TrendingViewModel.m
//  Monkey
//
//  Created by coderyi on 15/7/25.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "TrendingViewModel.h"
@interface TrendingViewModel() {
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
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language2"];
        if (language==nil || language.length<1) {
            language=NSLocalizedString(@"all languages", @"");
        }
        tableView2Language=language;
        [networkEngine repositoriesTrendingWithType:@"weekly" language:language completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
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
        language=[[NSUserDefaults standardUserDefaults] objectForKey:@"language2"];
        if (language==nil || language.length<1) {
            language=NSLocalizedString(@"all languages", @"");
        }
        tableView3Language=language;
        [networkEngine repositoriesTrendingWithType:@"monthly" language:language completoinHandler:^(NSArray* modelArray,NSInteger page,NSInteger totalCount){
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
