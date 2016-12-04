//
//  AlignedLabel.h
//  WakeUp
//
//  Created by Stephen Johnson on 12/2/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AlignedLabel : UILabel

@property (nonatomic, assign) IBInspectable BOOL sizesToFit;
@property (nonatomic, weak) IBOutlet UIView * rightAttachedView;
@property (nonatomic, weak) IBOutlet UIView * lowerAttachedView;

@end
