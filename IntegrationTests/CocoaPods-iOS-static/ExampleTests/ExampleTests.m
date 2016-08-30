//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Victor Ilyukevich on 5/21/16.
//  Copyright © 2016 Open Source. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface ExampleTests : XCTestCase

@end

@implementation ExampleTests

- (void)testFoo {
  AppDelegate *a = [AppDelegate new];
  XCTAssertEqualObjects(a.foo, @"vor 1 Stunde");
}

- (void)testNumberOfLocalizations {
  XCTAssertEqual([NSBundle mainBundle].localizations.count, 2);
}

@end
