//
//  MultiSelectButton.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/25/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "MultiSelectButton.h"

@implementation MultiSelectButton

- (void) setTitle:(NSString*) title forState:(UIControlState)state;
{
    [self.button setTitle:title forState:state];
}

- (void) setSelected:(BOOL) sel; {
    selected = sel;
    self.bgView.fromColor = selected ? self.selectedTopColor : self.topColor;
    self.bgView.toColor = selected ? self.selectedBottomColor : self.bottomColor;
}

- (BOOL) getIsSelected; {
    return selected;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
