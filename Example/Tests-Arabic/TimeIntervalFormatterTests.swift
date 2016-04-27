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
        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 ثانية منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 دقيقة منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 ساعات منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 يوم منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 ايام منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 اشهر منذ")
    }

    func testStandardFuture() {
        XCTAssertEqual(formatter.stringForTimeInterval(1), "1 ثانية منذ الآن")
        XCTAssertEqual(formatter.stringForTimeInterval(100), "1 دقيقة منذ الآن")
        XCTAssertEqual(formatter.stringForTimeInterval(10000), "2 ساعات منذ الآن")
        XCTAssertEqual(formatter.stringForTimeInterval(100000), "1 يوم منذ الآن")
        XCTAssertEqual(formatter.stringForTimeInterval(200000), "2 ايام منذ الآن")
        XCTAssertEqual(formatter.stringForTimeInterval(10000000), "3 اشهر منذ الآن")
    }

    func testIdiomaticPast() {
        formatter.usesIdiomaticDeicticExpressions = true

        XCTAssertEqual(formatter.stringForTimeInterval(-1), "1 ثانية منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-100), "1 دقيقة منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000), "2 ساعات منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-100000), "1 يوم منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-200000), "2 ايام منذ")
        XCTAssertEqual(formatter.stringForTimeInterval(-10000000), "3 اشهر منذ")
    }
    
}
