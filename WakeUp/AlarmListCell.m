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

/* timeLabel;
 daysTurnedOnLabe
 nameLabel;
 alarmOnSwitch;*/

- (void)setupWithAlarm:(Alarm *)alarm {
    self.timeLabel.text = [DateUtility hoursAndMinutesForDate:alarm.time];
    self.alarmOnSwitch.on = alarm.active;
    self.nameLabel.text = [[TrackHelper sharedInstance] trackAt:alarm.meditationTrackIndex].trackName;
    self.daysTurnedOnLabel.text = [self getStringOfDaysForAlarm:alarm];
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
//    for(int i = 0; i < days.count - 1; i++) {
//    }
    return string;
}

@end
