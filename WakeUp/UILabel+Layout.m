//
//  UILabel.m
//  WakeUp
//
//  Created by Stephen Johnson on 12/1/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "UILabel+Layout.h"

@implementation UILabel (Layout)

@dynamic fontName;

- (void) setFontName:(NSString *)value {
    [self setFont:[UIFont fontWithName:value size:self.font.pointSize]];
    [self setNeedsLayout];
}

- (NSString*) fontName {
    return self.font.fontName;
}

@end
