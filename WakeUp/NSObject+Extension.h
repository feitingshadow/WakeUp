//
//  NSObject+Extension.h
//  WakeUp
//
//  Created by Stephen Johnson on 12/2/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (Extension)

- (void)associateObject:(id)value withKey:(void *)key;
- (id)associatedObjectForKey:(void *)key;

@end
