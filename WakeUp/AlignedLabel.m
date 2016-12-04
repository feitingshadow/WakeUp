//
//  AlignedLabel.m
//  WakeUp
//
//  Created by Stephen Johnson on 12/2/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "AlignedLabel.h"
#import "NSObject+Extension.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Layout.h"

static NSString * const KEY_ORIGINAL_RECT = @"OrigRect";

@implementation AlignedLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self associateObject:[NSValue valueWithCGRect:self.frame] withKey:(void*)KEY_ORIGINAL_RECT];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if(self.sizesToFit) {
        CGRect originalFrame = self.frame;
        CGPoint originalCenter = self.center;
        [self sizeToFit];
//        ((NSValue*)[self associatedObjectForKey:(void*)KEY_ORIGINAL_RECT]).CGRectValue;
//        if(self.textAlignment == NSTextAlignmentLeft) {
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+font.ascender+ABS(font.descender))
            self.frame = CGRectMake(originalFrame.origin.x, originalFrame.origin.y, self.frame.size.width, self.frame.size.height);
//        }
        if(self.textAlignment == NSTextAlignmentCenter) {
            self.center = CGPointMake( originalCenter.x, self.center.y);
        }
    }
    if(self.rightAttachedView != nil) {
        CGRect rect = self.rightAttachedView.frame;
        self.rightAttachedView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width + self.rightMargin, rect.origin.y, rect.size.width, rect.size.height);
    }
    if(self.lowerAttachedView != nil) {
        CGRect rect = self.lowerAttachedView.frame;
        self.lowerAttachedView.frame = CGRectMake(rect.origin.x, self.frame.origin.y + self.frame.size.height + self.bottomMargin, rect.size.width, rect.size.height);
    }
}

@end
