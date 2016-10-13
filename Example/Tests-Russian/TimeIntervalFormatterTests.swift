//
//  TimeIntervalFormatterTests.swift
//  Tests-Russian
//
//  Created by Victor Ilyukevich on 4/25/16.
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

    func testStandardPast() {
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 секунда назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 минута назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 часов назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 день назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 дней назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 месяцев назад")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "1 секунда через")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "1 минута через")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "2 часов через")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "1 день через")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "2 дней через")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "3 месяцев через")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "1 секунда назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "1 минута назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "2 часов назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "1 день назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "2 дней назад")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "3 месяцев назад")
    }

}
