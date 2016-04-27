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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "há 1 segundo")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "há 1 minuto")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "há 2 horas")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "há 1 dia")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "há 2 dias")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "há 3 meses")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "em 1 segundo")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "em 1 minuto")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "em 2 horas")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "em 1 dia")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "em 2 dias")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "em 3 meses")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "há 1 segundo")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "há 1 minuto")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "há 2 horas")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "há 1 dia")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "há 2 dias")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "há 3 meses")
    }
    
}
