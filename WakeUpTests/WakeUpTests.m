//
//  WakeUpTests.m
//  WakeUpTests
//
//  Created by Stephen Johnson on 11/22/16.
//  Copyright © 2016 Nazca. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrackHelper.h"

@interface WakeUpTests : XCTestCase

@end

@implementation WakeUpTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testCanLoadTracks {
    XCTAssert( ([[TrackHelper sharedInstance] getTracks].count > 0), @"Can't load tracks");
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
