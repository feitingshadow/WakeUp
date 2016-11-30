//
//  DateUtility.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtility : NSObject

+ (NSString*) hoursAndMinutesForDate:(NSDate*)date;
+ (NSString*) minutesAndSecondsForInterval:(NSTimeInterval)interval;
+ (NSString *)amPmString:(NSDate *)date;
+ (NSDate*) dateWithHour:(int)hour andMinutes:(int)min;
+ (NSString *)timeWithAmPmForDate:(NSDate *)date;

@end
