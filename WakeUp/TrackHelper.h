//
//  TrackHelper.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackHelper : NSObject
{
    
}

+ (TrackHelper*) sharedInstance;

- (NSInteger) getUnlockedNumberOfTracks;
- (void) updateTracksArrayForUnlockedStatus;

@end
