//
//  UserAlertHelper.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/27/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "UserAlertHelper.h"

@implementation UserAlertHelper

+ (void) showAlertWithTitle:(NSString*)t message:(NSString*)msg presenter:(UIViewController*)presentingVC;
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:t message:msg preferredStyle:UIAlertControllerStyleAlert];
    [presentingVC presentViewController:alert animated:YES completion:nil];
}
@end
