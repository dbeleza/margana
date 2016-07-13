//
//  MarganaTests.m
//  MarganaTests
//
//  Created by David Beleza on 13/07/16.
//  Copyright © 2016 David Beleza. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewModel.h"

@interface MarganaTests : XCTestCase

@end

@implementation MarganaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHaveResults {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    ViewModel *vm = [[ViewModel alloc] init];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"ana", @"nAA", @"aAN", @"Test", nil];
    
    
    XCTestExpectation *authenticateExpectation = [self expectationWithDescription:@"Get comparison result"];
    
    [vm getAnagramList:mArray withString:@"Ana" afterCompletion:^(NSMutableArray *arrayAnagram) {
       
        
        XCTAssertTrue(arrayAnagram.count==3, @"Error: Result not equal to 3");
        
        [authenticateExpectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        XCTAssertNil(error);
        
    }];
    
}


- (void)testHaveNoResults {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    ViewModel *vm = [[ViewModel alloc] init];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"ana", @"nAA", @"aAN", @"Test", nil];
    
    
    XCTestExpectation *authenticateExpectation = [self expectationWithDescription:@"Get comparison result"];
    
    [vm getAnagramList:mArray withString:@"John" afterCompletion:^(NSMutableArray *arrayAnagram) {
        
        
        XCTAssertTrue(arrayAnagram.count==0, @"Error: Result not equal to 3");
        
        [authenticateExpectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        XCTAssertNil(error);
        
    }];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
