//
//  GradientView.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "GradientView.h"
#import <QuartzCore/QuartzCore.h>

@interface GradientView()
@end

@implementation GradientView

- (void) setToColor:(UIColor *)toColor {
    _toColor = toColor;
    [self setNeedsDisplay];
}

- (void) setFromColor:(UIColor *)fromColor {
    _fromColor = fromColor;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if(self.toColor != nil) {
        if(self.fromColor == nil) {
            self.fromColor = self.backgroundColor;
        }
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)@[(id)self.fromColor.CGColor, (id)self.toColor.CGColor], NULL);
        CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0,0), CGPointMake(0,self.bounds.size.height), kCGGradientDrawsBeforeStartLocation);
        CFRelease(colorSpace);
        CFRelease(gradient);
    }
}


@end
