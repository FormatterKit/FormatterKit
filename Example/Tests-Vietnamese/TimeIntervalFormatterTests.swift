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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 giây trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 phút trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 giờ trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 ngày trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 ngày trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 tháng trước")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1 giây từ bây giờ")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1 phút từ bây giờ")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2 giờ từ bây giờ")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1 ngày từ bây giờ")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2 ngày từ bây giờ")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3 tháng từ bây giờ")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 giây trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 phút trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 giờ trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 ngày trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 ngày trước")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 tháng trước")
    }
    
}
