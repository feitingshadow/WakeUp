//
//  Settings.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "Settings.h"
#import "AppConstants.h"

@implementation Settings

+(id) userDefaultsObjectForKey:(NSString*)k defaultingTo:(id)objectIfNil {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:k];
    if(obj == nil) {
        obj = objectIfNil;
    }
    return obj;
}

+ (BOOL) getDidUnlockTracks;
{
    return NO; //Implement
}

+ (void) setDidUnlockTracks:(BOOL) unlocked;
{
    if(unlocked) {
        //Implement
    }
}

+ (NSMutableArray*) getAllAlarms;
{
    NSData * data = [self userDefaultsObjectForKey:KEY_ALARMS defaultingTo:nil];
    if(data != nil) {
        return (NSMutableArray*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return [NSMutableArray array];
}

+ (void) setAllAlarms:(NSMutableArray*)alarmArray;
{
    if(alarmArray != nil) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:alarmArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:KEY_ALARMS];
    }
}

+ (int) getLastStoredTrackIndex; {
    return [[NSUserDefaults standardUserDefaults] integerForKey:KEY_LAST_SELECTED_INDEX];
}

+ (void) setLastStoredTrackIndex:(int)ind; {
    [[NSUserDefaults standardUserDefaults] setInteger:ind forKey:KEY_LAST_SELECTED_INDEX];
}

@end
