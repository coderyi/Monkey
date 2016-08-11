//
//  CoreSpotlightManager.m
//  Monkey
//
//  Created by coderyi on 16/8/11.
//  Copyright © 2016年 www.coderyi.com. All rights reserved.
//

#import "CoreSpotlightManager.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import "RepositoryModel.h"

@interface CoreSpotlightManager ()
@end

@implementation CoreSpotlightManager
+ (CoreSpotlightManager *)sharedInstance
{
    static CoreSpotlightManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)resetIndexWithData:(NSArray *)data;
{
    self.data=data;
    [[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Removed everything from index");
            
            [self createIndex];
            
        } else {
            NSLog(@"Failed to remove from index with error %@",error);
        }
    }];
}

- (void)createIndex
{
    [self addPodcastToIndex];
}

- (void)addPodcastToIndex
{
    for (NSUInteger i = 1; i < self.data.count; i++) {
        RepositoryModel *model=self.data[i];
        [self addEpisodeToIndexWithEpisodeNumber:model];
    }
}

- (void)addEpisodeToIndexWithEpisodeNumber:(RepositoryModel *)model
{
    NSString *episodeTitle = model.name;//title
    
    CSSearchableItemAttributeSet *attributes = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"monkey"];
    attributes.title = episodeTitle;
    attributes.contentDescription = model.repositoryDescription;//content
    UIImageView *tempImageView=[[UIImageView alloc] init];

    [tempImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url]];

    attributes.thumbnailData = UIImagePNGRepresentation(tempImageView.image);
    
    
    NSString *identifier = [NSString stringWithFormat:@"%@.%@",model.user.login,model.name];
    NSString *domain = [NSString stringWithFormat:@"%@.%@",model.user.login,model.name];
    
    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:identifier
                                                               domainIdentifier:domain
                                                                   attributeSet:attributes];
    
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item] completionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Added %@ to index", episodeTitle);
        } else {
            NSLog(@"Failed to index %@ with error %@", episodeTitle, error);
        }
    }];
}
@end
