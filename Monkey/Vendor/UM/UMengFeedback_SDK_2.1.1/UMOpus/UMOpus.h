//
//  UMOpus.h
//  UMFeedback
//
//  Created by amoblin on 14/12/16.
//
//

#import <Foundation/Foundation.h>

// record settings
#define SAMPLE_RATE 16000
#define NUM_CHANNEL 1       // will got a fast mp3 when this is 1.
#define BIT_RATE 16000
#define OUT_SAMPLE_RATE 8000

#define TIME_LIMIT 1

#define FRAME_SIZE 960
#define APPLICATION OPUS_APPLICATION_AUDIO


#define CHANNEL_NUM 1
#define BIT_PER_SAMPLE 16
#define WB_FRAME_SIZE 320


@interface UMOpus : NSObject

+ (void)setAudioEnable:(BOOL)isEnabled;
+ (UMOpus *)sharedInstance;

- (NSData *)wavToOpus:(NSData *)data;
- (BOOL)isAudioEnabled;
@end
