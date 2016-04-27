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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1초 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1분 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2시간 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1일 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2일 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3달 전")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1초 지금으로부터")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1분 지금으로부터")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2시간 지금으로부터")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1일 지금으로부터")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2일 지금으로부터")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3달 지금으로부터")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1초 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1분 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2시간 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1일 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2일 전")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3달 전")
    }
    
}
