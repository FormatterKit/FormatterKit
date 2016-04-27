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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 sekund sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 minut sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 timmar sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 dag sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 dagar sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 månader sedan")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1 sekund från nu")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1 minut från nu")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2 timmar från nu")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1 dag från nu")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2 dagar från nu")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3 månader från nu")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 sekund sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 minut sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 timmar sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 dag sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 dagar sedan")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 månader sedan")
    }
    
}
