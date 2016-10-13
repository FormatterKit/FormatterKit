//
//  TimeIntervalFormatterTests.swift
//  Tests-English
//
//  Created by Victor Ilyukevich on 2/7/16.
//  Copyright © 2016. All rights reserved.
//

import XCTest
import FormatterKit

class TTTTimeIntervalFormatterTests: XCTestCase {

    var formatter: TTTTimeIntervalFormatter!

    override func setUp() {
        super.setUp()
        formatter = TTTTimeIntervalFormatter()
    }

    // MARK: Tests

    func testIdiomaticDeictic() {
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 day ago")
        formatter.usesIdiomaticDeicticExpressions = true
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "yesterday")
    }

    func testCustomPresentTenseDeicticExpression() {
        XCTAssertEqual(formatter.string(forTimeInterval: 0), "just now")
        formatter.presentDeicticExpression = "seconds ago"
        XCTAssertEqual(formatter.string(forTimeInterval: 0), "seconds ago")
    }

    func testExpandingTimeIntervalForPresentTense() {
        XCTAssertEqual(formatter.string(forTimeInterval: -3), "3 seconds ago")
        formatter.presentTimeIntervalMargin = 10
        XCTAssertEqual(formatter.string(forTimeInterval: -3), "just now")
    }

    // MARK: Present

    func testNow() {
        XCTAssertEqual(formatter.string(forTimeInterval: 0), "just now")
    }

    // MARK: Past

    func testSecondsAgo() {
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 second ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -59), "59 seconds ago")
    }

    func testMinutesAgo() {
        XCTAssertEqual(formatter.string(forTimeInterval: -60), "1 minute ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 minute ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -120), "2 minutes ago")
    }

    func testHoursAgo() {
        XCTAssertEqual(formatter.string(forTimeInterval: -3600), "1 hour ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -8000), "2 hours ago")
    }

    func testDaysAgo() {
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24), "1 day ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -(3600 * 48 - 1)), "1 day ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 48), "2 days ago")
    }

    func testWeeksAgo() {
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 7), "1 week ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 10), "1 week ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 14), "2 weeks ago")
    }

    func testMonthsAgo() {
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 31), "1 month ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 70), "2 months ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 364), "11 months ago")
    }

    func testYearsAgo() {
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 366), "1 year ago")
        XCTAssertEqual(formatter.string(forTimeInterval: -3600 * 24 * 2000), "5 years ago")
    }

    func testAWeekBetweenTwoDatesInPast() {
        let from = Date(timeIntervalSince1970: 1396281600)  // April 1, 2014 00:00 UTC -08:00
        let to = from.addingTimeInterval(-(3600 * 24 * 7)) // 1 week ago
        let result = formatter.stringForTimeInterval(from: from, to: to)

        XCTAssertEqual(result, "1 week ago")
    }

    // MARK: Future

    func testSecondsFromNow() {
        XCTAssertEqual(formatter.string(forTimeInterval: 3), "3 seconds from now")
    }

    func testMinutesFromNow() {
        XCTAssertEqual(formatter.string(forTimeInterval: 60 * 21), "21 minutes from now")
    }

    func testHoursFromNow() {
        XCTAssertEqual(formatter.string(forTimeInterval: 3600), "1 hour from now")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 2), "2 hours from now")
    }

    func testDaysFromNow() {
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24), "1 day from now")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 6), "6 days from now")
    }

    func testWeeksFromNow() {
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 7), "1 week from now")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 25), "3 weeks from now")
    }

    func testMonthsFromNow() {
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 32), "1 month from now")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 31 * 6), "6 months from now")
    }

    func testYearsFromNow() {
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 366), "1 year from now")
        XCTAssertEqual(formatter.string(forTimeInterval: 3600 * 24 * 366 * 2), "2 years from now")
    }
}
