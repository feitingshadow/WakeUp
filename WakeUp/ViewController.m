//
//  ViewController.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "ViewController.h"
#import "DateUtility.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>

@interface ViewController () {
    CGPoint swipeToStopLabelOriginPt;
    CGPoint lastDelta; //for measuring velocity of flick
    CGPoint flickThresholdDelta; //for measuring velocity of flick
    CGFloat distanceThresholdDelta; //for measuring velocity of flick
    BOOL isSliding;
}
@end

@implementation ViewController

#pragma mark - View Functions Standard

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AppModeManager sharedInstance] setAppModeDelegate:self];
    [self updateUI];
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
       dispatch_async(dispatch_get_main_queue(), ^{
           if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
           {
               [self updateUI];
           }
       });
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initializeInnerFields];
    [self AppModeManager:nil didChangeToMode:[[AppModeManager sharedInstance] currentAppMode]];
}
- (void) initializeInnerFields; {
    swipeToStopLabelOriginPt = self.swipeToStopAlarmLabel.center;
    flickThresholdDelta = CGPointMake(2.0f, 0);
    distanceThresholdDelta = 25.0f;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)snoozeButtonPreseed:(UIButton*)button;
{
    [[AppModeManager sharedInstance] snooze];
}

- (IBAction)playPausePressed:(UIButton*)button;
{
    //TODO: Implement didEndNotification
    if([[AudioMgr sharedInstance] getCurrentAudioPlayer].isPlaying) {
        [[AudioMgr sharedInstance] pauseCurrentTrack];
    } else {
        [[AudioMgr sharedInstance] playTrack];
    }
    [self updatePlayPauseButton];
}

- (IBAction)swipeToStopSwiped;
{
    
}

- (void)infoButtonPressed
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myController = [storyBoard instantiateViewControllerWithIdentifier:@"Information"];//
    [self.navigationController pushViewController:myController animated:YES];
}

- (void)AppModeManager:(AppModeManager *)appModeManager didChangeToMode:(AppMode)theMode {
    self.iconsView.hidden = YES;
    self.snoozeView.hidden = YES;
    self.currentSongNameLabel.hidden = YES;
    self.timeRemainingLabel.hidden = YES;
    self.swipeToStopAlarmLabel.hidden = YES;
    self.playPauseContainerView.hidden = YES;
    if(theMode == AppModeNotPlaying) {
        self.iconsView.hidden = NO;
    } else if (theMode == AppModeSnooze) {
        //Snooze = time + remaining label with "Snoozing"
        self.timeRemainingLabel.hidden = NO; //Set Text to:
    } else { // playing
        self.swipeToStopAlarmLabel.hidden = NO;
        self.snoozeView.hidden = NO;
        self.currentSongNameLabel.hidden = NO;
        self.timeRemainingLabel.hidden = NO;
        self.playPauseContainerView.hidden = YES;
    }
}

- (void) updateUI {
    NSDate * nowDate = [NSDate date];
    self.theTimeLabel.text = [DateUtility hoursAndMinutesForDate:nowDate];
    self.amLabel.text = [DateUtility amPmString:nowDate];
    AppMode mode = [[AppModeManager sharedInstance] currentAppMode];
    if(mode == AppModeNotPlaying) {
        //It is considered playing if it is paused, because it's about the alarm, not the track. Do not alter the play/pause button here.
    } else {
        if(mode == AppModeSnooze) {
            //PlayPause button?
        } else {
            //AppMode = Playing.
        }
        Alarm * alarm = [[AppModeManager sharedInstance] currentAlarm];
        MeditationTrack * track = [[TrackHelper sharedInstance] trackAt:alarm.meditationTrackIndex];
        NSTimeInterval remainingInterval = [[AudioMgr sharedInstance] timeRemainingOnCurrentTrack];
        NSString * timeRemaining = [DateUtility minutesAndSecondsForInterval:remainingInterval];
        self.timeRemainingLabel.text = timeRemaining;
        self.currentSongNameLabel.text = track.trackName;
        [self updatePlayPauseButton];
        
    }
}

- (void) updatePlayPauseButton {
    AudioMgr * audioManager = [AudioMgr sharedInstance];
    AVAudioPlayer * player = [audioManager getCurrentAudioPlayer];
    if(player != nil) {
        self.playPauseContainerView.hidden = NO;
        if(player.isPlaying) {
            self.playPauseImageView.image = [UIImage imageNamed:@"PauseButton"];
        } else {
            self.playPauseImageView.image = [UIImage imageNamed:@"PlayButton"];
            if([audioManager isStopped]) {
                
            }
            else if([audioManager isPaused]) {
                
            }
        }
    } else {
        self.playPauseContainerView.hidden = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(self.swipeToStopAlarmLabel.hidden == NO) {
        isSliding = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(isSliding) {
        CGPoint currentPoint = [touches.anyObject locationInView:self.view];
        CGPoint lastPoint = [touches.anyObject previousLocationInView:self.view];
        CGPoint delta = CGPointMake(currentPoint.x - lastPoint.x, currentPoint.y - lastPoint.y);
        self.swipeToStopAlarmLabel.center = CGPointMake(self.swipeToStopAlarmLabel.center.x + delta.x, self.swipeToStopAlarmLabel.center.y );
        lastDelta = delta;
    }
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(isSliding) {
        CGPoint viewCtr = self.swipeToStopAlarmLabel.center;
        __weak ViewController * weakSelf = self;

        if(lastDelta.x > flickThresholdDelta.x && fabs (viewCtr.x - swipeToStopLabelOriginPt.x)) {
            int direction = (lastDelta.x > 0) ? 1 : -1;
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                weakSelf.swipeToStopAlarmLabel.center = CGPointMake(viewCtr.x + direction * self.swipeToStopAlarmLabel.frame.size.width, viewCtr.y);
                weakSelf.swipeToStopAlarmLabel.alpha = 0;
                
            } completion:^(BOOL finished) {
                [[AppModeManager sharedInstance] stopPlaying];
                weakSelf.swipeToStopAlarmLabel.center = swipeToStopLabelOriginPt;
                weakSelf.swipeToStopAlarmLabel.alpha = 1;
            }];
        } else {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                weakSelf.swipeToStopAlarmLabel.center = swipeToStopLabelOriginPt;
            } completion:^(BOOL finished) { }];
        }
    }
    isSliding = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}


@end
