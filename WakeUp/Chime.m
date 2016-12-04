//
//  Chime.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/30/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "Chime.h"
@interface Chime()
@property (nonatomic, copy) NSString * path;
@end

@implementation Chime

- (void) setFilename:(NSString *)filename
{
    _filename = filename;
    self.path = [[NSBundle mainBundle] pathForResource:_filename ofType:@""];
}

@end
