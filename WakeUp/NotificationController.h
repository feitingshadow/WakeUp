//
//  NotificationController.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/27/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"
#import <UserNotifications/UserNotifications.h>

@interface NotificationController : NSObject <UNUserNotificationCenterDelegate>

+ (NotificationController*) sharedInstance;

+ (void) askForPermissionsWithSuccess:(void (^)(void)) completion failure:(void (^)(NSError*))failure;
+ (void) sheduleNotificationForAlarm:(Alarm*)alarm;
+ (void) sheduleSnoozeForAlarm:(Alarm*)alarm;
+ (void) removeNotificationForAlarm:(Alarm*)alarm;
+ (void) clearAllSeenNotifications;
+ (void) removeAllAlarmNotifications;
+ (void) removeNotificationsWithIdentifier:(NSString*) identifier;

@end
