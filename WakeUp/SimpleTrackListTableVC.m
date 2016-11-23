//
//  SimpleTrackListTableVC.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "SimpleTrackListTableVC.h"
#import "SimpleListCell.h"
#import "TrackHelper.h"
#import "Settings.h"
#import "AudioMgr.h"

@interface SimpleTrackListTableVC () {
    int lastSelectedRow;
}
@end

@implementation SimpleTrackListTableVC

- (void)viewDidLoad {
    lastSelectedRow = -1;
    [super viewDidLoad];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[AudioMgr sharedInstance] stopTrack];
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
    
    SimpleListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleListCell" forIndexPath:indexPath];
    [cell setupWithTrack:(MeditationTrack*)[[TrackHelper sharedInstance] getTracks][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(lastSelectedRow != indexPath.row) {
        AudioMgr * audioMgr = [AudioMgr sharedInstance];
        [audioMgr stopTrack];
        MeditationTrack * medTrack = (MeditationTrack*)[[TrackHelper sharedInstance] getTracks][indexPath.row];
        [audioMgr setNextTrack:medTrack.fileURL];
        [audioMgr playTrack];
    }
    lastSelectedRow = indexPath.row;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
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
