//
//  AlarmListCell.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "AlarmListCell.h"
#import "TrackHelper.h"
#import "AppConstants.h"
#import "DateUtility.h"

@implementation AlarmListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithAlarm:(Alarm *)alarm {
    self.alarm = alarm;
    [self updateView];
}

- (void) updateView {
    self.timeLabel.text = [DateUtility hoursAndMinutesForDate:self.alarm.time];
    self.dayMeridianLabel.text = [DateUtility amPmString:self.alarm.time];
    self.alarmOnSwitch.on = self.alarm.active;
    self.nameLabel.text = [[TrackHelper sharedInstance] trackAt:self.alarm.meditationTrackIndex].trackName;
    self.daysTurnedOnLabel.text = [self getStringOfDaysForAlarm:self.alarm];
}

- (IBAction)alarmSwitchWasChanged:(UISwitch*)alarmSwitch;
{
    self.alarm.active = alarmSwitch.on;
}

- (NSString*) getStringOfDaysForAlarm: (Alarm*) alarm {
    NSArray * namesOfWeekdays = @[@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun"];
    NSMutableArray * days = [NSMutableArray array];
    
    for(int i = 0; i < DAYS_PER_WEEK; i++) {
        if([alarm getDayOfWeekIsOn:i]) {
            [days addObject:namesOfWeekdays[i]];
        }
    }
    NSString * string = [days componentsJoinedByString:@", "];
    return string;
}

@end
