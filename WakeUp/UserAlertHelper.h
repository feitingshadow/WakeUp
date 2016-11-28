//
//  UserAlertHelper.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/27/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAlertHelper : NSObject

- (void) showAlertWithTitle:(NSString*)t message:(NSString*)msg okText:(NSString*)okText;

@end
