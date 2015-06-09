//
//  UMRecorder.h
//  Feedback
//
//  Created by amoblin on 14/9/2.
//  Copyright (c) 2014年 umeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RecorderDelegate <NSObject>

@optional

- (void)updateDuration:(NSTimeInterval)interval;
- (void)audioPlayerDidFinishPlaying;
@end

@interface UMRecorder : NSObject

@property (strong, nonatomic) id<RecorderDelegate> delegate;
@property (strong, nonatomic)NSString *filePath;
@property (nonatomic)BOOL isRecording;
@property (nonatomic)BOOL isPlaying;
@property (nonatomic) NSTimeInterval duration;

@property (strong, nonatomic) NSString *currentReplyId;
@property (strong, nonatomic) NSData *audioData;

- (void)startRecording;
- (void)stopRecording;
- (void)cancelRecording;

- (void)setCurrentReplyId:(NSString *)currentReplyId;
- (void)saveFile;

- (void)startPlaybackWithReplyId:(NSString *)replyId;
- (void)stopPlayback;

@end
