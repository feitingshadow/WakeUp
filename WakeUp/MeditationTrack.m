//
//  MeditationTrack.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "MeditationTrack.h"
#import "AppConstants.h"
#import "AudioMgr.h"

@interface MeditationTrack()
@property (nonatomic, copy) NSString * filePath;
@property (nonatomic, copy) NSURL * fileURL;
@end

@implementation MeditationTrack

- (instancetype) initWithFileName:(NSString*)fileName trackname:(NSString*)trackName descr:(NSString*)description {
    
    self = [super init];
    if(self) {
        self.fileName = fileName; self.trackName = trackName;
        self.trackDescription = description;
        self.filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@""];
        self.fileURL = [NSURL fileURLWithPath:self.filePath isDirectory:NO];
        _lengthInSeconds = [AudioMgr getLengthOfAudioFileFromURL:self.fileURL];
//        _lengthInSeconds = 0; //todo, load the file or its metadata.
    }
    return self;
}

- (NSString*) lengthInStringFormat;
{
    //This is a rough, inefficient implementation, should use a number formatter or decimal formatting
    //Will update when length is grabbed from the track.
    NSString * length = @"0:00";
    if(_lengthInSeconds > 0) {
        int seconds = (int)_lengthInSeconds % SECONDS_PER_MINUTE;
        int minutes = (int)_lengthInSeconds / SECONDS_PER_MINUTE;
        
        length = [NSString stringWithFormat:@"%i:", minutes];
        if(seconds < 10) {
            length = [length stringByAppendingString:@"0"];
        }
        length = [length stringByAppendingString:[NSString stringWithFormat:@"%i",seconds]];
    }
    return length;
}

@end
