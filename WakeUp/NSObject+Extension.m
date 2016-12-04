//
//  NSObject+Extension.m
//  WakeUp
//
//  Created by Stephen Johnson on 12/2/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (void)associateObject:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (id)associatedObjectForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

@end
