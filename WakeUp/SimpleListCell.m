//
//  SimpleListCell.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "SimpleListCell.h"

@implementation SimpleListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma Mark - Custom Functions - Setup
- (void) setupWithTrack:(MeditationTrack*)track;
{
    self.nameLabel.text = track.trackName;
    self.lengthLabel .text = [track lengthInStringFormat]; //this is a good example of when to use KVO/data binding.
    self.descriptionLabel.text = track.trackDescription;
}

@end
