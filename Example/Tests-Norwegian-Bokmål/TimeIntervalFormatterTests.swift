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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 sekund siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 minutt siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 timer siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 dag siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 dager siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 måneder siden")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1 sekund fra nå")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1 minutt fra nå")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2 timer fra nå")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1 dag fra nå")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2 dager fra nå")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3 måneder fra nå")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 sekund siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 minutt siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 timer siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 dag siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 dager siden")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 måneder siden")
    }
    
}
