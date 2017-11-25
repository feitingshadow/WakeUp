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
#import "AppModeManager.h"
#import "AppConstants.h"

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
        [UNUserNotificationCenter currentNotificationCenter].delegate = sharedInstance;
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

+ (void) scheduleNotificationAtDate:(NSDateComponents*)dateComponents withBody:(NSString*)body title:(NSString*)title id:(NSString*)uniqueId soundName:(NSString*)soundName repeating:(BOOL)repeat {
   // if(date == nil) {
    //    int x = 5;
    //    x = x + x;
   // }
  //  NSDateComponents *alarmComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:date];
//    if(alarmComponents == nil) {
//        int x = 5;
//        x = x + x;
//    }
    
//    let n = 7
//    let nextTriggerDate = Calendar.current.date(byAdding: .day, value: n, to: Date())!
//    let comps = Calendar.current.dateComponents([.year, .month, .day], from: nextTriggerDate)
//    
//    let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
//    print(trigger.nextTriggerDate())
    
//    NSDate * d = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:dateComponents.day toDate:[NSDate date] options:NSCalendarMatchFirst];
    NSDateComponents* dateC = [[NSDateComponents alloc] init];
    dateC.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    dateC.hour = dateComponents.hour;
    dateC.minute = dateComponents.minute;
    dateC.weekday = dateComponents.weekday;
    
    UNCalendarNotificationTrigger * tri = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:YES];
    //UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:(60 * 60 * 24 * 7) repeats:YES];
   // UNCalendarNotificationTrigger * calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:repeat];
//    if(trigger == nil) {
//        int x = 5;
//        x = x + x;
//    }
    UNMutableNotificationContent * content = [UNMutableNotificationContent new];
    content.body = body;
    content.title = title;
    content.sound = [UNNotificationSound soundNamed:soundName];
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:uniqueId content:content trigger:tri];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

//Finish implementing this later.
+ (void) sheduleSnoozeForAlarm:(Alarm*)alarm;
{
    MeditationTrack * mt = [[TrackHelper sharedInstance] trackAt:alarm.meditationTrackIndex];
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [NotificationController scheduleNotificationAtDate:[NSDate dateWithTimeIntervalSinceNow:FIVE_MINUTES] withBody:[NSString stringWithFormat:@"Snooze Alarm: %@", mt.trackName] title:@"Snooze" id:[Alarm snoozingIdentifier] soundName:[[TrackHelper sharedInstance] chimeAt:0].filename repeating:NO];
}

+ (void) removeNotificationsWithIdentifier:(NSString*) identifier;
{
    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[identifier]];
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[identifier]];
}

+ (void) sheduleNotificationForAlarm:(Alarm*)alarm; {
    [self removeNotificationForAlarm:alarm];
    MeditationTrack * mt;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *alarmComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:alarm.time];
    

    for(int i = 0; i < DAYS_PER_WEEK; i++) {
        if([alarm getDayOfWeekIsOn:i]) {
            
            NSDate *now = [NSDate date];
            NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate: alarm.time];
            NSDateComponents *genericComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:now];

            [componentsForFireDate setYear:genericComponents.year];
            [componentsForFireDate setWeekOfYear:genericComponents.weekOfYear];
            [componentsForFireDate setDay:genericComponents.day];
            [componentsForFireDate setMonth:genericComponents.month];
            [componentsForFireDate setCalendar:calendar];
//            [componentsForFireDate setTimeZone:[NSTimeZone defaultTimeZone]];
            [componentsForFireDate setWeekday:i+1]; //undo for production
            [componentsForFireDate setHour: alarmComponents.hour];
            [componentsForFireDate setMinute: alarmComponents.minute];
            [componentsForFireDate setSecond:0];
//            [alarmComponents setWeekday:i+1];
            alarm.time = [calendar dateFromComponents:componentsForFireDate];
//            alarm.time = [componentsForFireDate date];
            mt = [[TrackHelper sharedInstance] trackAt:alarm.meditationTrackIndex];
            [NotificationController scheduleNotificationAtDate:componentsForFireDate withBody:[NSString stringWithFormat:@"Wake Up To: %@", mt.trackName] title:@"Wake Up!" id:alarm.uuid soundName:[[TrackHelper sharedInstance] chimeAt:0].filename repeating:YES];
        }
    }
//    [NotificationController scheduleNotificationAtDate:alarm.time withBody:[NSString stringWithFormat:@"Wake Up To: %@", mt.trackName] title:@"Wake Up!" id:alarm.uuid soundName:[[TrackHelper sharedInstance] chimeAt:0].filename repeating:YES];
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
    [self sendAlarmIDToPlay:notification.request.identifier];
    completionHandler(UNNotificationPresentationOptionNone);
}

//Called after the user taps the notification from the center, either cancel or diving-in to app.
- (void) userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    if(response.actionIdentifier == UNNotificationDismissActionIdentifier) {
        //User chose to do nothing. Don't schedule any alarms.
        [self sendAlarmIDToPlay:response.notification.request.identifier];
    } else if(response.actionIdentifier == UNNotificationDefaultActionIdentifier) {
        [self sendAlarmIDToPlay:response.notification.request.identifier];
    }
}

- (void) sendAlarmIDToPlay:(NSString*)alarmUUID {
    [NotificationController clearAllSeenNotifications];
    Alarm * tempAlarm = [[AlarmController sharedInstance] getAlarmWithUuid: alarmUUID];
    if(tempAlarm != nil) {
        [[AppModeManager sharedInstance] startPlayingAlarm:tempAlarm];
    } else {
        DLOG(@"Alarm ID Not Found");
    }
}
@end
