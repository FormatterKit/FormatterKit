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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "vor 1 Sekunde")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "vor 1 Minute")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "vor 2 Stunden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "vor 1 T.")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "vor 2 T.")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "vor 3 Monaten")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "in 1 Sekunde")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "in 1 Minute")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "in 2 Stunden")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "in 1 T.")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "in 2 T.")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "in 3 Monaten")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "vor 1 Sekunde")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "vor 1 Minute")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "vor 2 Stunden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "vor 1 T.")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "vor 2 T.")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "vor 3 Monaten")
    }
    
}
