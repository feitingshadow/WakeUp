//
//  Alarm.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "Alarm.h"
#import "AppConstants.h"
#import "DateUtility.h"
#import <UserNotifications/UserNotifications.h>

#define KEY_ENCODER_DATE @"Date"
#define KEY_ENCODER_INDEX @"Index"
#define KEY_ENCODER_ACTIVE @"Active"
#define KEY_ENCODER_UUID @"uuid"
#define KEY_ENCODER_DAY(X) [NSString stringWithFormat:@"Day=%i",(X)]

@interface Alarm()
@property (nonatomic, copy) NSString * uuid;
@end

@implementation Alarm

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.time forKey:KEY_ENCODER_DATE];
    [aCoder encodeObject:self.uuid forKey:KEY_ENCODER_UUID];
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
        self.uuid = [aDecoder decodeObjectForKey: KEY_ENCODER_UUID];
        self.meditationTrackIndex = [aDecoder decodeIntegerForKey: KEY_ENCODER_INDEX];
        self.active = [aDecoder decodeBoolForKey: KEY_ENCODER_ACTIVE];
        for(int i = 0; i < DAYS_PER_WEEK; i++) {
            weekdays[i] =[aDecoder decodeIntegerForKey: KEY_ENCODER_DAY(i)];
        }
        //Ensure uuid
        if(self.uuid == nil) {
            self.uuid = [[NSUUID UUID] UUIDString];
        }
    }
    return self;
}

- (instancetype) initWithTime:(NSDate*)timeToStart trackIndex:(int)meditationIndex; {
    self = [super init];
    if(self) {
        self.uuid = [[NSUUID UUID] UUIDString];
        self.time = timeToStart;
        self.meditationTrackIndex = meditationIndex;
        for(int i = 0; i < DAYS_PER_WEEK; i++) {
            weekdays[i] = 1;
        }
    }
    return self;
}

+ (instancetype) alarm; {
    return [self alarmWithHour:12 minutes:0];
}

+ (instancetype) alarmWithHour:(int)hr minutes:(int)minutes; {
    return [self alarmWithHour:hr minutes:minutes trackIndex:0];
}

+ (instancetype) alarmWithHour:(int)hr minutes:(int)minutes trackIndex:(int)index; {
    return [[Alarm alloc] initWithTime:[DateUtility dateWithHour:hr andMinutes:minutes] trackIndex:index];
}

- (void) setDayOfWeek:(int)dayIndex toBeOn:(BOOL)isOn; { //TODO: Fix this to work
    weekdays[dayIndex] = (isOn ? 1 : 0);
    //for(int index = 0; index < DAYS_PER_WEEK; index++) {
//        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
//    //    NSDateComponents * components = [[NSDateComponents alloc] init];
//        components.weekday = index;
//        components.hour = 7;
    
//            [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
//                UNNotificationRequest * req;
////                NSDictionary * info;
//                NSString * alarmId;
//                for(int i = 0; i < requests.count; i++) {
//                    req = requests[i];
//                    
//                    alarmId = req.content.userInfo[KEY_ENCODER_UUID];
//                    if(alarmId == self.uuid) {
//                        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[KEY_ENCODER_UUID]];
//                    }
//                }
//            }];
  //  }
}

+ (NSString*) snoozingIdentifier; {
    return @"Snoozing";
}

- (BOOL) getDayOfWeekIsOn:(int)dayOfWeek; {
    return weekdays[dayOfWeek] > 0;
}
@end
