//
//  WakeUpMakeAlarmVC.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alarm.h"
#import "MultiSelectView.h"

@interface WakeUpMakeAlarmVC : UIViewController <MultiSelectViewDelegate>
{
    
}

@property (nonatomic, weak) IBOutlet MultiSelectView * weekdaySelectView;
@property (nonatomic, weak) IBOutlet UIDatePicker * datePicker;
@property (nonatomic, weak) IBOutlet UILabel * trackTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel * trackDescriptionLabel;

@property (nonatomic, assign) BOOL editingAlarm; //creating if NO

- (void) setupWithAlarm:(Alarm*) alarm;

- (IBAction) saveTapped;

@end
