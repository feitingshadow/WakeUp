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

@interface SimpleTrackListTableVC ()

@end

@implementation SimpleTrackListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
