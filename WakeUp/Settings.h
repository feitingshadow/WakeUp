//
//  Settings.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject
{
    
}

+ (NSMutableArray*) getAllAlarms;
+ (void) setAllAlarms:(NSMutableArray*)alarmArray;

+ (BOOL) getDidUnlockTracks;
+ (void) setDidUnlockTracks:(BOOL) unlocked;

@end
