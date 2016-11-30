//
//  AudioMgr.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "AudioMgr.h"
#import "AppConstants.h"

@implementation AudioMgr

+ (AudioMgr*) sharedInstance {
    static AudioMgr * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AudioMgr alloc] init];
        [sharedInstance privateInitialization];
    });
    return sharedInstance;
}

+ (CGFloat) getLengthOfAudioFileFromURL:(NSURL*)fileURL {
    NSError * error;
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    if(error != nil) {
        DLOG_ARGS(@"Error loading track is: %@", error);
    } else {
//        [player prepareToPlay];
    }
    return player.duration;
}

- (CGFloat) lengthOfTrack:(AVAudioPlayer*) player; {
    return player.duration;
}

- (void) setNextTrack:(NSURL *)fileURL {
    NSError * error;
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    currentAudioPlayer = player;
    if(error != nil) {
        DLOG_ARGS(@"Error loading track is: %@", error);
    } else {
        [player prepareToPlay];
    }
}

- (CGFloat) timeRemainingOnCurrentTrack;
{
    CGFloat remaining = 0.0f;
    if(currentAudioPlayer != nil) {
        remaining = currentAudioPlayer.duration - currentAudioPlayer.currentTime;
    }
    return remaining;
}

- (void) playTrack {
    [currentAudioPlayer play];
}

- (void) pauseCurrentTrack {
    [currentAudioPlayer pause];
}

- (void) stopTrack {
    [currentAudioPlayer stop];
}

- (void) privateInitialization {
    
}

//AVAudioPlayer

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
}

@end
