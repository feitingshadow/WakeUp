//
//  DateUtility.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "DateUtility.h"

static NSDateFormatter * dateFormatter = nil;
static NSDateComponents * dateComponents = nil;

@implementation DateUtility

+ (void) initialize {
    dateFormatter = [[NSDateFormatter alloc] init];
    dateComponents = [[NSDateComponents alloc] init]; //be sure to manually reset any reused component

}

+ (NSString *)hoursAndMinutesForDate:(NSDate *)date {
    dateFormatter.dateFormat = @"HH:mm";
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)amPmString:(NSDate *)date {
    dateFormatter.dateFormat = @"a";
    return [dateFormatter stringFromDate:date];
}

+ (NSDate*) dateWithHour:(int)hour andMinutes:(int)min {
    dateComponents.hour = hour;
    dateComponents.minute = min;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateFromComponents:dateComponents];
}

@end
