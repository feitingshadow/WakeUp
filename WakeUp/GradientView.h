//
//  GradientView.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface GradientView : UIView //Simple top-down gradient
@property (nonatomic, strong) IBInspectable UIColor * toColor;
@property (nonatomic, strong) IBInspectable UIColor * fromColor;

@end
