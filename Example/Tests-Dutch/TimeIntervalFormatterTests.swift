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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 seconde geleden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 minuut geleden")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 uur geleden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 dag geleden")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 dagen geleden")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 maanden geleden")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1 seconde vanaf nu")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1 minuut vanaf nu")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2 uur vanaf nu")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1 dag vanaf nu")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2 dagen vanaf nu")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3 maanden vanaf nu")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 seconde geleden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 minuut geleden")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 uur geleden")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "gisteren")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "eergisteren")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 maanden geleden")
    }
    
}
