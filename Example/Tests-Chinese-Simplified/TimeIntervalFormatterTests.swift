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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1秒前")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1分钟前")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2小时前")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1天前")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2天前")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3月前")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1秒之后")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1分钟之后")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2小时之后")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1天之后")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2天之后")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3月之后")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1秒前")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1分钟前")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2小时前")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1天前")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2天前")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3月前")
    }
    
}
