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
#import "MeditationTrack.h"

#define KEY_FILENAME @"Filename"
#define KEY_TRACKNAME @"Name"
#define KEY_TRACKDESCRIPTION @"Description"

@interface TrackHelper()
@property (strong, nonatomic) NSMutableArray * trackFileNames; //unlocked tracks
@property (strong, nonatomic) NSMutableArray * meditationTracks; // all tracks

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

- (NSArray*) getTracks;
{
    return self.meditationTracks;
}

- (void) privateInitialization; {
    [self initializeTracks];
    
    [self updateTracksArrayForUnlockedStatus];
}


- (void) reloadTracks {
    NSDictionary * trackDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TrackInfo" ofType:@"plist"]];
    if(trackDictionary != nil) {
        NSArray * tracks = trackDictionary[@"Tracks"];
        self.meditationTracks = [NSMutableArray arrayWithCapacity:tracks.count];
        NSDictionary * individualDict = nil;
        MeditationTrack * medTrack = nil;
        
        NSString * tempMeditationName = nil;
        NSString * tempFileName = nil;
        NSString * tempDescription = nil;
        
        for(int i = 0; i < tracks.count; i++) {
            individualDict = tracks[i];
            tempMeditationName = individualDict[KEY_TRACKNAME];
            tempFileName = individualDict[KEY_FILENAME];
            tempDescription = individualDict[KEY_TRACKDESCRIPTION];
            if(tempMeditationName != nil && tempFileName != nil && tempDescription != nil) {
                medTrack = [[MeditationTrack alloc] initWithFileName:tempFileName trackname:tempMeditationName descr:tempDescription];
                [self.meditationTracks addObject:medTrack];
            }
            else { //Unit tests take care of these, erase.
                DLOG_ARGS(@"One key is nil for track %i in %@, %@, %@", i, tempMeditationName, tempFileName, tempDescription );
            }
        }
    } else {
        DLOG(@"Didn't get trackDictionary from path");
    }
}

- (void) initializeTracks {
    [self reloadTracks];
}

- (NSInteger) getNumberOfTracks;
{
    return self.meditationTracks.count;
}


- (void) updateTracksArrayForUnlockedStatus {
//    self.trackFileNames = [[NSMutableArray alloc] initWithArray:@[TRACK_1_NAME]];
    
    if( [Settings getDidUnlockTracks] == YES) {
        [self.trackFileNames addObjectsFromArray:@[UNL_TRACK_1_NAME] ];
    }
}

- (void) unloadAllTracks; //To test the load Speed
{
    self.meditationTracks = nil;
}

- (MeditationTrack*) trackAt:(int)index;
{ //TODO: Account for 0 to grab the daily meditation.
    return self.meditationTracks[index];
}

@end
