//
//  ViewController.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View Functions Standard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    
}

- (IBAction)playPausePressed:(UIButton*)button;
{
    
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

#pragma mark - Helper Functions
- (void) setShowAlarmMode:(BOOL)on {
    if(on) {
        
    } else {
        
    }
}

@end
