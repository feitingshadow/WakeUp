//
//  WakeUpMakeAlarmVC.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "WakeUpMakeAlarmVC.h"
#import "AppConstants.h"
#import "AlarmController.h"
#import "TrackHelper.h"
#import "AlarmChooseCell.h"
#import "Settings.h"
#import "AudioMgr.h"
#import "MeditationTrack.h"

@interface WakeUpMakeAlarmVC ()
@property (nonatomic, strong) Alarm * alarmForEditing;
@property (nonatomic, strong) MeditationTrack * trackChosen;
@end

@implementation WakeUpMakeAlarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.alarmForEditing == nil) {
        self.alarmForEditing = [Alarm alarm];
    }
    [self.weekdaySelectView setNumberOfButtons:7 withStrings:@[@"Sun",@"M",@"T",@"W",@"Th",@"F",@"Sat"]];
//    [self.weekdaySelectView setSelectedBackgroundImageForAllTo:[UIImage imageNamed:@"AlarmButton.png"]];
//    [self.weekdaySelectView setBackgroundImageForAllTo:[UIImage imageNamed:@"InfoButton.png"]];
    
    [self updateUI];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.alarmForEditing.meditationTrackIndex = [Settings getLastStoredTrackIndex];
    [self updateUI];
}

- (IBAction) saveTapped;
{
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)datePickerChanged:(UIDatePicker*)datePicker {
    self.alarmForEditing.time = datePicker.date;
}

- (void) setupWithAlarm:(Alarm*) alarm;
{
    self.alarmForEditing = alarm;
    self.editingAlarm = YES;
    [self updateUI];
}

- (void) updateUI; {
    self.trackChosen = [[TrackHelper sharedInstance] trackAt:self.alarmForEditing.meditationTrackIndex];
    self.trackTitleLabel.text = self.trackChosen.trackName;
    self.trackDescriptionLabel.text = self.trackChosen.trackDescription;
    [self.datePicker setDate:self.alarmForEditing.time];
    for (int d = 0; d < DAYS_PER_WEEK; d++) {
        BOOL selected = [self.alarmForEditing getDayOfWeekIsOn:d];
        [self.weekdaySelectView setSelected:selected atIndex:d];
    }
}

- (void) save; {
    self.alarmForEditing.active = YES;
    if(self.editingAlarm) {
        [[AlarmController sharedInstance] saveAlarmForEditing:self.alarmForEditing];
    } else {
        [[AlarmController sharedInstance] addAlarm:self.alarmForEditing];
    }
}

- (void) buttonIndex:(int)ind wasSelected:(BOOL)wasSelected {
    [self.alarmForEditing setDayOfWeek:ind toBeOn:wasSelected];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
