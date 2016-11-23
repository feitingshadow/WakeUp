//
//  DateUtility.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "DateUtility.h"

static NSDateFormatter * dateFormatter = nil;

@implementation DateUtility

+ (void) initialize {
    dateFormatter = [[NSDateFormatter alloc] init];
}

+ (NSString *)hoursAndMinutesForDate:(NSDate *)date {
    dateFormatter.dateFormat = @"HH:mm";
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)amPmString:(NSDate *)date {
    dateFormatter.dateFormat = @"a";
    return [dateFormatter stringFromDate:date];
}


@end
