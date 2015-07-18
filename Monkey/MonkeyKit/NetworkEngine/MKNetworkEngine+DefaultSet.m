//
//  MKNetworkEngine+DefaultSet.m
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "MKNetworkEngine+DefaultSet.h"

@implementation MKNetworkEngine (DefaultSet)
- (id)initWithDefaultSet
{
    NSMutableDictionary *header=[NSMutableDictionary dictionaryWithObject:@"application/vnd.github.v3+json" forKey:@"Accept"];
    self = [self initWithHostName:@"api.github.com" customHeaderFields:header];
    
    return self;
}
@end
