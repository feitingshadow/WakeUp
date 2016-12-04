//
//  UILabel.m
//  WakeUp
//
//  Created by Stephen Johnson on 12/1/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "UIView+Layout.h"
#import "NSObject+Extension.h"

static NSString * const kLeftMargin = @"LeftMargin";
static NSString * const kRightMargin = @"RightMargin";
static NSString * const kTopMargin = @"TopMargin";
static NSString * const kBottomMargin = @"BottomMargin";

@implementation UIView (Layout)

@dynamic topMargin;
@dynamic bottomMargin;
@dynamic leftMargin;
@dynamic rightMargin;

- (void) associateFloat:(CGFloat)f withKey:(NSString*)key {
    [self associateObject:[NSNumber numberWithFloat:f] withKey:(void*)key];
}

- (CGFloat) getAssociatedFloatWithKey:(NSString*)key {
    return ((NSNumber*)[self associatedObjectForKey:(void*)key]).floatValue;
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    [self associateFloat:leftMargin withKey:kLeftMargin];
}

- (CGFloat)leftMargin {
    return [self getAssociatedFloatWithKey:kLeftMargin];
}

- (void)setRightMargin:(CGFloat)value {
    [self associateFloat:value withKey:kRightMargin];
}

- (CGFloat)rightMargin {
    return [self getAssociatedFloatWithKey:kRightMargin];
}

- (void)setBottomMargin:(CGFloat)value {
    [self associateFloat:value withKey:kBottomMargin];
}

- (CGFloat)bottomMargin {
    return [self getAssociatedFloatWithKey:kBottomMargin];
}

- (void)setTopMargin:(CGFloat)value {
    [self associateFloat:value withKey:kTopMargin];
}

- (CGFloat)topMargin {
    return [self getAssociatedFloatWithKey:kTopMargin];
}
@end
