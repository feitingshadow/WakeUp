//
//  TrackHelper.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//


#import "TrackHelper.h"
#import "AppConstants.h"
#import "Settings.h"

@interface TrackHelper()
@property (strong, nonatomic) NSMutableArray * trackFileNames;
//@property (strong, nonatomic) NSArray * unlockedTrackFileNames;
@property (strong, nonatomic) NSDictionary * trackNameDictionary;
@end

@implementation TrackHelper

+ (TrackHelper*) sharedInstance {
    static TrackHelper * sharedInstance = nil;
        static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TrackHelper alloc] init];
        [sharedInstance privateInitialization];
    });
    return sharedInstance;
}

- (void) privateInitialization; {
    [self updateTracksArrayForUnlockedStatus];
    self.trackNameDictionary = @{TRACK_1_NAME:TRACK_1_FILENAME, UNL_TRACK_1_NAME:UNL_TRACK_1_FILENAME}; //and so on and so on.
}

- (NSInteger) getUnlockedNumberOfTracks;
{
    return self.trackFileNames.count;
}


- (void) updateTracksArrayForUnlockedStatus {
    self.trackFileNames = [[NSMutableArray alloc] initWithArray:@[TRACK_1_NAME]];
    
    if( [Settings getDidUnlockTracks] == YES) {
        [self.trackFileNames addObjectsFromArray:@[UNL_TRACK_1_NAME] ];
    }
}
@end
