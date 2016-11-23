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
    return [self userDefaultsObjectForKey:KEY_ALARMS defaultingTo:[NSMutableArray array]];
//    return (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KEY_ALARMS];
}

+ (void) setAllAlarms:(NSMutableArray*)alarmArray;
{
    if(alarmArray != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:alarmArray forKey:KEY_ALARMS];
    }
}
@end
