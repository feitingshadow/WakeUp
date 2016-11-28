//
//  NotificationController.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/27/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "NotificationController.h"
#import "TrackHelper.h"
#import "AlarmController.h"

@implementation NotificationController

- (instancetype) init {
    self = [super init];
    if(self) {
    }
    return self;
}

+ (NotificationController*) sharedInstance; //For handling the delegate methods, like fire when app is still active.
{
    static NotificationController * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NotificationController alloc] init];
        [NotificationController askForPermissionsWithSuccess:nil failure:nil];
    });
    return sharedInstance;
}

+ (void) askForPermissionsWithSuccess:(void (^)(void)) completion failure:(void (^)(NSError*))failure;
{
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if(settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions: (UNAuthorizationOptionAlert | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if(granted) {
                    if(completion != nil) {
                        completion();
                    }
                } else {
                    if(failure != nil) {
                        failure(error); //Permissions not granted.
                    }
                }
            }];
        }
        else {
            if(completion != nil) {
                completion(); //Authorized already
            }
        }
    }];
 
}

+ (void) sheduleNotificationForAlarm:(Alarm*)alarm; {
    [self removeNotificationForAlarm:alarm];
    
    NSDateComponents *alarmComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:alarm.time];
    UNCalendarNotificationTrigger * calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:alarmComponents repeats:YES];
    
    NSString * notificationMessage = [NSString stringWithFormat:@"Wake Up! Track: %@", [[TrackHelper sharedInstance] trackAt:alarm.meditationTrackIndex].trackName];
    UNMutableNotificationContent * content = [UNMutableNotificationContent new];
   
    content.body = notificationMessage;
    content.title = @"Wake Up";
    
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:alarm.uuid content:content trigger:calendarTrigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}

+ (void) removeNotificationForAlarm:(Alarm*)alarm {
    [self clearAllSeenNotifications];
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[alarm.uuid]];
}

+ (void) removeAllAlarmNotifications {
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
}

+ (void) clearAllSeenNotifications {
    [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
}

//Called while active
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    //AppMode Controller - start playing alarm.
    completionHandler(UNNotificationPresentationOptionNone);
}

//Called after the user taps the notification from the center, either cancel or diving-in to app.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    if(response.actionIdentifier == UNNotificationDismissActionIdentifier) {
        //User chose to do nothing. Don't schedule any alarms.
    } else if(response.actionIdentifier == UNNotificationDefaultActionIdentifier) {
        //User entered the app after tapping. Play even if it's been awhile? Probably, since they said to.
       Alarm * tempAlarm = [[AlarmController sharedInstance] getAlarmWithUuid: response.notification.request.identifier];
        if(tempAlarm != nil) {
            
        } else {
            
        }
    }
    [NotificationController clearAllSeenNotifications];
}
@end
