//
//  AppConstants.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

/**********************
 SETTINGS
 *********************/
#define KEY_ALARMS @"Alarm"
#define KEY_LAST_SELECTED_INDEX @"LastSelIndex"

/**********************
 NOTIFICATIONS
 *********************/
#define NOTE_ALARMS_UPDATE @"UpdateAlarm"

/**********************
 SOUND BITE
 *********************/
#define SOUND_CHIMES @"00 - Alarm Chimes.mp3"

/**********************
 TIME CONSTANTS
 *********************/
#define SECONDS_PER_MINUTE  60
#define DAYS_PER_WEEK       7
#define FIVE_MINUTES        300

#define DATE_INDEX_SUNDAY       0 //+1 for NSCalendarComponent, begins at 1.
#define DATE_INDEX_MONDAY       1
#define DATE_INDEX_TUESDAY      2
#define DATE_INDEX_WEDNESDAY    3
#define DATE_INDEX_THURSDAY     4
#define DATE_INDEX_FRIDAY       5
#define DATE_INDEX_SATURDAY     6


/**********************
 DEBUG TOOL
 *********************/
#ifdef DEBUG
#define DLOG(x) NSLog(x)
#define DLOG_ARGS(x,...) NSLog(x, __VA_ARGS__)
#else 
#define DLOG(x)
#define DLOG_ARGS(x,...) 
#endif //DEBUG

#endif /* AppConstants_h */
