//
//  InfoPageVC.m
//  WakeUp
//
//  Created by Stephen Johnson on 11/21/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import "InfoPageVC.h"

@interface InfoPageVC ()

@end

@implementation InfoPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * htmlString = @"<DOCTYPE! html><html><head><title></title></head><body><h1>This is text h1</h1><p>text</p></body></html>"; //load from file
    
    [self.theWebView loadHTMLString:htmlString baseURL:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
