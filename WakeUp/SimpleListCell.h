//
//  SimpleListCell.h
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeditationTrack.h"

@interface SimpleListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UILabel * lengthLabel;
@property (nonatomic, weak) IBOutlet UILabel * descriptionLabel;
@property (nonatomic, weak) IBOutlet UIButton * pausePlayButton;
@property (nonatomic, weak) IBOutlet UISlider * trackProgressSlider;

- (void) setupWithTrack:(MeditationTrack*)track;
@end
