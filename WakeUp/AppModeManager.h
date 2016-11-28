//
//  AppModeManager.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/27/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"
#import "TrackHelper.h"
#import "AudioMgr.h"

typedef NS_ENUM(NSUInteger, AppMode) {
    AppModeNotPlaying,
    AppModePlaying,
    AppModeSnooze
};

@class AppModeManager;

@protocol AppModeManagerDelegate <NSObject>
@required
- (void) AppModeManager:(AppModeManager*)appModeManager didChangeToMode:(AppMode)theMode;
@end

@interface AppModeManager : NSObject {
    
}

@property (nonatomic, readonly) AppMode currentAppMode;
@property (nonatomic, strong, readonly) Alarm * currentAlarm;
@property (nonatomic, weak) id<AppModeManagerDelegate> appModeDelegate;

+ (AppModeManager*) sharedInstance;

- (void) startPlayingAlarm:(Alarm*)alarm;
- (void) snooze;
- (void) stopPlaying;

@end
