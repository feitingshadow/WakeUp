//
//  MeditationTrack.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface MeditationTrack : NSObject

@property (nonatomic, copy) NSString * trackName;
@property (nonatomic, copy) NSString * trackDescription;
@property (nonatomic, copy) NSString * fileName;
@property (nonatomic, copy, readonly) NSString * filePath;

@property (nonatomic, readonly) CGFloat lengthInSeconds;

- (instancetype) initWithFileName:(NSString*)fileName trackname:(NSString*)trackName descr:(NSString*)description;

- (NSString*) lengthInStringFormat;

@end
