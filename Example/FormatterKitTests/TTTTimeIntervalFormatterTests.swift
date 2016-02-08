//
//  TTTTimeIntervalFormatterTests.swift
//  FormatterKit Example
//
//  Created by Victor Ilyukevich on 2/7/16.
//  Copyright © 2016. All rights reserved.
//

import XCTest
@testable import FormatterKit_Example

class TTTTimeIntervalFormatterTests: XCTestCase {

    var formatter = TTTTimeIntervalFormatter()

    func testOneMinuteFromNow() {
        let from = NSDate()
        let to = from.dateByAddingTimeInterval(60)
        let result = formatter.stringForTimeIntervalFromDate(from, toDate: to)

        XCTAssertEqual(result, "1 minute from now")
    }

    func testOneMinuteAgo() {
        let from = NSDate()
        let to = from.dateByAddingTimeInterval(-60)
        let result = formatter.stringForTimeIntervalFromDate(from, toDate: to)

        XCTAssertEqual(result, "1 minute ago")
    }

    func testNow() {
        let date = NSDate()
        let result = formatter.stringForTimeIntervalFromDate(date, toDate: date)

        XCTAssertEqual(result, "just now")
    }

    func testSingularSecond() {
        let from = NSDate()
        let to = from.dateByAddingTimeInterval(1)
        let result = formatter.stringForTimeIntervalFromDate(from, toDate: to)

        XCTAssertEqual(result, "1 second from now")
    }

    func testPluralSeconds() {
        let from = NSDate()
        let to = from.dateByAddingTimeInterval(2)
        let result = formatter.stringForTimeIntervalFromDate(from, toDate: to)

        XCTAssertEqual(result, "2 seconds from now")
    }

}
