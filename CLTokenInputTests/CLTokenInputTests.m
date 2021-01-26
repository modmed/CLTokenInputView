//
//  CLTokenInputTests.m
//  CLTokenInputTests
//
//  Created by Andrew Wooster on 5/4/16.
//  Copyright © 2016 Cluster Labs, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CLTokenInput/CLTokenInput.h>

@interface CLTokenInputTests : XCTestCase

@end

@implementation CLTokenInputTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCLToken {
    CLToken *token = [[CLToken alloc] initWithDisplayText:@"display text" context:nil];
    XCTAssertEqualObjects(token.displayText, @"display text");
}

@end
