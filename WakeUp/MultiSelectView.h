//
//  MultiSelectButtonView.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/23/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultiSelectViewDelegate <NSObject>
- (void) buttonIndex:(int)ind wasSelected:(BOOL)wasSelected;
@end

@interface MultiSelectView : UIView //Essentially fulfills the function of a checkbox
{
    
}

@property (nonatomic, weak) IBOutlet id<MultiSelectViewDelegate> delegate;

- (void) setNumberOfButtons:(uint) btnNumber withStrings:(NSArray*)textValues;
- (void) setSelectedBackgroundImageForAllTo:(UIImage*)img;
- (void) setBackgroundImageForAllTo:(UIImage*)img;
- (BOOL) getIsSelectedAtIndex:(uint)ind;
- (void) setSelected:(BOOL)selected atIndex:(uint)ind;

@end
