//
//  Alarm.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "Alarm.h"
#import "AppConstants.h"

#define KEY_ENCODER_DATE @"Date"
#define KEY_ENCODER_INDEX @"Index"
#define KEY_ENCODER_ACTIVE @"Active"
#define KEY_ENCODER_DAY(X) [NSString stringWithFormat:@"Day=%i",(X)]

@implementation Alarm

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.time forKey:KEY_ENCODER_DATE];
    [aCoder encodeInteger:self.meditationTrackIndex forKey:KEY_ENCODER_INDEX];
    [aCoder encodeBool:self.active forKey:KEY_ENCODER_ACTIVE];
    for(int i = 0; i < DAYS_PER_WEEK; i++) {
        [aCoder encodeInteger:weekdays[i]  forKey:KEY_ENCODER_DAY(i)];
    }
    
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        self.time = [aDecoder decodeObjectForKey: KEY_ENCODER_DATE];
        self.meditationTrackIndex = [aDecoder decodeIntegerForKey: KEY_ENCODER_INDEX];
        self.active = [aDecoder decodeBoolForKey: KEY_ENCODER_ACTIVE];
        for(int i = 0; i < DAYS_PER_WEEK; i++) {
            weekdays[i] =[aDecoder decodeIntegerForKey: KEY_ENCODER_DAY(i)];
        }
    }
    return self;
}

- (instancetype) initWithTime:(NSDate*)timeToStart trackIndex:(int)meditationIndex; {
    self = [super init];
    if(self) {
        self.time = timeToStart;
        self.meditationTrackIndex = meditationIndex;
        for(int i = 0; i < DAYS_PER_WEEK; i++) {
            weekdays[i] = 0;
        }
    }
    return self;
}

- (void) setDayOfWeek:(int)dayIndex toBeOn:(BOOL)isOn; {
    weekdays[dayIndex] = (isOn ? 1 : 0);
}

- (BOOL) getDayOfWeekIsOn:(int)dayOfWeek; {
    return weekdays[dayOfWeek] > 0;
}
@end
