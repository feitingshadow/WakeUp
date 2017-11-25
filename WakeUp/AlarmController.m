//
//  AlarmController.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "AlarmController.h"
#import "Settings.h"
#import "NotificationController.h"

@interface AlarmController()
@property (nonatomic, strong) NSMutableArray<Alarm*> * alarms;
@end

@implementation AlarmController

+ (AlarmController*) sharedInstance {
    static AlarmController * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AlarmController alloc] init];
        [sharedInstance privateInitialization];
    });
    return sharedInstance;
}

- (void) privateInitialization; {
    [self loadAlarmsFromDisk];
}

- (NSMutableArray *) getAlarms {
    return self.alarms;
}

- (Alarm*) getAlarmWithUuid:(NSString*)uuid;
{
    for(Alarm * a in self.alarms) {
        if([a.uuid isEqualToString:uuid]) {
            return a;
        }
    }
    return nil;
}

- (Alarm*) getAlarmAtIndex:(int)index;
{
    return self.alarms[index];
}

- (void) addAlarm:(Alarm*)alarm;
{
    [self.alarms addObject:alarm];
    [self save];
}

- (void) saveAlarm: (Alarm*)alarm atIndex:(int)i;
{
    [self.alarms replaceObjectAtIndex:i withObject:alarm];
    [self save];
}

- (BOOL) saveAlarmForEditing:(Alarm*)alarm; {
    NSInteger index =[self.alarms indexOfObject:alarm];
    if(index != NSNotFound) {
        [self saveAlarm:alarm atIndex:index];
        return YES;
    }
    return NO;
}

- (BOOL) deleteAlarm:(Alarm*)alarm; {
    
    NSInteger index = [self.alarms indexOfObject:alarm];
    if(index != NSNotFound) {
        return [self deleteAlarmAtIndex:index];
    }
    return NO;
}

- (BOOL) deleteAlarmAtIndex:(int)index;
{
    if(index < self.alarms.count) {
        [self.alarms removeObjectAtIndex:index];
        [self save];
        return YES;
    }
    return NO;
}

- (void) save; {
    [NotificationController removeAllAlarmNotifications];
    Alarm * a = nil;
    for(int i = 0; i < self.alarms.count; i++) {
        a = self.alarms[i];
        if(a.active) {
            [NotificationController sheduleNotificationForAlarm:a];
        }
    }
    [Settings setAllAlarms:self.alarms];
}

- (void) saveAlarms:(NSMutableArray*)alarms {
    if(alarms != nil) {
        [Settings setAllAlarms:alarms];
    }
}

- (void) loadAlarmsFromDisk {
    self.alarms = [Settings getAllAlarms];
}

@end
