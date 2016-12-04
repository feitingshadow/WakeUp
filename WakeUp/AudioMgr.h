//
//  AudioMgr.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@interface AudioMgr : NSObject <AVAudioPlayerDelegate>
{
    AVAudioPlayer * currentAudioPlayer;
    BOOL isPaused;
    BOOL isStopped;
}
+ (AudioMgr*) sharedInstance;
+ (CGFloat) getLengthOfAudioFileFromURL:(NSURL*)fileURL;
- (void) setNextTrack:(NSURL*)fileURL;

- (AVAudioPlayer*) getCurrentAudioPlayer;
- (BOOL) isPaused;
- (BOOL) isStopped;
- (void) playTrack;
- (void) pauseCurrentTrack;
- (void) stopTrack;

- (CGFloat) timeRemainingOnCurrentTrack;

@end
