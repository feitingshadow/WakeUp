//
//  MultiSelectButtonView.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/23/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "MultiSelectView.h"
#import "MultiSelectButton.h"

@interface MultiSelectView()
@property (nonatomic, strong) NSMutableArray * buttons;
@end

@implementation MultiSelectView

- (void) setNumberOfButtons:(uint) btnNumber withStrings:(NSArray*)textValues; {
    [self removeButtons];
    self.buttons = [NSMutableArray arrayWithCapacity:btnNumber];
    MultiSelectButton * tempInnerButton;
    for(int i = 0; i < btnNumber; i++) {
        tempInnerButton = (MultiSelectButton*)[[[NSBundle mainBundle] loadNibNamed:@"MultiSelectButton" owner:nil options:nil] objectAtIndex:0];
        tempInnerButton.tag = i;
        [tempInnerButton setTitle:(NSString*)textValues[i] forState:UIControlStateNormal];
        [tempInnerButton.button addTarget:self action:@selector(setButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [tempInnerButton setSelected:NO];
        [self.buttons addObject:tempInnerButton];
        [self addSubview:tempInnerButton];
    }
    [self setNeedsLayout];
}

- (IBAction) setButtonSelected:(UIButton*)sender; {
    MultiSelectButton * btn = (MultiSelectButton*)sender.superview;
    [btn setSelected:![btn getIsSelected]];
    if(self.delegate != nil && [self.delegate conformsToProtocol:@protocol(MultiSelectViewDelegate)] && [self.delegate respondsToSelector:@selector(buttonIndex:wasSelected:)]) {
        [self.delegate buttonIndex:btn.tag wasSelected:[btn getIsSelected]];
    }
}

- (void) setTitleForIndex:(int)ind to:(NSString*)title; {
    MultiSelectButton * tempInnerButton = [self viewWithTag:ind];
    if(tempInnerButton != nil) {
        [tempInnerButton.button setTitle:title forState:UIControlStateNormal];
    }
}

- (void) layoutSubviews {
    [super layoutSubviews];
    int numButtons = self.buttons.count;
    float width = self.frame.size.width/numButtons;
    float height = self.frame.size.height;
    UIView * tempInnerButton;
    for(int i = 0; i < numButtons; i++) {
        tempInnerButton = (UIView*)self.subviews[i];
        tempInnerButton.frame = CGRectMake(width * i, 0, width, height);
        tempInnerButton.tag = i;
    }

}


- (void) setBackgroundImageForAllTo:(UIImage*)img {
    for (MultiSelectButton * btn in self.buttons) {
        [btn.button setBackgroundImage:img forState:UIControlStateNormal];
    }
}

- (void) setSelectedBackgroundImageForAllTo:(UIImage*)img {
    for (MultiSelectButton * btn in self.buttons) {
//        [btn setBackgroundImage:img forState:UIControlStateSelected];
    }
}

- (BOOL) getIsSelectedAtIndex:(uint)ind; {
    MultiSelectButton * btn = (MultiSelectButton*)self.buttons[ind];
    return [btn getIsSelected];
}

- (void) setSelected:(BOOL)selected atIndex:(uint)ind;{
    MultiSelectButton * btn = (MultiSelectButton*)self.buttons[ind];
    [btn setSelected:selected];
}

- (void) removeButtons; {
    UIView * tempView = nil;
    for(int i = 0; i < self.buttons.count; i++) {
        tempView = (MultiSelectButton*)self.buttons[i];
        [tempView removeFromSuperview];
    }
    [self.buttons removeAllObjects];
}

- (oneway void) dealloc {
    self.delegate = nil;
}

//- (void) setBackgroundForButtonView:(UIView*)btn toView:(UIView*) v {
//    v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    v.frame = btn.bounds;
//    [v setTranslatesAutoresizingMaskIntoConstraints:YES];
//    [self removeBackgroundForButtonView:btn];
//    [btn addSubview:v];
//    [self ensureInnerButtonIsOnTopForButtonView:btn];
//}
//
//- (void) ensureInnerButtonIsOnTopForButtonView: (UIView*)btn {
//    UIView * tempView = nil;
//    for(int i = 0; i < btn.subviews.count; i++) {
//        tempView = btn.subviews[i];
//        if([tempView isKindOfClass:[UIButton class]]) {
//            [btn bringSubviewToFront:tempView];
//            break;
//        }
//    }
//}
//
//- (void) removeBackgroundForButtonView:(UIView*) btn {
//    UIView * tempView = nil;
//    for(int i = 0; i < btn.subviews.count; i++) {
//        tempView = btn.subviews[i];
//        if([tempView isKindOfClass:[UIButton class]]) {
//            continue;
//        }
//        [tempView removeFromSuperview];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
