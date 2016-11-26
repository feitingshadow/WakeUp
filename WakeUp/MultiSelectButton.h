//
//  MultiSelectButton.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/25/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientView.h"

@interface MultiSelectButton : UIView
{
    BOOL selected;
}

@property (nonatomic, strong) IBInspectable UIColor * topColor;
@property (nonatomic, strong) IBInspectable UIColor * bottomColor; 
@property (nonatomic, strong) IBInspectable UIColor * selectedTopColor;
@property (nonatomic, strong) IBInspectable UIColor * selectedBottomColor;

@property (nonatomic, weak) IBOutlet UIButton * button;
@property (nonatomic, weak) IBOutlet GradientView * bgView;

- (void) setTitle:(NSString*) title forState:(UIControlState)state;
- (void) setSelected:(BOOL) selected;
- (BOOL) getIsSelected;

@end
