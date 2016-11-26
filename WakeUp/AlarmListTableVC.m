//
//  AlarmListTableVC.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "AlarmListTableVC.h"
#import "AlarmListCell.h"
#import "AlarmController.h"
#import "WakeUpMakeAlarmVC.h"

@interface AlarmListTableVC ()
@property (nonatomic, strong) Alarm * currentAlarm;
@end

@implementation AlarmListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Add the Edit button to the right of the back button. Do in code to maintain the automatic Done/Edit switch.
    NSMutableArray * totalItems = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [totalItems insertObject:self.editButtonItem atIndex:1];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithArray:totalItems];
    self.tableView.allowsSelectionDuringEditing = YES;
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    if(self.tableView.isEditing) {
        [self.tableView setEditing:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) backButtonTapped;
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[AlarmController sharedInstance] getAlarms].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlarmListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmCell" forIndexPath:indexPath];
    [cell setupWithAlarm:[[AlarmController sharedInstance] getAlarmAtIndex:indexPath.row]];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (IBAction) toggleEditMode;
{
    [self.tableView setEditing:!self.tableView.isEditing];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[AlarmController sharedInstance] deleteAlarmAtIndex:indexPath.row];
        self.currentAlarm = nil;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.isEditing) {
        //Navigate to alarm screen
        [self goToAlarmEditScreenForIndex:indexPath.row];
    } else {
        //nothing
    }
}

- (void) goToAlarmEditScreenForIndex:(int)ind {
    self.currentAlarm = [[AlarmController sharedInstance] getAlarmAtIndex:ind];
    [self performSegueWithIdentifier:@"EditAlarm" sender:self];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(self.tableView.isEditing) {
        [self setEditing:NO];
        if(self.currentAlarm != nil) {
            UIViewController * vc = [segue destinationViewController];
            if([vc isKindOfClass:[WakeUpMakeAlarmVC class]]) {
                WakeUpMakeAlarmVC * wakeUpVC = (WakeUpMakeAlarmVC*)vc;
                [wakeUpVC setupWithAlarm: self.currentAlarm];
            }
        }
    }
}


@end
