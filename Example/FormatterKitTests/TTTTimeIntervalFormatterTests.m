//
//  TTTTimeIntervalFormatter.m
//  FormatterKit Example
//
//  Created by Andrea Bizzotto on 18/04/2015.
//  Copyright (c) 2015 Gowalla. All rights reserved.
//

#import "TTTTimeIntervalFormatter.h"
#import <XCTest/XCTest.h>

@interface TTTTimeIntervalFormatterTests : XCTestCase

@property(strong, nonatomic) TTTTimeIntervalFormatter *formatter;
@property(strong, nonatomic) NSDate *referenceDate;

@end


@implementation TTTTimeIntervalFormatterTests

- (void)setUp {
    [super setUp];
    self.formatter = [TTTTimeIntervalFormatter new];
    self.referenceDate = [NSDate date];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - suffixes checks
- (void)checkSuffix:(NSString *)expectedSuffix forTimeInterval:(NSTimeInterval)timeInterval {

    NSDate *toDate = [self.referenceDate dateByAddingTimeInterval:timeInterval];
    NSString *observed = [self.formatter stringForTimeIntervalFromDate:self.referenceDate toDate:toDate];
    NSRange range = [observed rangeOfString:expectedSuffix];
    BOOL suffixFound = range.location != NSNotFound;
    XCTAssert(suffixFound, @"expected: %@", expectedSuffix);
}

- (void)testPositiveTimeIntervalSuffix {

    NSTimeInterval interval = 60;
    NSString *expectedSuffix = self.formatter.futureDeicticExpression;
    [self checkSuffix:expectedSuffix forTimeInterval:interval];
}

- (void)testNegativeTimeIntervalSuffix {

    NSTimeInterval interval = -60;
    NSString *expectedSuffix = self.formatter.pastDeicticExpression;
    [self checkSuffix:expectedSuffix forTimeInterval:interval];
}

- (void)testZeroTimeIntervalSuffix {

    NSTimeInterval interval = 0;
    NSString *expectedSuffix = self.formatter.presentDeicticExpression;
    [self checkSuffix:expectedSuffix forTimeInterval:interval];
}

#pragma mark - singular/plural
- (void)checkTimeUnit:(NSString *)timeUnit forTimeInterval:(NSTimeInterval)timeInterval {

    NSString *expected = [timeUnit stringByAppendingString:@" "];

    NSDate *toDate = [self.referenceDate dateByAddingTimeInterval:timeInterval];
    NSString *observed = [self.formatter stringForTimeIntervalFromDate:self.referenceDate toDate:toDate];
    NSRange range = [observed rangeOfString:expected];
    BOOL found = range.location != NSNotFound;
    XCTAssert(found, @"expected: %@", expected);
}
- (void)testSingularTimeUnit {
    NSTimeInterval interval = 1;
    NSString *singularUnit = @"second";
    [self checkTimeUnit:singularUnit forTimeInterval:interval];
}
- (void)testPluralTimeUnit {
    NSTimeInterval interval = 2;
    NSString *singularUnit = @"seconds";
    [self checkTimeUnit:singularUnit forTimeInterval:interval];
}

#pragma mark - second / minute / hour / day tests
- (void)testSecondMinuteHourDayUnits
{
    NSArray *units = @[@"second", @"minute", @"hour", @"day"];
    NSTimeInterval multiples[] = {1, 60, 60, 24};

    NSTimeInterval interval = 1;
    for (NSUInteger i = 0; i < 4; i++) {
        interval *= multiples[i];
        NSString *expected = units[i];
        [self checkTimeUnit:expected forTimeInterval:interval];
    }
}

@end
