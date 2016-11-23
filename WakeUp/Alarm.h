//
//  Alarm.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alarm : NSObject <NSCoding>
{
    int weekdays[7];
}

@property (nonatomic, assign) int meditationTrackIndex;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) NSDate * time;

- (instancetype) initWithTime:(NSDate*)time trackIndex:(int)meditationIndex;

- (void) setDayOfWeek:(int)dayIndex toBeOn:(BOOL)isOn;
- (BOOL) getDayOfWeekIsOn:(int)dayOfWeek;

@end
