//
//  AlarmListCell.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alarm.h"

@interface AlarmListCell : UITableViewCell
{
    
}

@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UILabel * daysTurnedOnLabel;
@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UISwitch * alarmOnSwitch;

- (void) setupWithAlarm:(Alarm*) alarm;

@end
