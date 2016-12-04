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
#import <UIKit/UIKit.h>

#define KEY_TRACK_INFO_PLIST @"TrackInfo"
#define KEY_FILENAME @"Filename"
#define KEY_TRACKNAME @"Name"
#define KEY_TRACKDESCRIPTION @"Description"
#define KEY_CHIME @"Chimes"
#define KEY_TRACK @"Tracks"

@interface TrackHelper()
@property (strong, nonatomic) NSMutableArray * trackFileNames; //unlocked tracks
@property (strong, nonatomic) NSMutableArray<MeditationTrack*> * meditationTracks; // all tracks
@property (strong, nonatomic) NSMutableArray<Chime*> * chimes; // all tracks

@end

@implementation TrackHelper

+ (TrackHelper*) sharedInstance {
    static TrackHelper * sharedInstance = nil;
        static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TrackHelper alloc] init];
        [sharedInstance privateInitialization];
        NSArray *fontFamilies = [UIFont familyNames];
        for (int i = 0; i < [fontFamilies count]; i++)
        {
            NSString *fontFamily = [fontFamilies objectAtIndex:i];
            NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
            NSLog (@"%@: %@", fontFamily, fontNames);
        }
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
    NSDictionary * trackDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:KEY_TRACK_INFO_PLIST ofType:@"plist"]];
    if(trackDictionary != nil) {
        NSArray<NSDictionary*> * tracks = trackDictionary[KEY_TRACK];
        NSArray<NSDictionary*> * chimeNames = trackDictionary[KEY_CHIME];
        self.meditationTracks = [NSMutableArray arrayWithCapacity:tracks.count];
        self.chimes = [NSMutableArray arrayWithCapacity:chimeNames.count];
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
        
        Chime * chime = nil;
        for(int i = 0; i < chimeNames.count; i++) {
            individualDict = chimeNames[i];
            tempFileName = individualDict[KEY_FILENAME];
            chime = [Chime new];
            chime.filename = tempFileName;
            [self.chimes addObject:chime];
            if(tempFileName == nil) {
                DLOG_ARGS(@"Could not find chime: %i", i);
            }
        }
    } else {
        DLOG(@"Didn't get trackDictionary from path");
    }
}

- (Chime*) chimeAt:(NSUInteger)chimeIndex;
{
    Chime * chime = nil;
    if(chimeIndex < self.chimes.count) {
        chime = self.chimes[chimeIndex];
    }
    return chime;
}

- (void) initializeTracks {
    [self reloadTracks];
}

- (NSInteger) getNumberOfTracks;
{
    return self.meditationTracks.count;
}


- (void) updateTracksArrayForUnlockedStatus {
//    if( [Settings getDidUnlockTracks] == YES) { }
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
