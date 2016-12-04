//
//  ViewController.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModeManager.h"

@interface ViewController : UIViewController <AppModeManagerDelegate>
{
    
}

@property (nonatomic, weak) IBOutlet UILabel * snoozeLabel;
@property (nonatomic, weak) IBOutlet UILabel * swipeToStopAlarmLabel;
@property (nonatomic, weak) IBOutlet UILabel * timeRemainingLabel;
@property (nonatomic, weak) IBOutlet UILabel * theTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel * amLabel;
@property (nonatomic, weak) IBOutlet UILabel * currentSongNameLabel;
@property (nonatomic, weak) IBOutlet UIView * snoozeView;
@property (nonatomic, weak) IBOutlet UIView * iconsView;
@property (nonatomic, weak) IBOutlet UIButton * playPauseButton;
@property (nonatomic, weak) IBOutlet UIView * playPauseContainerView;
@property (nonatomic, weak) IBOutlet UIImageView * playPauseImageView;

- (IBAction)snoozeButtonPreseed:(UIButton*)button;
- (IBAction)playPausePressed:(UIButton*)button;
- (IBAction)swipeToStopSwiped;

- (IBAction)infoButtonPressed;


@end

