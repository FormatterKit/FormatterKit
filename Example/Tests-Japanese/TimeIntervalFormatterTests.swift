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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 秒前 ")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 分前 ")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 時間前 ")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 日前 ")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 日前 ")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 ヵ月前 ")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1 秒後 ")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1 分後 ")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2 時間後 ")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1 日後 ")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2 日後 ")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3 ヵ月後 ")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 秒前 ")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 分前 ")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 時間前 ")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "昨日")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 日前 ")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 ヵ月前 ")
    }
    
}
