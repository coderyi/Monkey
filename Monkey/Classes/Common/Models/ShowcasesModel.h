//
//  ShowcasesModel.h
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowcasesModel : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *slug;
@property(nonatomic,copy) NSString *showcasesDescription;
@property(nonatomic,copy) NSString *image_url;
+ (ShowcasesModel *)modelWithDict:(NSDictionary *)dict;
@end
