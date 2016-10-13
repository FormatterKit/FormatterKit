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
        XCTAssertEqual(formatter.string(forTimeInterval: -1), "há 1 segundo")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "há 1 minuto")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "há 2 horas")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "há 1 dia")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "há 2 dias")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "há 3 meses")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.string(forTimeInterval: 1), "em 1 segundo")
        XCTAssertEqual(formatter.string(forTimeInterval: 100), "em 1 minuto")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000), "em 2 horas")
        XCTAssertEqual(formatter.string(forTimeInterval: 100000), "em 1 dia")
        XCTAssertEqual(formatter.string(forTimeInterval: 200000), "em 2 dias")
        XCTAssertEqual(formatter.string(forTimeInterval: 10000000), "em 3 meses")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.string(forTimeInterval: -1), "há 1 segundo")
        XCTAssertEqual(formatter.string(forTimeInterval: -100), "há 1 minuto")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000), "há 2 horas")
        XCTAssertEqual(formatter.string(forTimeInterval: -100000), "há 1 dia")
        XCTAssertEqual(formatter.string(forTimeInterval: -200000), "há 2 dias")
        XCTAssertEqual(formatter.string(forTimeInterval: -10000000), "há 3 meses")
    }
    
}
