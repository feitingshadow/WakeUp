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
}
+ (AudioMgr*) sharedInstance;
+ (CGFloat) getLengthOfAudioFileFromURL:(NSURL*)fileURL;
- (void) setNextTrack:(NSURL*)fileURL;

- (void) playTrack;
- (void) pauseCurrentTrack;
- (void) stopTrack;

@end
