//
//  TimeIntervalFormatterTests.swift
//  Tests-Spanish
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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "hace 1 segundo")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "hace 1 minuto")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "hace 2 horas")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "hace 1 día")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "hace 2 días")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "hace 3 meses")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "dentro de 1 segundo")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "dentro de 1 minuto")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "dentro de 2 horas")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "dentro de 1 día")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "dentro de 2 días")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "dentro de 3 meses")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "hace 1 segundo")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "hace 1 minuto")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "hace 2 horas")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "ayer")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "antes de ayer")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "hace 3 meses")
    }

}
