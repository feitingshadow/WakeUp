//
//  AppModeManager.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/27/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "AppModeManager.h"
#import "AppConstants.h"

@interface AppModeManager()
{
    NSTimeInterval secondsSinceSnoozeTapped;
}

@property (nonatomic, strong) Alarm * currentAlarm;
@property (nonatomic, strong) NSTimer * snoozeTickTimer;

@end

@implementation AppModeManager


+ (AppModeManager*) sharedInstance; //For handling the delegate methods, like fire when app is still active.
{
    static AppModeManager * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppModeManager alloc] init];
        [sharedInstance innerInitialize];
    });
    return sharedInstance;
}

- (void) innerInitialize {
    [self changeMode:AppModeNotPlaying];
}

- (void) startPlayingAlarm:(Alarm*)alarm; {
    [self stopSnoozeTimer];
    NSURL * alarmURL = [[TrackHelper sharedInstance] trackAt:alarm.meditationTrackIndex].fileURL;
    [[AudioMgr sharedInstance] stopTrack]; //Stop any previous track, ux assume
    [[AudioMgr sharedInstance] setNextTrack:alarmURL];
    [[AudioMgr sharedInstance] playTrack];
    self.currentAlarm = alarm;
    [self changeMode:AppModePlaying];
}

- (void) snooze; {
    if(_currentAppMode == AppModePlaying) {
        [[AudioMgr sharedInstance] pauseCurrentTrack];
        [self changeMode:AppModeSnooze];
        [self performSelector:@selector(unpauseSnooze:) withObject:nil afterDelay:FIVE_MINUTES];
    }
}

- (void) stopPlaying; {
    [self stopSnoozeTimer];
    [[AudioMgr sharedInstance] stopTrack];
    self.currentAlarm = nil;
    [self changeMode:AppModeNotPlaying];
}

- (void) changeMode:(AppMode) toMode;
{
    _currentAppMode = toMode;
    if(self.appModeDelegate != nil) {
        [self.appModeDelegate AppModeManager:self didChangeToMode:toMode];
    }
}

- (void) unpauseSnooze:(id)obj {
    if(_currentAppMode == AppModeSnooze && self.currentAlarm != nil) {
        [self startPlayingAlarm:self.currentAlarm];
    }
}

- (void) stopSnoozeTimer; {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
