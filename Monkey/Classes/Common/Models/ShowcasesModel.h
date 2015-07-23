//
//  ShowcasesModel.h
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowcasesModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *slug;
@property(nonatomic,strong)NSString *showcasesDescription;
@property(nonatomic,strong)NSString *image_url;
+ (ShowcasesModel *)modelWithDict:(NSDictionary *)dict;
@end
