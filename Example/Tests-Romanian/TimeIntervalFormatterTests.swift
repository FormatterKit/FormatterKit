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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 secundă în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 minut în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 ore în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 zi în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 zile în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 luni în urmă")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1 secundă de acum")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1 minut de acum")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2 ore de acum")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1 zi de acum")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2 zile de acum")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3 luni de acum")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 secundă în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 minut în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 ore în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 zi în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 zile în urmă")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 luni în urmă")
    }
    
}
