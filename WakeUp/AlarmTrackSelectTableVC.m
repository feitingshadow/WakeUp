//
//  AlarmTrackSelectTableVC.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "AlarmTrackSelectTableVC.h"
#import "AlarmController.h"
#import "TrackHelper.h"
#import "AlarmChooseCell.h"
#import "Settings.h"
#import "AudioMgr.h"
#import "MeditationTrack.h"

@interface AlarmTrackSelectTableVC ()
{
    int currentSelectedIndex;
}
@end

@implementation AlarmTrackSelectTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    currentSelectedIndex = 0;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [[TrackHelper sharedInstance] getNumberOfTracks];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlarmChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmChooserCell" forIndexPath:indexPath];
    [cell setupWithTrack:[[TrackHelper sharedInstance] trackAt:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [Settings setLastStoredTrackIndex:indexPath.row];
    
    if(indexPath.row != currentSelectedIndex) {
        currentSelectedIndex = indexPath.row;
        AudioMgr * audioMgr = [AudioMgr sharedInstance];
        [audioMgr stopTrack];
        MeditationTrack * medTrack = (MeditationTrack*)[[TrackHelper sharedInstance] getTracks][currentSelectedIndex];
        [audioMgr setNextTrack:medTrack.fileURL];
        [audioMgr playTrack];
    }
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
