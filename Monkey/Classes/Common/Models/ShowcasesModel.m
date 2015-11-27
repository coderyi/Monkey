//
//  ShowcasesModel.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "ShowcasesModel.h"

@implementation ShowcasesModel

+ (ShowcasesModel *)modelWithDict:(NSDictionary *)dict
{
    if (!dict) {
        return Nil;
    }
    
    ShowcasesModel *model = [[ShowcasesModel alloc]init];
    model.name = [dict objectForKey:@"name"] ;
    model.slug = [dict objectForKey:@"slug"] ;
    model.showcasesDescription = [dict objectForKey:@"description"] ;
    model.image_url = [dict objectForKey:@"image_url"] ;
  
    return model;
}

@end
