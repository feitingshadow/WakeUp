//
//  AlarmController.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"

@interface AlarmController : NSObject
{
    
}

+ (AlarmController*) sharedInstance;

- (Alarm*) getAlarmAtIndex:(int)index;
- (Alarm*) getAlarmWithUuid:(NSString*)uuid;
- (NSMutableArray*) getAlarms;
- (void) saveAlarm: (Alarm*)alarm atIndex:(int)i;
- (void) saveAlarms:(NSMutableArray*)alarms;
- (BOOL) saveAlarmForEditing:(Alarm*)alarm; //returns false if can't find alarm
- (BOOL) deleteAlarm:(Alarm*)alarm;
- (BOOL) deleteAlarmAtIndex:(int)index;
- (void) addAlarm:(Alarm*)alarm;

@end
