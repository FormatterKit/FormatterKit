//
//  TTTTimeIntervalFormatterTests.swift
//  FormatterKit
//
//  Created by Victor Ilyukevich on 4/27/16.
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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "לפני 1 שנייה")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "לפני 1 דקה")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "לפני 2 שעות")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "לפני 1 יום")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "לפני 2 ימים")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "לפני 3 חודשים")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "מעכשיו 1 שנייה")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "מעכשיו 1 דקה")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "מעכשיו 2 שעות")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "מעכשיו 1 יום")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "מעכשיו 2 ימים")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "מעכשיו 3 חודשים")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "לפני 1 שנייה")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "לפני 1 דקה")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "לפני 2 שעות")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "אתמול")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "שלשום")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "לפני 3 חודשים")
    }
    
}
