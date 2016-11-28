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
@property (nonatomic, strong, readonly) NSString * uuid;

- (instancetype) initWithTime:(NSDate*)time trackIndex:(int)meditationIndex;
+ (instancetype) alarm;
+ (instancetype) alarmWithHour:(int)hr minutes:(int)minutes;
+ (instancetype) alarmWithHour:(int)hr minutes:(int)minutes trackIndex:(int)index;

- (void) setDayOfWeek:(int)dayIndex toBeOn:(BOOL)isOn;
- (BOOL) getDayOfWeekIsOn:(int)dayOfWeek;

@end
