//
//  CoreSpotlightManager.h
//  Monkey
//
//  Created by coderyi on 16/8/11.
//  Copyright © 2016年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreSpotlightManager : NSObject
@property(nonatomic,copy) NSArray *data;
+ (CoreSpotlightManager *)sharedInstance;
- (void)resetIndexWithData:(NSArray *)data;

@end
